package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Professor;

public interface ProfessorService {
	
	// 교수 내 정보 불러오기
	Professor getInfo(HttpServletRequest request);
	

}
