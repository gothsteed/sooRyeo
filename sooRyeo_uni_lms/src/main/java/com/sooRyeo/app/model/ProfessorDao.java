package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.AssignJoinSchedule;
import com.sooRyeo.app.domain.Assignment;
import com.sooRyeo.app.domain.AssignmentSubmit;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Pager;
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
	Pager<Map<String, String>> studentList(String fk_course_seq, int currentPage);
	
	// 교수 시험, 과제관리
	List<Map<String, String>> paperAssignment(String fk_course_seq);
	
	// 과제 상세보기
	AssignJoinSchedule assign_view(Map<String, String> paraMap);
	
	// 스케쥴 테이블 인풋
	int insert_tbl_schedule(AssignScheInsertDTO dto, String fk_course_seq);
	
	// 과제첨부 파일이 있는지 확인
	Assignment select_attached_name(String schedule_seq_assignment);
	
	// 과제 삭제
	int assignmentDelete(String schedule_seq_assignment);
	
	// 과제 수정
	AssignJoinSchedule assignmentEdit(String schedule_seq_assignment);
	
	// 첨부파일 삭제 
	int delAttatched_file(String schedule_seq_assignment);
	
	// 과제 수정
	int assignmentEdit_End(AssignScheInsertDTO dto);
	
	// 첨부파일 유무 확인
	AssignScheInsertDTO file_check(String schedule_seq_assignment);
	
	// 과제제출확인제이슨
	List<Map<String, String>> assignmentCheckJSON(String schedule_seq_assignment);
	
	// 점수 입력
	int scoreUpdate(Map<String, String> paraMap);
	
	// 다운로드를 위해 파일 찾기
	Assignment searchFile(String schedule_seq_assignment);

	int getTotalElementCount(String fk_course_seq);

	Pager<Announcement> getAnnouncement(int currentPage);
	
	// 학기 별 개강과목
	ProfessorTimeTable courseListJson(String semester, int prof_id);
	
	// 특정 학생 사진 가져오기
	String Student_pic(int student_id);
	
	// 특정학생 과목 점수들 가져오기
	Map<String, Object> score_checkJSON(int student_id, int fk_course_seq);
	
	// 학생 학점 입력해주기
	int insertGradeEnd(Map<String, Object> paraMap);
	
	// 학생 학점 수정하기
	int editGradeEnd(Map<String, Object> paraMap);
	
	// 특정과목 총 시험 갯수 가져오기
	int examCount(int fk_course_seq);
	
	// 학생 출석률 가져오기
	double attendanceRate(int student_id, int fk_course_seq);
	
	// 학생 첨부 파일 다운로드위해 파일 찾기
	AssignmentSubmit searchsubmitFile(String assignment_submit_seq);

	
	
	

	


}
