package com.sooRyeo.app.domain;

public class Curriculum {
	
    private Integer curriculum_seq;
    private Integer fk_curriculum_type_seq;
    private Integer fk_department_seq;
    private Short grade;
    private String name;
    private Short credit;
    
    
	public Integer getCurriculum_seq() {
		return curriculum_seq;
	}
	public Integer getFk_curriculum_type_seq() {
		return fk_curriculum_type_seq;
	}
	public Integer getFk_department_seq() {
		return fk_department_seq;
	}
	public Short getGrade() {
		return grade;
	}
	public String getName() {
		return name;
	}
	public Short getCredit() {
		return credit;
	}
    
    
    

}
