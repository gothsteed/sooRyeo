package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.RegisterDTO;

public interface AdminDao {
	
	// 관리자 로그인
	Admin selectAdmin(LoginDTO loginDTO);

	// 학생 회원 등록정보를 인서트 하는 메소드
	int memberRegister_end(RegisterDTO rdto);
	
	// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
	String emailDuplicateCheck(String email);

	// 학사공지사항 리스트를 select 해오는 메소드
	Pager<Announcement> getAnnouncement(Map<String, Object> paraMap);

	// 학사공지사항 글의 개수를 알아오는 메소드
	int getTotalElementCount();
	
	// 글 한개를 불러오는 메소드
	Announcement getView(Map<String, String> paraMap);

	// 조회수를 증가시키는 메소드
	int increase_viewCount(String string);

	// 고정글을 불러오는 메소드
	List<Announcement> getStaticList();

	// 공지사항 쓰기 메소드
	int addList(BoardDTO bdto);

}
