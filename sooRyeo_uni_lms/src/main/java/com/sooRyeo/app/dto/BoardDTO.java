package com.sooRyeo.app.dto;

import org.springframework.web.multipart.MultipartFile;

public class BoardDTO {

	private Integer seq;
	private String title;
	private String content;
	private String writeday;
	private Integer viewcount;
	private String attatched_file;
	private String orgfilename;
	private int Listtype;
	
	private Integer previousseq;
	private String previoussubject;
	private Integer nextseq;
	private String nextsubject;
	
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

	private MultipartFile attach;

	public String getWriteday() {
		return writeday;
	}

	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}

	public Integer getViewcount() {
		return viewcount;
	}

	public void setViewcount(Integer viewcount) {
		this.viewcount = viewcount;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getOrgfilename() {
		return orgfilename;
	}

	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}

	public String getAttatched_file() {
		return attatched_file;
	}
	
	public void setAttatched_file(String attatched_file) {
		this.attatched_file = attatched_file;
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

	public int getListtype() {
		return Listtype;
	}

	public void setListtype(int listtype) {
		Listtype = listtype;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
}
