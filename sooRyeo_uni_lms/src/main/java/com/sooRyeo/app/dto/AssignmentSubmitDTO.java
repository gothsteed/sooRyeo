package com.sooRyeo.app.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class AssignmentSubmitDTO {
   
	private Integer assignment_submit_seq;
    private Integer fk_schedule_seq_assignment;
    private Integer fk_student_id;
    private String title;
    private String content;
    private Integer score;
    private Date submit_datetime;
    private String attatched_file;
    private String orgfilename;
    
	private MultipartFile attach;
    
    
	public String getOrgfilename() {
		return orgfilename;
	}
	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}
	public Integer getAssignment_submit_seq() {
		return assignment_submit_seq;
	}
	public void setAssignment_submit_seq(Integer assignment_submit_seq) {
		this.assignment_submit_seq = assignment_submit_seq;
	}
	public Integer getFk_schedule_seq_assignment() {
		return fk_schedule_seq_assignment;
	}
	public void setFk_schedule_seq_assignment(Integer fk_schedule_seq_assignment) {
		this.fk_schedule_seq_assignment = fk_schedule_seq_assignment;
	}
	public Integer getFk_student_id() {
		return fk_student_id;
	}
	public void setFk_student_id(Integer fk_student_id) {
		this.fk_student_id = fk_student_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Date getSubmit_datetime() {
		return submit_datetime;
	}
	public void setSubmit_datetime(Date submit_datetime) {
		this.submit_datetime = submit_datetime;
	}
	public String getAttatched_file() {
		return attatched_file;
	}
	public void setAttatched_file(String attatched_file) {
		this.attatched_file = attatched_file;
	}
	
	
    public MultipartFile getAttach() {
        return attach;
    }

    public void setAttach(MultipartFile attach) {
        this.attach = attach;
    }
    
	
	
	
    
}

