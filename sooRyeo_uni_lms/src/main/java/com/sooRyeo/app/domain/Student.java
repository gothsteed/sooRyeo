package com.sooRyeo.app.domain;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import com.sooRyeo.app.common.AES256;


public class Student {
	
	@Autowired
	private AES256 aES256;
	
	private Integer student_id;
    private String pwd;
    private String name;
    private String jubun;
    private String tel;
    private Short grade;
    private String address;
    private String email;
    private Date register_date;
    private Short status;
    private Integer fk_department_seq;
	public Integer getStudent_id() {
		return student_id;
	}
	public String getPwd() {
		return pwd;
	}
	public String getName() {
		return name;
	}
	public String getJubun() {
		return jubun;
	}
	public String getTel() {
		
		String decrypedTel = null;
		try {
			decrypedTel = aES256.decrypt(tel);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		return decrypedTel;
	}
	public Short getGrade() {
		return grade;
	}
	public String getAddress() {
		return address;
	}
	public String getEmail()  {
		
		String decrypedEmail = null;
		try {
			decrypedEmail = aES256.decrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		return decrypedEmail;
	}
	public Date getRegister_date() {
		return register_date;
	}
	public Short getStatus() {
		return status;
	}
	public Integer getFk_department_seq() {
		return fk_department_seq;
	}
    
    

    
    
    

	
	

}
