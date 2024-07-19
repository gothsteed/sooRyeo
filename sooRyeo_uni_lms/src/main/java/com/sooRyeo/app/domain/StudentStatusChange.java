package com.sooRyeo.app.domain;

public class StudentStatusChange {

	private Integer student_id;
	private Integer change_status;
	private String name;	
	private Short grade;
    private String department_name;
	private Short status;
	
	public Integer getStudent_id() {
		return student_id;
	}
	public Integer getChange_status() {
		return change_status;
	}
	public String getName() {
		return name;
	}
	public Short getGrade() {
		return grade;
	}
	public String getDepartment_name() {
		return department_name;
	}
	public Short getStatus() {
		return status;
	}
	
	
}
