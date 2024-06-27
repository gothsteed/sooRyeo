package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.dto.LoginDTO;

public interface ProfessorDao {
	
	// 교수 로그인
	Professor selectProfessor(LoginDTO loginDTO);


}
