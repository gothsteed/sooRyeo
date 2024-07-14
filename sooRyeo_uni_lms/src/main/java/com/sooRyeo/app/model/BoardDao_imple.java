package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;

@Repository
public class BoardDao_imple implements BoardDao {

	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Pager<BoardDTO> getLectureList(Map<String, Object> paraMap) {
		
		int sizePerPage = 10;
		
		int currentPage = (int) paraMap.get("currentPage");
		
		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		
		paraMap.put("startRno", startRno);
		paraMap.put("endRno", endRno);
		paraMap.put("currentShowPageNo", currentPage);
		List<BoardDTO> lec_List = sqlSession.selectList("board.getLectureList", paraMap);
		
		int totalElementCount = sqlSession.selectOne("board.getTotalElementCount", paraMap);
		
		return new Pager(lec_List, currentPage, sizePerPage, totalElementCount);
	}

	@Override
	public int increase_viewCount(String seq) {
		int n = sqlSession.update("board.increase_readCount", seq);
		return n;
	}

	@Override
	public BoardDTO getView(Map<String, String> paraMap) {
		BoardDTO bdto = sqlSession.selectOne("board.getView", paraMap);
		return bdto;
	}

	@Override
	public int lectureNoticeWriteEnd(BoardDTO bdto) {
		int n = sqlSession.insert("board.lectureNoticeWriteEnd", bdto);
		return n;
	}

	@Override
	public List<BoardDTO> getStaticList(String fk_course_seq) {
		List<BoardDTO> getStaticList = sqlSession.selectList("board.getStaticList", fk_course_seq);
		return getStaticList;
	}

	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlSession.delete("board.del", paraMap);
		return n;
	}

}
