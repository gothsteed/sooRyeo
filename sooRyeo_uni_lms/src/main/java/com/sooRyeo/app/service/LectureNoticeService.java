package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;

public interface LectureNoticeService {

	Pager<BoardDTO> getLectureList(Map<String, Object> paraMap);

	BoardDTO getView(Map<String, String> paraMap);

	BoardDTO getView_no_increase_readCount(Map<String, String> paraMap);

	int lectureNoticeWriteEnd(BoardDTO bdto);

	List<BoardDTO> getStaticList(String fk_course_seq);

	int del(Map<String, String> paraMap);


}
