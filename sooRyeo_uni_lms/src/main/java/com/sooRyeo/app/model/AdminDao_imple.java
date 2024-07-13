package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.RegisterDTO;

@Repository
public class AdminDao_imple implements AdminDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Admin selectAdmin(LoginDTO loginDTO) {
		
		Admin admin = sqlSession.selectOne("admin.selectAdmin", loginDTO);
		return admin;
	}


	// 학생 회원 등록정보를 인서트 하는 메소드
	@Override
	public int memberRegister_end(RegisterDTO rdto) {
		int n = sqlSession.insert("admin.memberRegister_end", rdto);
		return n;
	}
	
	@Override
	public String emailDuplicateCheck(String email) {
		String emailDuplicateCheck = sqlSession.selectOne("admin.emailDuplicateCheck", email);
		return emailDuplicateCheck;
	}

	@Override
	public Pager<Announcement> getAnnouncement(Map<String, Object> paraMap) {
		
		int sizePerPage = 10;
		
		int currentPage = (int) paraMap.get("currentPage");
		
		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		
		
		paraMap.put("startRno", startRno);
		paraMap.put("endRno", endRno);
		paraMap.put("currentShowPageNo", currentPage);
		List<Announcement> announcementList = sqlSession.selectList("admin.getAnnouncement", paraMap);
		
		int totalElementCount = sqlSession.selectOne("admin.getTotalElementCount", paraMap);
		
		return new Pager(announcementList, currentPage, sizePerPage, totalElementCount);
	}

	// 학사공지사항 글의 개수를 알아오는 메소드
	@Override
	public int getTotalElementCount() {
		int n = sqlSession.selectOne("admin.getTotalElementCount");
		return n;
	}


	@Override
	public Announcement getView(Map<String, String> paraMap) {
		Announcement an = sqlSession.selectOne("admin.getView", paraMap);
		return an;
	}


	@Override
	public int increase_viewCount(String seq) {
		int n = sqlSession.update("admin.increase_readCount", seq);
		return n;
	}


	// 고정글을 불러오는 메소드
	@Override
	public List<Announcement> getStaticList() {
		List<Announcement> getStaticList = sqlSession.selectList("admin.getStaticList");
		return getStaticList;
	}


	@Override
	public int addList(BoardDTO bdto) {
		int n = sqlSession.insert("admin.addList", bdto);
		return n;
	}


	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlSession.delete("admin.del", paraMap);
		return n;
	}


	@Override
	public int edit(BoardDTO bdto) {
		int n = sqlSession.update("admin.edit", bdto);
		return n;
	}


}
