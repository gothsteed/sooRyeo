package com.sooRyeo.app.domain;

public class Announcement {
	
	private Integer announcement_seq;
	private String a_title;
	private String a_content;
	private String writeday;
	private Integer viewcount;
	private String attatched_file;
	private Integer status;
	
	private Integer previousseq;
	private String previoussubject;
	private Integer nextseq;
	private String nextsubject;
	
	
	
	public Integer getStatus() {
		return status;
	}
	public Integer getPreviousseq() {
		return previousseq;
	}
	public String getPrevioussubject() {
		return previoussubject;
	}
	public Integer getNextseq() {
		return nextseq;
	}
	public String getNextsubject() {
		return nextsubject;
	}
	public Integer getAnnouncement_seq() {
		return announcement_seq;
	}
	public String getA_title() {
		return a_title;
	}
	public String getA_content() {
		return a_content;
	}
	public String getAttatched_file() {
		return attatched_file;
	}
	public String getWriteday() {
		return writeday;
	}
	public Integer getViewcount() {
		return viewcount;
	}
	
	
	

}
