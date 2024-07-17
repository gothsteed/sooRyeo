package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Admin;
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
	public List<Map<String, String>> studentCntByDeptname() {
		List<Map<String, String>> deptnamePercentageList = sqlSession.selectList("admin.deptnamePercentageList");
		return deptnamePercentageList;
	}

}
