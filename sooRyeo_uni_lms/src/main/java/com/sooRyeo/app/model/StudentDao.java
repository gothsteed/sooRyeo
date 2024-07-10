package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Assignment;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.StudentDTO;

public interface StudentDao {

	Student selectStudent(LoginDTO loginDTO);

	// 수업리스트 보여주기
	List<Map<String, String>> classList(int userid);
	
	// 내정보 보기
	StudentDTO getViewInfo(String login_userid);

	// 학과명 가져오기
	String select_department(Integer student_id);

	// 학생 비밀번호 중복확인
	int pwdDuplicateCheck(Map<String, String> paraMap);

	// 학생 전화번호 중복확인
	int telDuplicateCheck(Map<String, String> paraMap);

	// 학생 이메일 중복확인
	int emailDuplicateCheck(Map<String, String> paraMap);

	// 계정에 파일이 있는지 확인
	String select_file_name(Map<String, String> paraMap);

	// 계정에 기존 파일 삭제
	int delFilename(String student_id);

	// 학생 정보 수정
	int student_info_edit(Map<String, String> paraMap);

	// 수업  - 내 강의보기
	List<Lecture> getlectureList(String fk_course_seq);

	// 수업 - 이번주 강의보기
	List<Lecture> getlectureList_week(String fk_course_seq);

	// 수업 - 내 강의 - 과제
	List<Map<String, String>> getassignment_List(String fk_course_seq);

	// 수업 - 내 강의 - 과제 - 제출
	List<Map<String, String>> getassignment_detail_List(String schedule_seq_assignment);

}
