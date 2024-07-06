package com.sooRyeo.app.domain;

public class Time {

	private Integer time_seq;
	private Integer fk_course_seq;
	private Short day_of_week;
	private Short start_period;
	private Short end_period;
	
	
	public Integer getTime_seq() {
		return time_seq;
	}
	
	public Integer getFk_course_seq() {
		return fk_course_seq;
	}


	public Short getDay_of_week() {
		return day_of_week;
	}
	public Short getStart_period() {
		return start_period;
	}
	public Short getEnd_period() {
		return end_period;
	}

	public boolean isConflict(Time newT) {
		if(start_period > newT.end_period || end_period < newT.start_period) {
			return false;
		}
		
		return true;
	}

	
	
	

}
