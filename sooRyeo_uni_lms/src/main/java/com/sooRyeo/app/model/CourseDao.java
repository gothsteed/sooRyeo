package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.TimeTable;
import com.sooRyeo.app.dto.CourseUpdateRequestDto;

public interface CourseDao {

	int registerCourse(Course newCourse, Integer studentId);
	
	int openCourse(Course newCourse, Integer prof_id);

	TimeTable getProfTimeTable(int prof_id);

	int updateToDeleteCourse(int course_seq);

	Course getCourse(int course_seq);

	int updateCourse(CourseUpdateRequestDto requestDto);

}
