package com.sooRyeo.app.dto;

public class ScheduleDto {
	
	private Integer schedule_seq;
	private String title;
	private Integer schedule_type;
	private String start_date;
	private String end_date;
	private Integer confirm;
	public Integer getSchedule_seq() {
		return schedule_seq;
	}
	public void setSchedule_seq(Integer schedule_seq) {
		this.schedule_seq = schedule_seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getSchedule_type() {
		return schedule_type;
	}
	public void setSchedule_type(Integer schedule_type) {
		this.schedule_type = schedule_type;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public Integer getConfirm() {
		return confirm;
	}
	public void setConfirm(Integer confirm) {
		this.confirm = confirm;
	}

	
	
}
