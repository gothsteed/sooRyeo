package com.sooRyeo.app.domain;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Date;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.sooRyeo.app.common.AES256;

public class Professor {
	
    private Integer prof_id;
    private String pwd;
    private String name;
    private String jubun;
    private String tel;
    private Integer department_seq;
    private String email;
    private String office_address;
    private Short employment_stat;
    private Date employment_date;
    private String img_name;
    
    private Department department;
    
    private Course course;
    
    private Curriculum curriculum;
    
    private MultipartFile attach;
    
    
	public Integer getProf_id() {
		return prof_id;
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
	public Integer getDepartment_seq() {
		return department_seq;
	}
	public String getEmail() {
		return email;
	}
	public String getOffice_address() {
		return office_address;
	}
	public Short getEmployment_stat() {
		return employment_stat;
	}
	public Date getEmployment_date() {
		return employment_date;
	}
	
	public String getImg_name() {
		return img_name;
	}
	
	
	
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}	
	public Curriculum getCurriculum() {
		return curriculum;
	}
	public void setCurriculum(Curriculum curriculum) {
		this.curriculum = curriculum;
	}
	
	
	
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
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
	
	
	public void updateinfo(Map<String, String> paraMap) {
		
		prof_id = Integer.parseInt(paraMap.get("prof_id"));
		pwd = paraMap.get("pwd");
		office_address = paraMap.get("address");
		email = paraMap.get("email");
		tel	= paraMap.get("tel");
		img_name = paraMap.get("img_name");
		
		
	}
    
    
    

}
