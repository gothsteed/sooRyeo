package com.sooRyeo.app.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.dto.LoginDTO;

@Repository
public class ProfessorDao_imple implements ProfessorDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	
	
	

	@Override
	public Professor selectProfessor(LoginDTO loginDTO) {
		
		Professor professor = sqlSession.selectOne("professor.selectProfessor", loginDTO);
		return professor;
	}


	@Override
	public Professor getInfo(Professor loginuser) {
		
		Professor professor = sqlSession.selectOne("professor.selectInfo", loginuser);		
		
		return professor;
	}


	@Override
	public int pwdDuplicateCheck(String pwd) {
		
		// System.out.println("확인용 pwd : "+ pwd);
		
		int n = sqlSession.selectOne("professor.pwdDuplicateCheck", pwd);
		
		return n;
	}


	@Override
	public int telDuplicateCheck(Map<String, String> paraMap) {
		
		int n = sqlSession.selectOne("professor.telDuplicateCheck", paraMap);
		
		return n;
	}


	@Override
	public int emailDuplicateCheck(Map<String, String> paraMap) {
		
		int n = sqlSession.selectOne("professor.emailDuplicateCheck", paraMap);
		
		return n;
	}




}
