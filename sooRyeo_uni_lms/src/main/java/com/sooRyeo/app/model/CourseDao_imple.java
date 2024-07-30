package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.dto.CourseUpdateRequestDto;
import com.sooRyeo.app.dto.TimeDto;


@Repository
public class CourseDao_imple implements CourseDao {

	@Autowired
	@Qualifier("sqlsession")
	SqlSessionTemplate sqlsession;

	@Override
	public int registerCourse(Course newCourse, Integer studentId) {

		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("fk_course_seq", newCourse.getCourse_seq());
		paraMap.put("student_id", studentId);

		int result = sqlsession.insert("course.registerCourse", paraMap);

		return result;
	}

	@Override
	public TimeTable getProfTimeTable(int prof_id) {
		List<Course> profCourse = sqlsession.selectList("course.getProfCourseList", prof_id);

		for (Course course : profCourse) {

			int course_seq = course.getCourse_seq();
			List<Time> times = sqlsession.selectList("course.getCourseTimes", course_seq);
			course.setTimeList(times);
		}

		return new ProfessorTimeTable(prof_id, profCourse);
	}

	@Override
	public int openCourse(Course newCourse, Integer prof_id) {
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("fk_professor_id", prof_id);
		paraMap.put("fk_curriculum_seq", newCourse.getFk_curriculum_seq());
		paraMap.put("capacity", newCourse.getCapacity());

		int result = sqlsession.insert("course.openCourse", paraMap);
		
		System.out.println(paraMap.get("course_seq"));

	    Integer course_seq = (Integer) paraMap.get("course_seq");

		for (Time time : newCourse.getTimeList()) {
			paraMap = new HashMap<String, Object>();
			paraMap.put("fk_course_seq", course_seq);
			paraMap.put("day_of_week", time.getDay_of_week());
			paraMap.put("start_period", time.getStart_period());
			paraMap.put("end_period", time.getEnd_period());

			result = sqlsession.insert("course.insertCourseTime", paraMap);
		}

		return result;
	}

	@Override
	public int updateToDeleteCourse(int course_seq) {
		
		return sqlsession.update("course.updateToDelete", course_seq);
	}

	@Override
	public Course getCourse(int course_seq) {
		Course course = sqlsession.selectOne("course.getCourse", course_seq);
		course.setTimeList( sqlsession.selectList("course.getCourseTimes", course_seq));
		
		return course;
	}

	@Override
	public int updateCourse(CourseUpdateRequestDto requestDto) {
		
		int n = sqlsession.update("course.updateCourse", requestDto);
		
		if(n != 1) {
			System.out.println("수정실패!!");
			return 0;
		}
		
		n = sqlsession.delete("course.deleteCourseTime", requestDto);
		
		

		
		int ns=0;
		
		for(TimeDto timeDto : requestDto.getTimeList()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("fk_course_seq", requestDto.getCourse_seq());
			map.put("day_of_week", timeDto.getDay_of_week());
			map.put("start_period", timeDto.getStart_period());
			map.put("end_period", timeDto.getEnd_period());
			
			ns += sqlsession.insert("course.insertCourseTime", map);
		}
		
		if(ns != requestDto.getTimeList().size()) {
			System.out.println("수정실패!!");
			return 0;
		}
		
		return 1;
	}

	@Override
	public List<Course> getCourseList(Integer department_seq, Integer grade) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("department_seq", department_seq);
		map.put("grade", grade);
		
		return sqlsession.selectList("course.getCourseList", map);
	}

	@Override
	public StudentTimeTable getRegisteredCourseList(Integer student_id) {
		
		List<Course> list =  sqlsession.selectList("course.getRegisteredCourseList", student_id);
		for (Course course : list) {
			int course_seq = course.getCourse_seq();
			List<Time> times = sqlsession.selectList("course.getCourseTimes", course_seq);
			course.setTimeList(times);
		}
		
		return new StudentTimeTable(student_id, list);
		
	}

	@Override
	public int insertRegisterCourse(int course_seq, int student_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("course_seq", course_seq);
		map.put("student_id", student_id);
		
		return  sqlsession.insert("course.registerCourse", map);
	}

	@Override
	public int editRegisterCount(int course_seq, int increment) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("course_seq", course_seq);
		map.put("increment", increment);
		
		return sqlsession.update("course.editRegisterCount", map);
	}

	@Override
	public int deleteRegisteredCourse(int course_seq, int student_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("course_seq", course_seq);
		map.put("student_id", student_id);
		
		return sqlsession.delete("course.deleteRegisteredCourse", map);
	}

	@Override
	public List<RegisteredCourse> courseRegisterationList(Integer fkCourseSeq) {
		return sqlsession.selectList("course.courseRegisterationList", fkCourseSeq);
	}

}
