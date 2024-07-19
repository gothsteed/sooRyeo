package com.sooRyeo.app.domain;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Schedule {
	
	private Integer schedule_seq;
	private String title;
	private Integer schedule_type;
	private String start_date;
	private String end_date;
	private int confirm;
	
	
	public Integer getSchedule_seq() {
		return schedule_seq;
	}
	public String getTitle() {
		return title;
	}
	public Integer getSchedule_type() {
		return schedule_type;
	}
	public String getStart_date() {
		return start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public int getConfirm() {
		return confirm;
	}


	public boolean isBetweenSchedule(LocalDateTime time) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		LocalDateTime start = LocalDateTime.parse(start_date, formatter);
		LocalDateTime end = LocalDateTime.parse(end_date, formatter);

		if(time.isAfter(start) && time.isBefore(end)) {
			return true;
		}

		return false;
	}
}
