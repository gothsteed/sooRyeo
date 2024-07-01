package com.sooRyeo.app.dto;

import com.sooRyeo.app.common.Sha256;

public class RegisterDTO {
	
	private String name;
	private String pwd;
	private String email;
	private String jubun;
	private String tel;
	private String fk_department_seq;
	private String address;
	private String register_year;
	private String grade;

	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = Sha256.encrypt(pwd);
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJubun() {
		return jubun;
	}
	public void setJubun(String jubun) {
		this.jubun = jubun;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFk_department_seq() {
		return fk_department_seq;
	}
	public void setFk_department_seq(String fk_department_seq) {
		this.fk_department_seq = fk_department_seq;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRegister_year() {
		return register_year;
	}
	public void setRegister_year(String register_year) {
		this.register_year = register_year;
	}
	
}
