package com.sooRyeo.app.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Time;
import com.sooRyeo.app.domain.TimeTable;
import com.sooRyeo.app.dto.CourseInsertReqeustDTO;
import com.sooRyeo.app.dto.CourseUpdateRequestDto;
import com.sooRyeo.app.dto.TimeDto;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.model.CourseDao;

@Service
public class CourseService_imple implements CourseService {
	
	@Autowired
	private CourseDao courseDao;
	
	@Autowired
	private JsonBuilder jsonBuilder;

	@Override
	public String getProfTimetable(HttpServletRequest request, ModelAndView mav) {
		
		int prof_id = Integer.parseInt(request.getParameter("prof_id"));
		System.out.println("prof_id:  " + prof_id );
		
		TimeTable profTimeTable = courseDao.getProfTimeTable(prof_id);
		
		return jsonBuilder.toJson(profTimeTable);
	}

	@Transactional
	@Override
	public ResponseEntity<String> insertCourse(HttpServletRequest request, CourseInsertReqeustDTO courseInsertReqeustDTO) {
		
		TimeTable profTimeTable = courseDao.getProfTimeTable(courseInsertReqeustDTO.getProf_id());
		
		
		
		List<Time> timeList = new ArrayList<Time>();
		
		for(TimeDto dto : courseInsertReqeustDTO.getTimeList()) {
			timeList.add(new Time(dto.getDay_of_week(), dto.getStart_period(), dto.getEnd_period()));
		}
		
		
		Course newCourse = new Course(courseInsertReqeustDTO.getProf_id(), courseInsertReqeustDTO.getFk_curriculum_seq(), timeList, courseInsertReqeustDTO.getCapacity());
		
		
		if(!profTimeTable.canAddCourse(newCourse)) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("시간이 중복됩니다");
		}
		int n = courseDao.openCourse(newCourse, courseInsertReqeustDTO.getProf_id());
		
		return n == 1? ResponseEntity.ok("성공") : ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버오류");
	}

	@Override
	public ResponseEntity<String> deleteCourse(HttpServletRequest request) {
		
		int course_seq = Integer.parseInt(request.getParameter("course_seq"));
		
		int result = courseDao.updateToDeleteCourse(course_seq);
		
		
		if(result != 1) {
			return ResponseEntity.internalServerError().body("오류 발생");
		}
		
		return ResponseEntity.ok("패강 성공");
	}

	@Override
	public ResponseEntity<String> getCourse(HttpServletRequest request) {
		int course_seq = Integer.parseInt(request.getParameter("course_seq"));
		
		Course course = courseDao.getCourse(course_seq);
		
		if(course == null) {
			
			return ResponseEntity.internalServerError().body("존재하지 않는 개설강의 입니다");
		}
		
		return ResponseEntity.ok(jsonBuilder.toJson(course));
	}

	@Transactional
	@Override
	public ResponseEntity<String> updateCourse(HttpServletRequest request, CourseUpdateRequestDto requestDto) {

		
		int result = courseDao.updateCourse(requestDto);
		
		
		if(result != 1) {
			return ResponseEntity.internalServerError().body("수정에 실패하였습니다");
		}
		
	
		return ResponseEntity.ok("수정 완료되었습니다");
	}
	

}
