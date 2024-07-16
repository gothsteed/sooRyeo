package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.model.BoardDao;

@Service
public class LectureNoticeService_imple implements LectureNoticeService {

	@Autowired
	private BoardDao bdao;
	
	@Override
	public Pager<BoardDTO> getLectureList(Map<String, Object> paraMap) {
		Pager<BoardDTO> getLectureList = bdao.getLectureList(paraMap);
		return getLectureList;
	}

	@Override
	public BoardDTO getView(Map<String, String> paraMap) {
		
		int n = bdao.increase_viewCount(paraMap.get("seq")); //
		BoardDTO bdto = bdao.getView(paraMap); // 글 1개 조회하기
		
		return bdto;
	}

	@Override
	public BoardDTO getView_no_increase_readCount(Map<String, String> paraMap) {
		
		BoardDTO bdto = bdao.getView(paraMap);
		return bdto;
		
	}

	@Override
	public int lectureNoticeWriteEnd(BoardDTO bdto) {
		int n = bdao.lectureNoticeWriteEnd(bdto);
		return n;
	}

	@Override
	public List<BoardDTO> getStaticList(String fk_course_seq) {
		List<BoardDTO> getStaticList = bdao.getStaticList(fk_course_seq);
		return getStaticList;
	}

	@Override
	public int del(Map<String, String> paraMap) {
		int n = bdao.del(paraMap);
		return n;
	}

	@Override
	public int edit(BoardDTO bdto) {
		int n = bdao.edit(bdto);
		return n;
	}

	////////////////////////////////////////////////////////////////////////
	
	// 학사공지사항 글의 개수를 알아오는 메소드
	@Override
	public int getA_TotalElementCount() {
		
		int A_totalElementCount = bdao.getA_TotalElementCount();
		return A_totalElementCount;	
	}
	@Override
	public Pager<Announcement> getAnnouncement(Map<String, Object> paraMap) {
		Pager<Announcement> announcementList = bdao.getAnnouncement(paraMap);
		return announcementList;
	}
	

	@Override
	public Announcement getA_View(Map<String, String> paraMap) {
		
		int n = bdao.increase_viewCount(paraMap.get("seq")); //
		Announcement an = bdao.getA_View(paraMap); // 글 1개 조회하기
		
		return an;
	}

	// 조회수 증가없이 글을 불러오는 메소드
	@Override
	public Announcement getA_View_no_increase_readCount(Map<String, String> paraMap) {
		
		Announcement an = bdao.getA_View(paraMap);
		return an;
		
	}

	// 고정글을 불러오는 메소드
	@Override
	public List<Announcement> getA_StaticList() {

		List<Announcement> getStaticList = bdao.getA_StaticList();
		return getStaticList;
	}

	// 공지사항 쓰기 메소드
	@Override
	public int addList(BoardDTO bdto) {

		int n = bdao.addList(bdto);
		return n;
	}

	// 공지사항을 삭제하는 메소드 
	@Override
	public int a_del(Map<String, String> paraMap) {
		int n = bdao.a_del(paraMap);
		return n;
	}

	// 공지사항을 수정하는 메소드 
	@Override
	public int a_edit(BoardDTO bdto) {
		int n = bdao.a_edit(bdto);
		return n;
	}
	
}
