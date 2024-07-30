package com.sooRyeo.app.domain;

import lombok.Getter;

import java.util.Date;

@Getter
public class RegisteredCourse {

	private Integer registered_course_seq;
	private Integer fk_student_id;
	private Integer fk_course_seq;
	private Date register_date;
	private Integer pass_status;


}
