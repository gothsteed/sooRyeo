package com.sooRyeo.app.domain;


import org.json.JSONObject;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Schedule  implements ScheduleInterface{
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


	@Override
	public boolean isBetween(LocalDateTime time) {
		LocalDateTime start = LocalDateTime.parse(start_date, formatter);
		LocalDateTime end = LocalDateTime.parse(end_date, formatter);

		if(time.isAfter(start) && time.isBefore(end)) {
			return true;
		}

		return false;
	}

	@Override
	public LocalDateTime getStartLocalDateTime() {
		return LocalDateTime.parse(start_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	}
	@Override
	public LocalDateTime getEndLocalDateTime() {
		return LocalDateTime.parse(end_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	}

	@Override
	public Duration getDuration() {
		return Duration.between(LocalDateTime.parse(start_date, formatter) , LocalDateTime.parse(end_date, formatter));
	}
	@Override
	public boolean isBefore(LocalDateTime time) {
		return time.isBefore(getStartLocalDateTime());
	}
	@Override
	public boolean isAfter(LocalDateTime time) {
		return time.isAfter(getEndLocalDateTime());
	}

	@Override
	public JSONObject toJson() {
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("schedule_seq", getSchedule_seq());
		jsonobj.put("schedule_type", getSchedule_type());
		jsonobj.put("title", getTitle());
		jsonobj.put("start_date", getStart_date());
		jsonobj.put("end_date", getEnd_date());

		return jsonobj;
	}


}
