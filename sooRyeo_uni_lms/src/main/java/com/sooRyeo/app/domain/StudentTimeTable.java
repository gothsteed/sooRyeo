package com.sooRyeo.app.domain;

import java.util.List;

import com.sooRyeo.app.model.CourseDao;

public class StudentTimeTable implements TimeTable {
	
	private Integer studentId;
	private List<Course> courseList;
	
	

	@Override
	public boolean addCourse(Course newCourse, CourseDao courseDao) {
		
		for(Course course : courseList) {
			if(course.isConflict(newCourse)) {
				return false;
			}
		}
		
		return courseDao.registerCourse(newCourse, studentId) == 1 ? true : false;
		
		
	}

	@Override
	public int calculateCredit() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int countCourses() {
		// TODO Auto-generated method stub
		return 0;
	}

}
