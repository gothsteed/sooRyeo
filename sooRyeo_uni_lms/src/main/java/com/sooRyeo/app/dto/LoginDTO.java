package com.sooRyeo.app.dto;

import com.sooRyeo.app.common.Sha256;

public class LoginDTO {
	private Integer id;
	private String password;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = Sha256.encrypt(password);
	}
	
	
	/*
	 * public String getId() { return id; } public String getPassword() { return
	 * Sha256.encrypt(password); }
	 */
	
	
	

	
	
	
	

}
