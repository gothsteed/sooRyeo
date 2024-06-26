package com.sooRyeo.app.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.dto.CurriculumInsertRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;
import com.sooRyeo.app.dto.RegisterDTO;

public interface AdminService {

	// select 태그에 학과를 전부 불러오는 메소드
	List<Department> departmentList_select();

	// 학생 회원 등록정보를 인서트 하는 메소드
	int memberRegister_end(RegisterDTO rdto);

	List<Department> getDeptartments();

	ModelAndView insertCurriculum(HttpServletRequest request, ModelAndView mav, CurriculumInsertRequestDto requestDto);

	ModelAndView ShowCurriculumPage(HttpServletRequest request, ModelAndView mav);

	String getCurriculumPage(HttpServletRequest request, ModelAndView mav,CurriculumPageRequestDto requestDto);


}
