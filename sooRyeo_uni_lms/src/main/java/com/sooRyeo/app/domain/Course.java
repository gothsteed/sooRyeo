package com.sooRyeo.app.domain;

import java.util.Date;


public class Course {	

    private Integer course_seq;
    private Integer fk_professor_id;
    private Integer fk_curriculum_seq;
    private Integer fk_time_seq;
    private Integer capacity;
    private Date semester_date;
    
    
	public Integer getCourse_seq() {
		return course_seq;
	}
	public Integer getFk_professor_id() {
		return fk_professor_id;
	}
	public Integer getFk_curriculum_seq() {
		return fk_curriculum_seq;
	}
	public Integer getFk_time_seq() {
		return fk_time_seq;
	}
	public Integer getCapacity() {
		return capacity;
	}
	public Date getSemester_date() {
		return semester_date;
	}


}
