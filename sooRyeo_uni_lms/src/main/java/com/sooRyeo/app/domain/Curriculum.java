package com.sooRyeo.app.domain;

public class Curriculum {
	
    private Integer curriculum_seq;
//    private Integer fk_curriculum_type_seq;
    private Integer fk_department_seq;
    private Short grade;
    private String name;
    private Short credit;
    private Department department; 
    private Short required;
    private Integer exist;
    
	public Integer getCurriculum_seq() {
		return curriculum_seq;
	}
//	public Integer getFk_curriculum_type_seq() {
//		return fk_curriculum_type_seq;
//	}
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
	
	public String getDepartment_name( ) {
		if(department  == null) {
			return "";
		}
		
		return department.getDepartment_name();
	}
	public Short getRequired() {
		return required;
	}
	public Integer getExist() {
		return exist;
	}


	
	
    
    
    

}
