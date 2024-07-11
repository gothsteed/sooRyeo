package com.sooRyeo.app.domain;

import java.util.List;

public interface CourseInterface {
	
	boolean isSameCurriculum(CourseInterface newCourse);
	
	boolean isTimeConflict(CourseInterface newCourse);
	
    Integer getCurriculum_seq();
    List<Time> getTimeList();

}
