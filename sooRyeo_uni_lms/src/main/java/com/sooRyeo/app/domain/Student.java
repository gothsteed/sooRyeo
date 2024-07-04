package com.sooRyeo.app.domain;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Date;
import java.util.Map;

import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.dto.StudentDTO;


public class Student {
	
	
	private Integer student_id;
    private String pwd;				// (AES-256 암호화/복호화 대상)
    private String name;
    private String jubun;
    private String tel;				// (AES-256 암호화/복호화 대상)
    private Short grade;
    private String postcode;
    private String address;
    private String detailAddress;
    private String extraAddress;
    private String email; 			// (AES-256 암호화/복호화 대상)
    private Date register_date;
    private Short status;
    private Integer fk_department_seq;
    
    private String birthday; 		// 생년월일

    
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

	public Short getGrade() {
		return grade;
	}
	
	public String getPostcode() {
		return postcode;
	}
	public String getAddress() {
		return address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
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
	
	public void setDecodedEmail(AES256 aES256) {
		try {
			email = aES256.decrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
	}
	public String getEmail()  {
		
		return email;
	}
	
	
	public void setDecodeTel(AES256 aES256) {
		try {
			
			tel = aES256.decrypt(tel).substring(0,3) + aES256.decrypt(tel).substring(3,7) + aES256.decrypt(tel).substring(7);
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
	
	}
	public String getTel() {
		
		return tel;
	}
	
	

	public String getBirthday() {
		try {
			
			birthday = jubun.substring(0,2) + "-" + jubun.substring(2,4) + "-" + jubun.substring(4,6);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return birthday;
	}

	
    
	public void updateinfo(Map<String, String> paraMap, AES256 aES256) {
		
		student_id = Integer.parseInt(paraMap.get("student_id"));
		pwd = paraMap.get("pwd");
		postcode = paraMap.get("postcode");
		address = paraMap.get("address");
		detailAddress = paraMap.get("detailAddress");
		extraAddress = paraMap.get("extraAddress");
		tel = paraMap.get("tel");
		email = paraMap.get("email");
		
		setDecodedEmail(aES256);
		setDecodeTel(aES256);
		
		// 넣은 데이터 복호화(연락처, 이메일)
		
		
		
	}
    
    

	
	

}
