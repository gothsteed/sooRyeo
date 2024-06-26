package com.sooRyeo.app.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;

@Repository
public class StudentDao_imple implements StudentDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	

	@Override
	public Student selectStudent(LoginDTO loginDTO) {
		
		
		Student student = sqlSession.selectOne("student.selectStudent", loginDTO);
		return student;
	}

}
