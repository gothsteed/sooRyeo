package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class FindDao_imple implements FindDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	

	// 아이디 찾기
	@Override
	public String idfind(String name, String memberEmail, String memberType) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("name", name);
		paraMap.put("email", memberEmail);
		paraMap.put("memberType", memberType);
		
		String userid = sqlSession.selectOne("find.idfind", paraMap);
		return userid;
	}


	// 데이터베이스에 회원이 존재하는지 확인하는 메소드
	@Override
	public boolean memberCheck(String id, String memberEmail, String memberType) {

		boolean isUserExist = false;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("id", id);
		paraMap.put("email", memberEmail);
		paraMap.put("memberType", memberType);
		
		String userid = sqlSession.selectOne("find.memberCheck", paraMap);
		System.out.println(userid);
		if(userid != null) {
			isUserExist = true;
		}
		
		return isUserExist;
	}


	// 비밀번호 변경
	@Override
	public int pwdFindEnd(String memberpwd, String userid, String memberType) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("pwd", memberpwd);
		paraMap.put("userid", userid);
		paraMap.put("memberType", memberType);
		
		int n = sqlSession.update("find.pwdFindEnd", paraMap);
		return n;
	}

}
