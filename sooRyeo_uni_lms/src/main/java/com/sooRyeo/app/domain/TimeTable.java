package com.sooRyeo.app.domain;

import com.sooRyeo.app.model.CourseDao;

public interface TimeTable {
	
	
	boolean addCourse(Course course, CourseDao courseDao);
	
	
	int calculateCredit();
	
	int countCourses();
	
	
	

}
