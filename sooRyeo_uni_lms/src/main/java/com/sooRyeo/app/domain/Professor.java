package com.sooRyeo.app.domain;

import java.util.Date;

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
	
	
	
    
    
    

}
