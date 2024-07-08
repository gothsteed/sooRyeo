package com.sooRyeo.app.dto;

import java.util.List;

public class CourseInsertReqeustDTO {
	
    private int fk_curriculum_seq;
    private int prof_id;
    private int capacity;
    private List<TimeDto> timeList;
    
    
	public int getFk_curriculum_seq() {
		return fk_curriculum_seq;
	}
	public void setFk_curriculum_seq(int fk_curriculum_seq) {
		this.fk_curriculum_seq = fk_curriculum_seq;
	}
	public int getProf_id() {
		return prof_id;
	}
	public void setProf_id(int prof_id) {
		this.prof_id = prof_id;
	}
	public List<TimeDto> getTimeList() {
		return timeList;
	}
	public void setTimeList(List<TimeDto> timeList) {
		this.timeList = timeList;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	
	
    
    
    
    
    
}
