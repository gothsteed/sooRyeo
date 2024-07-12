package com.sooRyeo.app.service;

import java.util.Map;

import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;

public interface LectureNoticeService {

	Pager<BoardDTO> getLectureList(Map<String, Object> paraMap);

	BoardDTO getView(Map<String, String> paraMap);

	BoardDTO getView_no_increase_readCount(Map<String, String> paraMap);

}