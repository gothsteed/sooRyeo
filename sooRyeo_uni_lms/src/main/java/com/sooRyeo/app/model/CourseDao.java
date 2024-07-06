package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.TimeTable;

public interface CourseDao {

	int registerCourse(Course newCourse, Integer studentId);

	TimeTable getProfTimeTable(int prof_id);

}
