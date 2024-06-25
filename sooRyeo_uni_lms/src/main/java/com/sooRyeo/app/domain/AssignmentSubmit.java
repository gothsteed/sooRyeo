package com.sooRyeo.app.domain;

import java.util.Date;

public class AssignmentSubmit {
	
    private Integer assignment_submit_seq;
    private Integer fk_assignment_seq;
    private String title;
    private String content;
    private Integer score;
    private Date submit_datetime;
    private String attatched_file;
    private Integer fk_student_id;
    
    
	public Integer getAssignment_submit_seq() {
		return assignment_submit_seq;
	}
	public Integer getFk_assignment_seq() {
		return fk_assignment_seq;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public Integer getScore() {
		return score;
	}
	public Date getSubmit_datetime() {
		return submit_datetime;
	}
	public String getAttatched_file() {
		return attatched_file;
	}
	public Integer getFk_student_id() {
		return fk_student_id;
	}
    
    
    
    

}
