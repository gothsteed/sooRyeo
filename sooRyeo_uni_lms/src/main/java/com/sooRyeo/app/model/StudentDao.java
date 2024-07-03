package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.StudentDTO;

public interface StudentDao {

	Student selectStudent(LoginDTO loginDTO);

	// 내정보 보기
	StudentDTO getViewInfo(String login_userid);

	// 학과명 가져오기
	String select_department(Integer student_id);

	// 이메일 중복확인
	String emailDuplicateCheck(String email);

}
