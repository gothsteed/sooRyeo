package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.model.StudentDao;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.StudentDTO;




@Service
public class StudentService_imple implements StudentService {
	
	@Autowired
	private StudentDao dao;
	
	@Autowired
	private AES256 aes;

	// 내수업리스트
	@Override
	public List<Map<String, String>> classList(int userid) {
		
		List<Map<String, String>> classList = dao.classList(userid);
		return classList;
	}
	
	
	// 내정보 보기
	@Override
	public StudentDTO getViewInfo(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student) session.getAttribute("loginuser");
		
		
		StudentDTO member_student = new StudentDTO();
		member_student.setName(loginuser.getName());			// 이름
		member_student.setGrade(loginuser.getGrade());			// 학년
		member_student.setStatus(loginuser.getStatus());		// 학적
		member_student.setBirthday(loginuser.getBirthday());  	// 생년월일
		member_student.setTel(loginuser.getTel()); 				// 연락처
		member_student.setEmail(loginuser.getEmail()); 			// 이메일
		member_student.setAddress(loginuser.getAddress()); 		// 주소
		
		// 학과명 가져오기
		String d_name = dao.select_department(loginuser.getStudent_id());
		member_student.setDepartment_name(d_name);
		
		
		
		return member_student;
		
	} // end of public void getViewInfo

	
	// 내정보 수정
	@Override
	public int myInfoUpdate(StudentDTO student) {
		
		System.out.println(student.getTel());
		
		
		return 0;
	} // end of public int myInfoUpdate


	// 이메일 중복확인
	@Override
	public String emailDuplicateCheck(String email) {
		
		String emailDuplicateCheck = "";
		try {
			emailDuplicateCheck = dao.emailDuplicateCheck(aes.encrypt(email));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return emailDuplicateCheck;
		
	} // end of public String emailDuplicateCheck

	
	
	
}
