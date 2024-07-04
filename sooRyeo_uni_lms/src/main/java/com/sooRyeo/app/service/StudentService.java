package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sooRyeo.app.dto.StudentDTO;

public interface StudentService {
	
	// 수업명, 교수명  select 
	List<Map<String, String>> classList(int userid);
	
	

	// 내정보 보기
	StudentDTO getViewInfo(HttpServletRequest request);

	// 학생 비밀번호 중복확인
	JSONObject pwdDuplicateCheck(HttpServletRequest request);

	// 학생 전화번호 중복확인
	JSONObject telDuplicateCheck(HttpServletRequest request);

	// 학생 이메일 중복확인
	JSONObject emailDuplicateCheck(HttpServletRequest request);

	// 학생 정보 수정
	int student_info_edit(StudentDTO student, MultipartHttpServletRequest mrequest);
	

	
	
	
}
