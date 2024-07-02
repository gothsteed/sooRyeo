package com.sooRyeo.app.model;

import java.util.Map;

import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.dto.LoginDTO;

public interface ProfessorDao {
	
	// 교수 로그인
	Professor selectProfessor(LoginDTO loginDTO);
	
	// 교수 내정보
	Professor getInfo(Professor loginuser);
	
	// 교수 비밀번호 중복확인
	int pwdDuplicateCheck(String pwd);
	
	// 교수 전화번호 중복확인
	int telDuplicateCheck(Map<String, String> paraMap);
	
	// 교수 이메일 중복확인
	int emailDuplicateCheck(Map<String, String> paraMap);
	
	// 교수 정보 수정 
	int professor_info_edit(Map<String, String> paraMap);


}
