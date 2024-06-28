package com.sooRyeo.app.domain;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import com.sooRyeo.app.common.AES256;


public class Student {
	
	
	private Integer student_id;
    private String pwd;
    private String name;
    private String jubun;
    private String tel;
    private Short grade;
    private String address;
    private String email;
    private Integer register_year;
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
		
		return tel;
	}
	public Short getGrade() {
		return grade;
	}
	public String getAddress() {
		return address;
	}
	public String getEmail()  {
	
		return email;
	}
	public Integer getRegister_year() {
		return register_year;
	}
	public Short getStatus() {
		return status;
	}
	public Integer getFk_department_seq() {
		return fk_department_seq;
	}
	public void setDecodedEmail(AES256 aES256) {
		try {
			email = aES256.decrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
	}
	public void setDecodeTel(AES256 aES256) {
		try {
			tel = aES256.decrypt(tel);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
	}
    
    

    
    
    

	
	

}
