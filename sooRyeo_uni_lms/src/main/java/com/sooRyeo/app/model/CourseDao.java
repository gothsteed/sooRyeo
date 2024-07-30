package com.sooRyeo.app.model;

import java.util.List;

import com.sooRyeo.app.domain.*;
import com.sooRyeo.app.dto.CourseUpdateRequestDto;

public interface CourseDao {

	int registerCourse(Course newCourse, Integer studentId);
	
	int openCourse(Course newCourse, Integer prof_id);

	TimeTable getProfTimeTable(int prof_id);

	int updateToDeleteCourse(int course_seq);

	Course getCourse(int course_seq);

	int updateCourse(CourseUpdateRequestDto requestDto);

	List<Course> getCourseList(Integer department_seq, Integer grade);

	StudentTimeTable getRegisteredCourseList(Integer student_id);

	int insertRegisterCourse(int course_seq, int student_id);

	int editRegisterCount(int course_seq, int increment);

	int deleteRegisteredCourse(int course_seq, int student_id);

    List<RegisteredCourse> courseRegisterationList(Integer fkCourseSeq);
}
