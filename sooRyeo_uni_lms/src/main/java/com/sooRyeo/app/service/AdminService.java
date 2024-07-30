package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.domain.StudentStatusChange;
import com.sooRyeo.app.dto.CurriculumRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;
import com.sooRyeo.app.dto.RegisterDTO;

public interface AdminService {

	// select 태그에 학과를 전부 불러오는 메소드
	List<Department> departmentList_select();

	// 학생 회원 등록정보를 인서트 하는 메소드
	int memberRegister_end(RegisterDTO rdto);
	
	// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
	String emailDuplicateCheck(String email);

	ModelAndView makeCourseRegiseterPage(HttpServletRequest request, ModelAndView mav);
	
	List<Department> getDeptartments();

	ModelAndView insertCurriculum(HttpServletRequest request, ModelAndView mav, CurriculumRequestDto requestDto);

	ModelAndView ShowCurriculumPage(HttpServletRequest request, ModelAndView mav);

	String getCurriculumPage(HttpServletRequest request, ModelAndView mav,CurriculumPageRequestDto requestDto);

	ResponseEntity<String> deleteCurriculum(HttpServletRequest request, ModelAndView mav);

	ResponseEntity<String> updateCurriculum(HttpServletRequest request, ModelAndView mav,
			CurriculumRequestDto requestDto);

	List<Map<String, String>> studentCntByDeptname();

	// 학적변경신청한 학생들을 전부 불러오는 메소드
	List<StudentStatusChange> application_status_student();

	// 관리자가 승인 혹은 반려한 신청을 삭제해주는 메소드
	int deleteApplication(String student_id);

	// 관리자가 승인을 해주면 학생의 학적 상태를 업데이트 해주는 메소드
	int updateStudentStatus(String student_id, String change_status);

	// 회원들의 정보를 불러오는 메소드
	List<Student> getStudenList();
	List<Professor> getProfessorList();




}