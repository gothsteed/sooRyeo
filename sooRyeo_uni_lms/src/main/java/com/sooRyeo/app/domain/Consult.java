package com.sooRyeo.app.domain;

public class Consult {
	
	private Integer fk_schedule_seq;
	private Integer fk_student_id;
	private Integer fk_prof_id;
	
	private String content;
	
	
	private Schedule schedule;
	private Student student;
	
	
	
	public Integer getFk_schedule_seq() {
		return fk_schedule_seq;
	}
	public Integer getFk_student_id() {
		return fk_student_id;
	}
	public Integer getFk_prof_id() {
		return fk_prof_id;
	}
	public String getContent() {
		return content;
	}
	public Schedule getSchedule() {
		return schedule;
	}
	public Student getStudent() {
		return student;
	}
	
	
	

}
