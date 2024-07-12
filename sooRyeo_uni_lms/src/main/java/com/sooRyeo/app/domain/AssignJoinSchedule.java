package com.sooRyeo.app.domain;

public class AssignJoinSchedule {
	
	private Assignment assignment;
	
	private Schedule schedule;
	
	public AssignJoinSchedule() {};
	
	public AssignJoinSchedule(Assignment assignment, Schedule schedule) {
		
		this.assignment = assignment;
		this.schedule = schedule;
		
	}

	public Assignment getAssignment() {
		return assignment;
	}

	public Schedule getSchedule() {
		return schedule;
	}
	

}
