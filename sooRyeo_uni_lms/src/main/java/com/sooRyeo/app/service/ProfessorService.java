package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.AssignJoinSchedule;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
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
	int professor_info_edit(Professor professor, MultipartHttpServletRequest mrequest);
	
	// 교수 진행 강의 목록 
	ProfessorTimeTable courseList(int prof_id);
	
	// 강의 수강생 목록
	List<Map<String, String>> studentList(String fk_course_seq);
	
	// 교수 시험, 과제관리
	List<Map<String, String>> paperAssignment(String fk_course_seq);
	
	// 과제 상세보기
	AssignJoinSchedule assign_view(String fk_course_seq);
	

}
