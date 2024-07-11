package com.sooRyeo.app.dto;

import java.util.List;

public class CourseUpdateRequestDto {
	
	private int course_seq;
	private int capacity;
	private List<TimeDto> timeList;
	
	
	public int getCourse_seq() {
		return course_seq;
	}
	public void setCourse_seq(int course_seq) {
		this.course_seq = course_seq;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public List<TimeDto> getTimeList() {
		return timeList;
	}
	public void setTimeList(List<TimeDto> timeList) {
		this.timeList = timeList;
	}
	
	

}
