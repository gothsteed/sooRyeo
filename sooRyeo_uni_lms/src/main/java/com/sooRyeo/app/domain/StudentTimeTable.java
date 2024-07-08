package com.sooRyeo.app.domain;

import java.util.List;

import com.sooRyeo.app.model.CourseDao;

public class StudentTimeTable implements TimeTable {

	private Integer studentId;
	private List<Course> courseList;

	@Override
	public boolean canAddCourse(Course newCourse) {

		for (Course course : courseList) {
			if (course.isSameCurriculum(newCourse)) {
				return false;
			}

			if (course.isTimeConflict(newCourse)) {
				return false;
			}
		}

		return true;

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