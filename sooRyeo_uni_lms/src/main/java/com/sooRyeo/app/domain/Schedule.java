package com.sooRyeo.app.domain;


import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Schedule {
	private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
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
		LocalDateTime start = LocalDateTime.parse(start_date, formatter);
		LocalDateTime end = LocalDateTime.parse(end_date, formatter);

		if(time.isAfter(start) && time.isBefore(end)) {
			return true;
		}

		return false;
	}

	public LocalDateTime getStartLocalDateTime() {
		return LocalDateTime.parse(start_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	}
	public LocalDateTime getEndLocalDateTime() {
		return LocalDateTime.parse(end_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	}

	public Duration getDuration() {
		return Duration.between(LocalDateTime.parse(start_date, formatter) , LocalDateTime.parse(end_date, formatter));
	}
	public boolean isBefore(LocalDateTime time) {
		return time.isBefore(getStartLocalDateTime());
	}
	public boolean isAfter(LocalDateTime time) {
		return time.isAfter(getEndLocalDateTime());
	}



}
