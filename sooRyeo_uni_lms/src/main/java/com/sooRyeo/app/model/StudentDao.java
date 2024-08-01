package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Assignment;
import com.sooRyeo.app.domain.AssignmentSubmit;
import com.sooRyeo.app.domain.Attendance;
import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.domain.StudentTimeTable;
import com.sooRyeo.app.domain.TodayLecture;
import com.sooRyeo.app.dto.AssignmentSubmitDTO;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.StudentDTO;

public interface StudentDao {

	Student selectStudent(LoginDTO loginDTO);

	// 수업리스트 보여주기
	StudentTimeTable classList(int userid);
	
	// 내정보 보기
	Student getStudentById(int studentId);

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
	
	// ajax학생 수강과목 가져와서 학점 계산하기(chart) ///////////////////////////////
	// 자학과전공필수 학점 
	Map<String, String> student_myRequiredCredit(int student_id, int department_seq);
	// 타학과전공필수 학점 
	Map<String, String> student_yourRequiredCredit(int student_id, int department_seq);
	// 총 전공선택 학점
	Map<String, String> student_UnrequiredCredit(int student_id);
	// 총 교양 학점
	Map<String, String> student_LiberalCredit(int student_id);
	//////////////////////////////////////////////////////////////////////
	
	// 과제 제출 내용보기
	Map<String, Object> getreadComment(String fk_schedule_seq_assignment, int userid);

	// 파일첨부가 되어진 과제에서 서버에 업로드되어진 파일명 조회
	AssignmentSubmitDTO getCommentOne(String assignment_submit_seq);

	// 출석 현황 조회
	List<Map<String, Object>> attendanceList(int userid, String name);

	// 수업명 가져오기
	List<Curriculum> lectureList();
	
	// 이수한 학점이 몇점인지 알아오는 메소드
	int credit_point(int student_id);

	// 학적변경테이블(tbl_student_status_change)에 졸업신청을 insert 하는 메소드 
	int application_status_change(int student_id, int status_num);

	// 현재 학적변경을 신청한 상태인지 알아오는 메소드
	String getApplication_status(int student_id);

	// 수업 - 강의 한개 제목, 내용 select
	Map<String, String> classPlay_One(String lecture_seq);

	// 출석 테이블에 내가 수강한 수업이 insert 되어진 값이 있는지 알아오기 위함
	String select_tbl_attendance(String lecture_seq, int userid);
	// 오늘의 수업만을 불러오는 메소드
	List<TodayLecture> getToday_lec(int student_id);

	// 학사공지사항 리스트를 select 해오는 메소드
	Pager<Announcement> getAnnouncement(int currentPage);

	// 하이차트 - 학생이 듣고있는 수업명 가져오는 메소드
	List<Curriculum> Curriculum_nameList(int student_id);

	// 학생 대쉬보드 - 하이차트 - 수강중인 과목 출석률 
	Map<String, Object> myAttendance_byCategoryJSON(int student_id, String name);

	// 학생 - 성적 취득현황
	List<Map<String, Object>> Acquisition_status(int student_id);

	// 학생 - 성적 취득현황JSON
	List<Map<String, Object>> Acquisition_status_JSON(String semester, int student_id);


	
	// 처음 동영상을 재생한 경우 tbl_attendance 에 insert
	int insert_tbl_attendance(String play_time, String lecture_seq, int userid);

	// 동영상 재생이력이 있는 경우 tbl_attendance play_time 컬럼 update
	int update_tbl_attendance(String play_time, String lecture_seq, int userid);

	// play_time 컬럼과 lecture_time 컬럼을 비교 
	int select_play_time_lecture_time(String play_time, String lecture_seq, int userid);
	
	// 출석을 완료했을 경우 isAttended 컬럼 1로 update 하기
	int update_tbl_attendance_isAttended(String lecture_seq, int userid);

	// 학기 별 개강과목JSON
	StudentTimeTable classListJSON(String semester, int student_id);

	

}
