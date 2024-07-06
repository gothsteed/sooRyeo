package com.sooRyeo.app.domain;

import java.util.Date;
import java.util.List;

public class Course {
	

    private Integer course_seq;
    private Integer fk_professor_id;
    private Integer fk_curriculum_seq;
    private Integer capacity;
    private Date semester_date;
    
    private List<Time> timeList;
    
    private Curriculum curriculum;
    
    
	public Integer getCourse_seq() {
		return course_seq;
	}
	public Integer getFk_professor_id() {
		return fk_professor_id;
	}
	public Integer getFk_curriculum_seq() {
		return fk_curriculum_seq;
	}
	public Integer getCapacity() {
		return capacity;
	}
	public Date getSemester_date() {
		return semester_date;
	}
	public List<Time> getTimeList() {
		return timeList;
	}
	
	
	
	
	public Curriculum getCurriculum() {
		return curriculum;
	}
	public boolean isConflict(Course newCourse) {
		
		if(fk_curriculum_seq == newCourse.fk_curriculum_seq) {
			return true;
		}
		
		for(Time t : timeList) {
			for(Time newT : newCourse.timeList) {
				if(t.isConflict(newT)) return true;
			}
		}
		
		return false;

	}
	public void setTimeList(List<Time> times) {
		this.timeList = times;
		
	}
    
    
    

}
