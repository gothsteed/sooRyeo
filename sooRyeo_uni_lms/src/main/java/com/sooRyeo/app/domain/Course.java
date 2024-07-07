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
    
    public Course() {}
    
    
    public Course(Integer fk_professor_id, Integer fk_curriculum_seq, List<Time> timeList, int capacity) {
        this.fk_professor_id = fk_professor_id;
        this.fk_curriculum_seq = fk_curriculum_seq;
        this.timeList = timeList;
        this.capacity = capacity;
    }

    
    
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
	
	
	public boolean isSameCurriculum(Course newCourse) {
		if(this.fk_curriculum_seq.equals(newCourse.fk_curriculum_seq)) {
			return true;
		}
		return false;
	}
	
	
	public Curriculum getCurriculum() {
		return curriculum;
	}
	public boolean isTimeConflict(Course newCourse) {

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
