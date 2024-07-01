package com.sooRyeo.app.dto;

public class CurriculumPageRequestDto {
	
	Integer fk_department_seq;
	Integer grade;
	Integer currentPage;
	
	
	public Integer getFk_department_seq() {
		return fk_department_seq;
	}
	public void setFk_department_seq(Integer fk_department_seq) {
		this.fk_department_seq = fk_department_seq;
	}
	public Integer getGrade() {
		return grade;
	}
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	
	
	

}
