package com.sooRyeo.app.domain;

import java.util.Date;

public class Certificate {
	
    private Integer certificate_seq;
    private Integer student_seq;
    private Date publishDate;
    private String certificateType;
    private String fileName;
    
    
    

	public Integer getCertificate_seq() {
		return certificate_seq;
	}
	public Integer getStudent_seq() {
		return student_seq;
	}
	public Date getPublishDate() {
		return publishDate;
	}
	public String getCertificateType() {
		return certificateType;
	}
	public String getFileName() {
		return fileName;
	}
    
    
    

}
