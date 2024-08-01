package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.domain.StudentStatusChange;
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


	// 학적변경신청한 학생들을 전부 불러오는 메소드
	@Override
	public List<StudentStatusChange> application_status_student() {
		List<StudentStatusChange> application_status_student = sqlSession.selectList("admin.application_status_student");
		return application_status_student;
	}

	// 관리자가 승인 혹은 반려한 신청을 삭제해주는 메소드
	@Override
	public int deleteApplication(String student_id) {
		int n = sqlSession.delete("admin.deleteApplication", student_id);
		return n;
	}

	// 관리자가 승인을 해주면 학생의 학적 상태를 업데이트 해주는 메소드
	@Override
	public int updateStudentStatus(String student_id, String change_status) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("student_id", student_id);
		paraMap.put("change_status", change_status);
		
		int n = sqlSession.update("admin.updateStudentStatus", paraMap);
		return n;
	}


	@Override
	public List<Student> getStudenList() {
		List<Student> studenList = sqlSession.selectList("admin.getStudenList");
		return studenList;
	}


	@Override
	public List<Professor> getProfessorList() {
		List<Professor> professor = sqlSession.selectList("admin.getProfessorList");
		return professor;
	}


}
