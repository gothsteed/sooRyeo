package com.sooRyeo.app.domain;

import java.time.LocalDateTime;

public class Consult {
	
	private Integer fk_schedule_seq;
	private Integer fk_student_id;
	private Integer fk_prof_id;
	
	private String content;
	private Integer complete;
	
	
	private Schedule schedule;
	private Student student;
	private Professor professor;
	
	
	
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
	public Professor getProfessor() {return professor;}


	public Integer getStudentId() {
		return student.getStudent_id();
	}
	public String getStudentName() {
		return student.getName();
	}

	public boolean isAvailableTime(LocalDateTime time) {
		return  schedule.isBetweenSchedule(time);
	}
	
	
	

}
