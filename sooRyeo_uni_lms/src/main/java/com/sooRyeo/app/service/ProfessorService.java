package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Professor;

public interface ProfessorService {
	
	// 교수 내 정보 불러오기
	Professor getInfo(HttpServletRequest request);
	
	// 교수 비밀번호 중복확인
	JSONObject pwdDuplicateCheck(HttpServletRequest request);
	

}
