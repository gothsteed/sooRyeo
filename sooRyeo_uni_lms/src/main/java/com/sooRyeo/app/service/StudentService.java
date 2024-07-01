package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import com.sooRyeo.app.dto.StudentDTO;

public interface StudentService {

	// 내정보 보기
	StudentDTO getViewInfo(HttpServletRequest request);
	

	
	
	
}
