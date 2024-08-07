package com.sooRyeo.app.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.ExceptionHandler.CourseRegistrationException;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.domain.StudentTimeTable;
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
		
		
		
		List<Time> timeList = new ArrayList<>();
		
		for(TimeDto dto : courseInsertReqeustDTO.getTimeList()) {
			timeList.add(new Time(dto.getDay_of_week(), dto.getStart_period(), dto.getEnd_period()));
		}

		for(int i=0; i<timeList.size(); i++) {
			Time time = timeList.get(i);
			for(int j=i + 1; j<timeList.size(); j++) {
				Time otherTime = timeList.get(j);
				if(time.isConflict(otherTime)) {
					return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("입력한 강의 시간이 중복됩니다");
				}
			}
		}
		
		
		Course newCourse = new Course(courseInsertReqeustDTO.getProf_id(), courseInsertReqeustDTO.getFk_curriculum_seq(), timeList, courseInsertReqeustDTO.getCapacity());
		
		
		if(!profTimeTable.canAddCourse(newCourse)) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("이미 입력된 시간 입니다");
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
		
		return ResponseEntity.ok("폐강 성공");
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

	@Override
	public ResponseEntity<String> getCourseList(HttpServletRequest request) {
		Integer department_seq = request.getParameter("fk_department_seq").isEmpty()?null: Integer.parseInt(request.getParameter("fk_department_seq"));
		Integer grade = request.getParameter("grade").isEmpty()?null: Integer.parseInt(request.getParameter("grade"));

		List<Course> courseList = courseDao.getCourseList(department_seq, grade);
		
		
		if(courseList == null) {
			return ResponseEntity.internalServerError().body("{message : 'error'}");
		}
		
		
		
		return  ResponseEntity.ok(jsonBuilder.toJson(courseList));
	}

	@Override
	public ResponseEntity<String> getLoginStudentTimeTable(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Student loginuser = (Student) session.getAttribute("loginuser");
		
		TimeTable courseList = courseDao.getRegisteredCourseList(loginuser.getStudent_id());
		//TimeTable studentTimetable = new StudentTimeTable();
		
		if(courseList==null) {
			return ResponseEntity.internalServerError().body("잠시후 다시 시도해 주세요");
		}
		
		return ResponseEntity.ok(jsonBuilder.toJson(courseList));
	}

	@Transactional
	@Override
	public ResponseEntity<String> registerCourse(HttpServletRequest request) {
	
		int course_seq = Integer.parseInt(request.getParameter("course_seq"));
		
		HttpSession session = request.getSession();
		int student_id = ((Student) session.getAttribute("loginuser")).getStudent_id();
		
		Course course = courseDao.getCourse(course_seq);
		
		if(!course.isVacancy()) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("수강 인원 초과입니다");
		}
		
		
		StudentTimeTable studentTimeTable = courseDao.getRegisteredCourseList(student_id);
		if(!studentTimeTable.canAddCourse(course)) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 수강한 수업이거나 중복된 시간입니다.");
		}
		
		
		int registerResult = courseDao.insertRegisterCourse(course_seq, student_id);
		int registerCountResult = courseDao.editRegisterCount(course_seq, 1);
		
		System.out.println("register result : " + (registerCountResult * registerResult));
		if(registerCountResult * registerResult != 1) {
			throw new CourseRegistrationException("트랜젝션 오류발생 다시 시도해 주세요");
		}
		
		return ResponseEntity.ok("수강신청 성공");
	}

	@Transactional
	@Override
	public ResponseEntity<String> dropStudentCourse(HttpServletRequest request) {
		int course_seq = Integer.parseInt(request.getParameter("course_seq"));
		HttpSession session = request.getSession();
		int student_id = ((Student) session.getAttribute("loginuser")).getStudent_id();
		
		int dropResult = courseDao.deleteRegisteredCourse(course_seq, student_id);
		int registerCountResult = courseDao.editRegisterCount(course_seq, -1);
		
		System.out.println("drop result : " + (registerCountResult * dropResult));
		if(registerCountResult * dropResult < 1) {
			throw new CourseRegistrationException("트랜젝션 오류발생 다시 시도해 주세요");
		}
		
		return ResponseEntity.ok("수강취소 성공");
	}
	

}
