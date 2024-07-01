package com.sooRyeo.app.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.StudentDTO;

@Repository
public class StudentDao_imple implements StudentDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	
	// 학생 로그인
	@Override
	public Student selectStudent(LoginDTO loginDTO) {
		
		Student student = sqlSession.selectOne("student.selectStudent", loginDTO);
		
		return student;
	}

	// 내정보 보기
	@Override
	public StudentDTO getViewInfo(String login_userid) {
		
		StudentDTO member_student = sqlSession.selectOne("student.getViewInfo", login_userid);
		
		return member_student;
	}

	// 학과명 가져오기
	@Override
	public String select_department(Integer student_id) {
		
		String d_name = sqlSession.selectOne("student.select_department", student_id);
		
		return d_name;
	} 
	
}
