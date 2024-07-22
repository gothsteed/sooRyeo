package com.sooRyeo.app.mongo.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

public interface LogService {
	
	// 방문자 수 통계 
	ResponseEntity<String> showCount(HttpServletRequest request, HttpServletResponse response);

}
