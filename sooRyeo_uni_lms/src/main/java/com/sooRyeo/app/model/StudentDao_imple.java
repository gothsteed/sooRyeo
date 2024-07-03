package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

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


	// 수업명, 교수명  select
	@Override
	public List<Map<String, String>> classList(int userid) {
		List<Map<String, String>> classList = sqlSession.selectList("student.classList", userid);
		return classList;
	}

}
