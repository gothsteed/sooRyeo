package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;

public interface BoardDao {

	Pager<BoardDTO> getLectureList(Map<String, Object> paraMap);

	int increase_viewCount(String string);

	BoardDTO getView(Map<String, String> paraMap);

	int lectureNoticeWriteEnd(BoardDTO bdto);

	List<BoardDTO> getStaticList(String fk_course_seq);

	int del(Map<String, String> paraMap);

	int edit(BoardDTO bdto);

}
