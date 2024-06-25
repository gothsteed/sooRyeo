package com.sooRyeo.app.domain;

import java.util.Date;

public class Assignment {
	
    private Integer assignment_seq;
    private Integer fk_course_seq;
    private Date start_datetime;
    private Date end_datetime;
    private String title;
    private String content;
    private String attatched_file;
    
    
	public Integer getAssignment_seq() {
		return assignment_seq;
	}
	public Integer getFk_course_seq() {
		return fk_course_seq;
	}
	public Date getStart_datetime() {
		return start_datetime;
	}
	public Date getEnd_datetime() {
		return end_datetime;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public String getAttatched_file() {
		return attatched_file;
	}

    
    
    
}
