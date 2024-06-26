package com.sooRyeo.app.domain;

public class Grade {
    private Integer grade_seq;
    private Integer fk_registered_course_seq;
    private Integer score;
    private Character mark;
    
    
	public Integer getGrade_seq() {
		return grade_seq;
	}
	public Integer getFk_registered_course_seq() {
		return fk_registered_course_seq;
	}
	public Integer getScore() {
		return score;
	}
	public Character getMark() {
		return mark;
	}
    
    
    
}
