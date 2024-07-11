package com.sooRyeo.app.dto;

import org.springframework.web.multipart.MultipartFile;

public class BoardDTO {

	private String title;
	private String content;
	private String attatched_file;
	private String orgfilename;
	private int Listtype;
	private int seq;
	
	private MultipartFile attach;

	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
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
