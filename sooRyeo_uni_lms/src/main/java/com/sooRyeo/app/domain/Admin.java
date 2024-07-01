package com.sooRyeo.app.domain;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import com.sooRyeo.app.common.AES256;

public class Admin {
	
    private Integer admin_seq;
    private String name;
    private String pwd;
    private String jubun;
    private String tel;
    private String email;
    
    
	public Integer getAdmin_seq() {
		return admin_seq;
	}
	public String getName() {
		return name;
	}
	public String getPwd() {
		return pwd;
	}
	public String getJubun() {
		return jubun;
	}
	public String getTel() {
		return tel;
	}
	public String getEmail() {
		return email;
	}
    
	public void setDecodedEmail(AES256 aES256) {// 이메일 복호화
		try {
			email = aES256.decrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
	}
	
	public void setDecodeTel(AES256 aES256) {// 전화번호 복호화
		try {
			tel = aES256.decrypt(tel);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
	
	}
    
    

}
