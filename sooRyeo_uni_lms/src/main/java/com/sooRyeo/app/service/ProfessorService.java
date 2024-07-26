package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.AssignJoinSchedule;
import com.sooRyeo.app.domain.Assignment;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.dto.AssignScheInsertDTO;
import com.sooRyeo.app.dto.RegisterDTO;

public interface ProfessorService {
	
	// 교수 내 정보 불러오기
	Professor getInfo(HttpServletRequest request);
	
	// 교수 비밀번호 중복확인
	JSONObject pwdDuplicateCheck(HttpServletRequest request);
	
	// 교수 전화번호 중복확인
	JSONObject telDuplicateCheck(HttpServletRequest request);
	
	// 교수 이메일 중복확인
	JSONObject emailDuplicateCheck(HttpServletRequest request);
	
	// 교수 정보 수정
	int professor_info_edit(Professor professor, MultipartHttpServletRequest mrequest);
	
	// 교수 진행 강의 목록 
	ProfessorTimeTable courseList(int prof_id);
	
	// 강의 수강생 목록
	Pager<Map<String, String>> studentList(String fk_course_seq, int currentPage);
	
	// 학사공지사항 글의 개수를 알아오는 메소드
	int getTotalElementCount(String fk_course_seq);
	
	// 교수 시험, 과제관리
	List<Map<String, String>> paperAssignment(String fk_course_seq);
	
	// 과제 상세보기
	AssignJoinSchedule assign_view(Map<String, String> paraMap);
	
	// 스케쥴 테이블 인풋
	int insert_tbl_schedule(AssignScheInsertDTO dto, String fk_course_seq);
	
	// 과제 삭제
	int assignmentDelete(String schedule_seq_assignment, MultipartHttpServletRequest mrequest);
	
	// 과제 수정
	AssignJoinSchedule assignmentEdit(String schedule_seq_assignment);
	
	// 첨부파일 삭제
	int fileDelete(MultipartHttpServletRequest mrequest, String attatched_file, String schedule_seq_assignment);
	
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

	Pager<Announcement> getAnnouncement(int currentPage);
	
	// 학기 별 개강과목
	ProfessorTimeTable courseListJson(String semester, int prof_id);
	
	// 특정학생 과목 점수들 가져오기
	Map<String, Object> score_checkJSON(int student_id, int fk_course_seq);
	
	
	

}
