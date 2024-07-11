package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.AssignJoinSchedule;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.domain.TimeTable;
import com.sooRyeo.app.dto.AssignScheInsertDTO;
import com.sooRyeo.app.dto.LoginDTO;

public interface ProfessorDao {
	
	// 교수 로그인
	Professor selectProfessor(LoginDTO loginDTO);
	
	// 교수 내정보
	Professor getInfo(Professor loginuser);
	
	// 교수 비밀번호 중복확인
	int pwdDuplicateCheck(Map<String, String> paraMap);
	
	// 교수 전화번호 중복확인
	int telDuplicateCheck(Map<String, String> paraMap);
	
	// 교수 이메일 중복확인
	int emailDuplicateCheck(Map<String, String> paraMap);
	
	// 교수 정보 수정 
	int professor_info_edit(Map<String, String> editMap);
	
	// 계정에 파일이 있는지 확인
	Professor select_file_name(Map<String, String> editMap);
	
	// 계정에 기존 파일 삭제
	int delFilename(String prof_id);
	
	// 교수 진행 강의 목록 2
	ProfessorTimeTable getProfTimeTable(int prof_id);
	
	// 강의 수강생 목록 
	List<Map<String, String>> studentList(String fk_course_seq);
	
	// 교수 시험, 과제관리
	List<Map<String, String>> paperAssignment(String fk_course_seq);
	
	// 과제 상세보기
	AssignJoinSchedule assign_view(Map<String, String> paraMap);
	
	// 스케쥴 테이블 인풋
	int insert_tbl_schedule(AssignScheInsertDTO dto, String fk_course_seq);
	
	// // 과제 삭제
	int assignmentDelete(String schedule_seq_assignment);
	
	

	


}
