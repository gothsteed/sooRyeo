package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.dto.LoginDTO;

public interface AdminDao {
	
	// 관리자 로그인
	Admin selectAdmin(LoginDTO loginDTO);

	// select 태그에 학과를 전부 불러오는 메소드
	List<Department> departmentList_select();

	// 학생 회원 등록정보를 인서트 하는 메소드
	int memberRegister_end(RegisterDTO rdto);
	
	// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
	String emailDuplicateCheck(String email);

}
