package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.dto.RegisterDTO;

public interface ProfessorService {
	
	// 교수 내 정보 불러오기
	Professor getInfo(HttpServletRequest request);
	
	// 교수 비밀번호 중복확인
	JSONObject pwdDuplicateCheck(HttpServletRequest request);
	
	// 교수 전화번호 중복확인
	JSONObject telDuplicateCheck(HttpServletRequest request);
	
	// 교수 이메일 중복확인
	JSONObject emailDuplicateCheck(HttpServletRequest request);
	
	// 교수 정보 수정
	int professor_info_edit(HttpServletRequest request, Professor professor);
	

}
