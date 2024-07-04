package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

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
		
	} // end of public Student selectStudent


	// 수업명, 교수명  select
	@Override
	public List<Map<String, String>> classList(int userid) {
		List<Map<String, String>> classList = sqlSession.selectList("student.classList", userid);
		return classList;
	}

	// 내정보 보기
	@Override
	public StudentDTO getViewInfo(String login_userid) {
		
		StudentDTO member_student = sqlSession.selectOne("student.getViewInfo", login_userid);
		
		return member_student;
		
	} // end of public StudentDTO getViewInfo

	// 학과명 가져오기
	@Override
	public String select_department(Integer student_id) {
		
		String d_name = sqlSession.selectOne("student.select_department", student_id);
		
		return d_name;
	} // end of public String select_department

	// 이메일 중복확인
	@Override
	public String emailDuplicateCheck(String email) {
		
		String emailDuplicateCheck = sqlSession.selectOne("student.emailDuplicateCheck", email);
		
		return emailDuplicateCheck;
		
	} // end of public String emailDuplicateCheck
	
}
