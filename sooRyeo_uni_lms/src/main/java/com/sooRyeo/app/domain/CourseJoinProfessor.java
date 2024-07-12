package com.sooRyeo.app.domain;

import java.util.List;

public class CourseJoinProfessor {
	
	private Course course;
	private Professor professor;
	
	public CourseJoinProfessor() {}
	
	public CourseJoinProfessor(Course course, Professor professor) {
		this.course = course;
		this.professor = professor;
	}

	
	public Course getCourse() {
		return course;
	}


	public Professor getProfessor() {
		return professor;
	}

	public void setTimeList(List<Time> timeList) {
		course.setTimeList(timeList);
	}


	public boolean isSameCurriculum(Course newCourse) {

		return course.isSameCurriculum(newCourse);
	}


	public boolean isTimeConflict(Course newCourse) {
		return course.isTimeConflict(newCourse);
	}


	public Integer getCurriculum_seq() {
		return course.getCurriculum_seq();
	}


	public List<Time> getTimeList() {
		
		return course.getTimeList();
	}
	
	
	
	

}
