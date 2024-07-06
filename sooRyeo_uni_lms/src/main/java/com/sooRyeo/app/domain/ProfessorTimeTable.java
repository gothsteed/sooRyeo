package com.sooRyeo.app.domain;

import java.util.List;

import com.sooRyeo.app.model.CourseDao;

public class ProfessorTimeTable implements TimeTable {
	
	
	private Integer prof_id;
	private List<Course> courseList;
	
	
	
	

	public ProfessorTimeTable(Integer prof_id, List<Course> courseList) {
		super();
		this.prof_id = prof_id;
		this.courseList = courseList;
	}

	@Override
	public boolean addCourse(Course course, CourseDao courseDao) {
		// TODO Auto-generated method stub
		return false;
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

	public Integer getProf_id() {
		return prof_id;
	}

	public List<Course> getCourseList() {
		return courseList;
	}
	
	

}
