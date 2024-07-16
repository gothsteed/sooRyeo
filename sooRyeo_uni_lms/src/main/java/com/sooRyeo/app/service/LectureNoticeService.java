package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;

public interface LectureNoticeService {

	Pager<BoardDTO> getLectureList(Map<String, Object> paraMap);

	BoardDTO getView(Map<String, String> paraMap);

	BoardDTO getView_no_increase_readCount(Map<String, String> paraMap);

	int lectureNoticeWriteEnd(BoardDTO bdto);

	List<BoardDTO> getStaticList(String fk_course_seq);

	int del(Map<String, String> paraMap);

	int edit(BoardDTO bdto);

	//////////////////////////////////////////////////////////////////////
	
	// 학사공지사항 리스트를 select 해오는 메소드
	Pager<Announcement> getAnnouncement(Map<String, Object> paraMap);

	// 학사공지사항 글의 개수를 알아오는 메소드
	int getA_TotalElementCount();
	
	// 글 한개를 불러오는 메소드
	Announcement getA_View(Map<String, String> paraMap);

	// 조회수 증가없이 글을 불러오는 메소드
	Announcement getA_View_no_increase_readCount(Map<String, String> paraMap);

	// 고정글을 불러오는 메소드
	List<Announcement> getA_StaticList();

	// 공지사항 쓰기 메소드
	int addList(BoardDTO bdto);

	// 공지사항을 삭제하는 메소드 
	int a_del(Map<String, String> paraMap);

	// 공지사항을 수정하는 메소드 
	int a_edit(BoardDTO bdto);

}
