package com.sooRyeo.app.domain;

import java.util.Date;

public class Schedule {
	
	private Integer schedule_seq;
	private String title;
	private Integer schedule_type;
	private Date start_date;
	private Date end_date;
	
	
	
	public Integer getSchedule_seq() {
		return schedule_seq;
	}
	public String getTitle() {
		return title;
	}
	public Integer getSchedule_type() {
		return schedule_type;
	}
	public Date getStart_date() {
		return start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	
	
	

	

}
