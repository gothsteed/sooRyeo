package com.sooRyeo.app.domain;

import java.util.Date;
import java.util.List;


//TODO: time과 조인한 객채 따로 분리하기 !!!!
public class Course {
	

    private Integer course_seq;
    private Integer fk_professor_id;
    private Integer fk_curriculum_seq;
    private Integer capacity;
    private Date semester_date;
    private Short exist;
    private Integer register_count;
    
    private List<Time> timeList;
    
    //private List<RegisteredCourse> 
    
    private Curriculum curriculum;
    
    
    private Professor professor;
   
    
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
	public Integer getCurriculum_seq() {

		return curriculum.getCurriculum_seq();
	}
	
	
	
	
	
	public Professor getProfessor() {
		return professor;
	}


	public boolean isSameCurriculum(Course newCourse) {
		if(this.fk_curriculum_seq.equals(newCourse.getCurriculum_seq())) {
			return true;
		}
		return false;
	}
	
	
	public Curriculum getCurriculum() {
		return curriculum;
	}
	public boolean isTimeConflict(Course newCourse) {

		for(Time t : timeList) {
			for(Time newT : newCourse.getTimeList()) {
				if(t.isConflict(newT)) return true;
			}
		}
		
		return false;

	}
	public void setTimeList(List<Time> times) {
		this.timeList = times;
		
	}


	public Short getExist() {
		return exist;
	}


	public Integer getRegister_count() {
		return register_count;
	}


	public boolean isVacancy() {
		if(capacity > register_count) {
			return true;
		}
		
		return false;
	}
    

}
