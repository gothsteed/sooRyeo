package com.sooRyeo.app.model;


public interface FindDao {
	
	
	// 아이디 찾기
	String idfind(String name, String memberEmail, String memberType);
	
	// 데이터베이스에 회원이 존재하는지 확인하는 메소드
	boolean memberCheck(String id, String memberEmail, String memberType);

	// 비밀번호 변경
	int pwdFindEnd(String memberpwd, String userid, String memberType);
	
	

}
