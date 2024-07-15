package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
