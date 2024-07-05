package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import com.sooRyeo.app.dto.StudentDTO;

public interface StudentService {
	
	// 수업리스트 보여주기 
	List<Map<String, String>> classList(int userid);
	
	// 과제리스트 보여주기
	List<Map<String, String>> assignment_List(int userid);
	
	// 내정보 보기
	StudentDTO getViewInfo(HttpServletRequest request);

	// 내정보 수정
	int myInfoUpdate(StudentDTO student);

	// 이메일 중복확인
	String emailDuplicateCheck(String email);


	

	
	
	
}
