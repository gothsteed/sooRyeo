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

	// 수업 - 내 강의 - 과제 - 상세내용
	List<Map<String, String>> getassignment_detail_List(String schedule_seq_assignment);

	// 교수 이름, 교수 번호 select
	List<Professor> select_prof_info(String fk_course_seq);

	// 스케줄, 상담 테이블에 insert
	int insert__schedule_consult(String prof_id, String title, String content, String start_date, String end_date, int userid);

	// 수업 - 강의 한개 제목, 내용 select
	Map<String, String> classPlay_One(String lecture_seq);

	// 출석 테이블에 내가 수강한 수업이 insert 되어진 값이 있는지 알아오기 위함
	String select_tbl_attendance(String lecture_seq, int userid);
	
	// 처음 동영상을 재생한 경우 tbl_attendance 에 insert
	int insert_tbl_attendance(String play_time, String lecture_seq, int userid);

	// 동영상 재생이력이 있는 경우 tbl_attendance play_time 컬럼 update
	int update_tbl_attendance(String play_time, String lecture_seq, int userid);

	// play_time 컬럼과 lecture_time 컬럼을 비교 
	int select_play_time_lecture_time(String play_time, String lecture_seq, int userid);
	
	// 출석을 완료했을 경우 isAttended 컬럼 1로 update 하기
	int update_tbl_attendance_isAttended(String lecture_seq, int userid);

}
