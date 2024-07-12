package com.sooRyeo.app.dto;

import org.springframework.web.multipart.MultipartFile;

public class AssignScheInsertDTO {
	
	private int schedule_seq;
	private int schedule_seq_assignment;
	private String startDate;
	private String endDate;
	private String title;
	private String content;
	private String attatched_file;
	
	private MultipartFile attach;
	
	public int getSchedule_seq() {
		return schedule_seq;
	}
	public void setSchedule_seq(int schedule_seq) {
		this.schedule_seq = schedule_seq;
	}
	public int getSchedule_seq_assignment() {
		return schedule_seq_assignment;
	}
	public void setSchedule_seq_assignment(int schedule_seq_assignment) {
		this.schedule_seq_assignment = schedule_seq_assignment;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
