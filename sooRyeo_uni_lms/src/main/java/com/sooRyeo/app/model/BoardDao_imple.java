package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Announcement;
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

	@Override
	public int edit(BoardDTO bdto) {
		int n = sqlSession.update("board.edit", bdto);
		return n;
	}
	
	///////////////////////////////////////////////////////////////////////////
	
	
	@Override
	public Pager<Announcement> getAnnouncement(Map<String, Object> paraMap) {
		
		int sizePerPage = 10;
		
		int currentPage = (int) paraMap.get("currentPage");
		
		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		
		
		paraMap.put("startRno", startRno);
		paraMap.put("endRno", endRno);
		paraMap.put("currentShowPageNo", currentPage);
		List<Announcement> announcementList = sqlSession.selectList("board.getAnnouncement", paraMap);
		
		int A_totalElementCount = sqlSession.selectOne("board.getA_TotalElementCount", paraMap);
		return new Pager(announcementList, currentPage, sizePerPage, A_totalElementCount);
	}

	// 학사공지사항 글의 개수를 알아오는 메소드
	@Override
	public int getA_TotalElementCount() {
		int n = sqlSession.selectOne("board.getTotalElementCount");
		return n;
	}


	@Override
	public Announcement getA_View(Map<String, String> paraMap) {
		Announcement an = sqlSession.selectOne("board.getA_View", paraMap);
		return an;
	}


	@Override
	public int a_increase_viewCount(String seq) {
		int n = sqlSession.update("board.a_increase_viewCount", seq);
		return n;
	}


	// 고정글을 불러오는 메소드
	@Override
	public List<Announcement> getA_StaticList() {
		List<Announcement> getA_StaticList = sqlSession.selectList("board.getA_StaticList");
		return getA_StaticList;
	}


	@Override
	public int addList(BoardDTO bdto) {
		int n = sqlSession.insert("board.addList", bdto);
		return n;
	}


	@Override
	public int a_del(Map<String, String> paraMap) {
		int n = sqlSession.delete("board.a_del", paraMap);
		return n;
	}


	@Override
	public int a_edit(BoardDTO bdto) {
		int n = sqlSession.update("board.a_edit", bdto);
		return n;
	}
	
}
