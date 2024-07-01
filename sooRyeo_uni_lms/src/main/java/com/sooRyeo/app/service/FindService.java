package com.sooRyeo.app.service;


public interface FindService {

	
	// 아이디 찾기
	String idFind(String name, String email, String memberType);

	// 데이터베이스에 회원이 존재하는지 확인하는 메소드
	boolean memberCheck(String id, String email, String memberType);
	
	// 비밀번호 변경
	int pwdFindEnd(String pwd, String userid, String memberType);
	


	
}
