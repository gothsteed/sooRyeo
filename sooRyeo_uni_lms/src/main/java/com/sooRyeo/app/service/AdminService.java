package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.CurriculumRequestDto;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;
import com.sooRyeo.app.dto.RegisterDTO;

public interface AdminService {

	// select 태그에 학과를 전부 불러오는 메소드
	List<Department> departmentList_select();

	// 학생 회원 등록정보를 인서트 하는 메소드
	int memberRegister_end(RegisterDTO rdto);
	
	// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
	String emailDuplicateCheck(String email);

	List<Department> getDeptartments();

	ModelAndView insertCurriculum(HttpServletRequest request, ModelAndView mav, CurriculumRequestDto requestDto);

	ModelAndView ShowCurriculumPage(HttpServletRequest request, ModelAndView mav);

	String getCurriculumPage(HttpServletRequest request, ModelAndView mav,CurriculumPageRequestDto requestDto);

	// 학사공지사항 리스트를 select 해오는 메소드
	Pager<Announcement> getAnnouncement(Map<String, Object> paraMap);

	ResponseEntity<String> deleteCurriculum(HttpServletRequest request, ModelAndView mav);

	ResponseEntity<String> updateCurriculum(HttpServletRequest request, ModelAndView mav,
			CurriculumRequestDto requestDto);

	// 학사공지사항 글의 개수를 알아오는 메소드
	int getTotalElementCount();
	ModelAndView makeCourseRegiseterPage(HttpServletRequest request, ModelAndView mav);

	// 글 한개를 불러오는 메소드
	Announcement getView(Map<String, String> paraMap);

	// 조회수 증가없이 글을 불러오는 메소드
	Announcement getView_no_increase_readCount(Map<String, String> paraMap);

	// 고정글을 불러오는 메소드
	List<Announcement> getStaticList();

	// 공지사항 쓰기 메소드
	int addList(BoardDTO bdto);

	// 공지사항을 삭제하는 메소드 
	int del(Map<String, String> paraMap);

	// 공지사항을 수정하는 메소드 
	int edit(BoardDTO bdto);


}