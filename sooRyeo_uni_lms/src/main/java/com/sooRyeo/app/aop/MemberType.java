package com.sooRyeo.app.aop;

public enum MemberType {
	STUDENT("student"),
	PROFESSOR("professor"),
	ADMIN("admin");
	
	public final String desc;
	
	
	private MemberType(String desc) {
		this.desc = desc;
	}
	
	
	
	

}
