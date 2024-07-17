package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.RegisterDTO;

public interface AdminDao {
	
	// 관리자 로그인
	Admin selectAdmin(LoginDTO loginDTO);

	// 학생 회원 등록정보를 인서트 하는 메소드
	int memberRegister_end(RegisterDTO rdto);
	
	// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
	String emailDuplicateCheck(String email);

	List<Map<String, String>> studentCntByDeptname();

	// 학생회원을 불러오는 메소드
	List<Student> getStudentList();



}
