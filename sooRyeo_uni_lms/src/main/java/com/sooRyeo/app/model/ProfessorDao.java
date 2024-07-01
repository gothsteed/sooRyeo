package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.dto.LoginDTO;

public interface ProfessorDao {
	
	// 교수 로그인
	Professor selectProfessor(LoginDTO loginDTO);
	
	// 교수 내정보
	Professor getInfo(Professor loginuser);
	
	// 교수 비밀번호 중복확인
	int pwdDuplicateCheck(String pwd);


}
