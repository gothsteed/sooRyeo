package com.sooRyeo.app.dto;

public class CurriculumRequestDto {

//  private Integer fk_curriculum_type_seq;
	private Integer curriculum_seq;
	private Integer fk_department_seq;
	private Short grade;
	private String name;
	private Short credit;
	private int required;
	
	
	

	public Integer getCurriculum_seq() {
		return curriculum_seq;
	}
	public void setCurriculum_seq(Integer curriculum_seq) {
		this.curriculum_seq = curriculum_seq;
	}
	public Integer getFk_department_seq() {
		return fk_department_seq;
	}
	public void setFk_department_seq(Integer fk_department_seq) {
		this.fk_department_seq = fk_department_seq;
	}
	public Short getGrade() {
		return grade;
	}
	public void setGrade(Short grade) {
		this.grade = grade;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Short getCredit() {
		return credit;
	}
	public void setCredit(Short credit) {
		this.credit = credit;
	}
	public int getRequired() {
		return required;
	}
	public void setRequired(int required) {
		this.required = required;
	}

}
