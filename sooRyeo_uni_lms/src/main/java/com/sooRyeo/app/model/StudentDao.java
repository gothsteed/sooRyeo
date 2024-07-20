package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Assignment;
import com.sooRyeo.app.domain.AssignmentSubmit;
import com.sooRyeo.app.domain.Attendance;
import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.AssignmentSubmitDTO;
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
	List<Map<String, String>> getassignment_List(String fk_course_seq, int userid);

	// 수업 - 내 강의 - 과제 - 상세내용1
	Map<String, Object> getassignment_detail_1(String schedule_seq_assignment);
	
	// 수업 - 내 강의 - 과제 - 상세내용2
	Map<String, Object> getassignment_detail_2(String schedule_seq_assignment, int userid);

	// 과제제출
	int addComment(AssignmentSubmitDTO asdto);
	
	// 교수 이름, 교수 번호 select
	List<Professor> select_prof_info(String fk_course_seq);

	// 스케줄, 상담 테이블에 insert
	int insert__schedule_consult(String prof_id, String title, String content, String start_date, String end_date, int userid);
	
	// ajax학생 수강과목 가져와서 학점 계산하기(chart)
	List<Map<String, String>> student_chart_credit(int student_id);

	// 과제 제출 내용보기
	Map<String, Object> getreadComment(String fk_schedule_seq_assignment, int userid);

	// 파일첨부가 되어진 과제에서 서버에 업로드되어진 파일명 조회
	AssignmentSubmitDTO getCommentOne(String assignment_submit_seq);

	// 로그인한 학생의 출석현황 보기
	List<Map<String, Object>> attendanceList(int student_id, String name);

	// 수업명 가져오기
	List<Curriculum> lectureList();

	
}
