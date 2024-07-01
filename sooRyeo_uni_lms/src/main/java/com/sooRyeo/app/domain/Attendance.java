package com.sooRyeo.app.domain;

import java.util.Date;

public class Attendance {
	
    private Integer attendance_seq;
    private Integer fk_course_seq;
    private Integer fk_student_id;
    private char isAttended;
    private Date attended_date;
    
    
	public Integer getAttendance_seq() {
		return attendance_seq;
	}
	public Integer getFk_course_seq() {
		return fk_course_seq;
	}
	public Integer getFk_student_id() {
		return fk_student_id;
	}
	public char getIsAttended() {
		return isAttended;
	}
	public Date getAttended_date() {
		return attended_date;
	}
    
    
    

}
