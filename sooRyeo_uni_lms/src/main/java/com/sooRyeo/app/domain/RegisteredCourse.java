package com.sooRyeo.app.domain;

import java.util.Date;

public class RegisteredCourse {

	private Integer registered_course_seq;
	private Integer fk_student_id;
	private Integer fk_course_seq;
	private Date register_date;
	
	
	public Integer getRegistered_course_seq() {
		return registered_course_seq;
	}
	public Integer getFk_student_id() {
		return fk_student_id;
	}
	public Integer getFk_course_seq() {
		return fk_course_seq;
	}
	public Date getRegister_date() {
		return register_date;
	}
	
	

}
