package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.dto.StudentDTO;

@Repository
public class StudentDao_imple implements StudentDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	
	// 학생 로그인
	@Override
	public Student selectStudent(LoginDTO loginDTO) {
		
		Student student = sqlSession.selectOne("student.selectStudent", loginDTO);
		
		return student;
		
	} // end of public Student selectStudent

	// 내정보 보기
	@Override
	public StudentDTO getViewInfo(String login_userid) {
		
		StudentDTO member_student = sqlSession.selectOne("student.getViewInfo", login_userid);
		
		return member_student;
		
	} // end of public StudentDTO getViewInfo

	// 학과명 가져오기
	@Override
	public String select_department(Integer student_id) {
		
		String d_name = sqlSession.selectOne("student.select_department", student_id);
		
		return d_name;
	} // end of public String select_department


	// 학생 비밀번호 중복확인
	@Override
	public int pwdDuplicateCheck(Map<String, String> paraMap) {
		
		int n = sqlSession.selectOne("student.pwdDuplicateCheck", paraMap);
		
		return n;
		
	} // end of public int pwdDuplicateCheck

	
	// 학생 전화번호 중복확인
	@Override
	public int telDuplicateCheck(Map<String, String> paraMap) {
		
		int n = sqlSession.selectOne("student.telDuplicateCheck", paraMap);
		
		return n;
		
	} // end of public int telDuplicateCheck

	
	// 학생 이메일 중복확인
	@Override
	public int emailDuplicateCheck(Map<String, String> paraMap) {
		
		int n = sqlSession.selectOne("student.emailDuplicateCheck", paraMap);
		
		return n;
		
	} // end of public int emailDuplicateCheck

	
	
	

	// 계정에 파일이 있는지 확인
	@Override
	public String select_file_name(Map<String, String> paraMap) {
		
		String fileName = sqlSession.selectOne("student.select_file_name", paraMap);
		
		return fileName;
		
	} // end of public StudentDTO select_file_name


	// 계정에 기존 파일 삭제
	@Override
	public int delFilename(String student_id) {
		
		int n = sqlSession.update("student.delFilename", student_id);
		
		return n;
		
	} // end of public int delFilename


	// 학생 정보 수정
	@Override
	public int student_info_edit(Map<String, String> paraMap) {
		
		int n = sqlSession.update("student.student_info_edit", paraMap);
		
		return n;
		
	} // end of public int student_info_edit


	// 수업리스트 보여주기
	@Override
	public List<Map<String, String>> classList(int userid) {
		List<Map<String, String>> classList = sqlSession.selectList("student.classList", userid);
		return classList;
	}
	


	// 수업  - 내 강의보기
	@Override
	public List<Lecture> getlectureList(String fk_course_seq) {
		
		List<Lecture> lectureList = sqlSession.selectList("student.getlectureList", fk_course_seq);
		
		return lectureList;
		
	} // end of public List<Lecture> getlectureList

	
	// 수업 - 이번주 강의보기
	@Override
	public List<Lecture> getlectureList_week(String fk_course_seq) {
		
		List<Lecture> lectureList_week = sqlSession.selectList("student.getlectureList_week", fk_course_seq);
		
		return lectureList_week;
		
	} // end of public List<Lecture> getlectureList_week

	
	// 수업 - 내 강의 - 과제
	@Override
	public List<Map<String, String>> getassignment_List(String fk_course_seq) {
		
		List<Map<String, String>> assignment_List = sqlSession.selectList("student.getassignment_List", fk_course_seq);
		
		return assignment_List;
		
	} // end of public List<Map<String, String>> getassignment_List

	
	// 수업 - 내 강의 - 과제 - 상세내용
	@Override
	public List<Map<String, String>> getassignment_detail_List(String schedule_seq_assignment) {
		
		List<Map<String, String>> assignment_detail_List = sqlSession.selectList("student.getassignment_detail_List", schedule_seq_assignment);
		
		return assignment_detail_List;
		
	} // end of public List<Map<String, String>> getassignment_detail_List

	
	// 교수번호, 교수 이름  가져오기
	@Override
	public List<Professor> select_prof_info(String fk_course_seq) {
		List<Professor> prof_info = sqlSession.selectList("student.select_prof_info", fk_course_seq);
		return prof_info;
	}
	

	// 스케줄, 상담 테이블에 insert
	@Override
	public int insert__schedule_consult(String prof_id, String title, String content, String start_date, String end_date, int userid) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("title", title);
		paraMap.put("start_date", start_date);
		paraMap.put("end_date", end_date);
		
		sqlSession.insert("student.insert_tbl_schedule", paraMap);
		/*
			System.out.println(paraMap.get("schedule_seq"));
			String schedule_seq = (String) paraMap.get("schedule_seq");
		*/
		paraMap.put("content", content);
		paraMap.put("prof_id", prof_id);
		paraMap.put("userid",  String.valueOf(userid));
		
		int n = sqlSession.insert("student.insert_tbl_consult", paraMap);
		
		return n;
	}

	
	// 수업 - 강의 한개 제목, 내용 select
	@Override
	public Map<String, String> classPlay_One(String lecture_seq) {
		Map<String, String> classOne = sqlSession.selectOne("student.classPlay_One", lecture_seq);
		return classOne;
	}

	
	// 출석 테이블에 내가 수강한 수업이 insert 되어진 값이 있는지 알아오기 위함
	@Override
	public String select_tbl_attendance(String lecture_seq, int userid) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", String.valueOf(userid));
		paraMap.put("lecture_seq", lecture_seq);
		
		String fk_lecture_seq = sqlSession.selectOne("student.select_tbl_attendance", paraMap);
		return fk_lecture_seq;
	}

	// 처음 동영상을 재생한 경우 tbl_attendance 에 insert
	@Override
	public int insert_tbl_attendance(String play_time, String lecture_seq, int userid) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", String.valueOf(userid));
		paraMap.put("play_time", play_time);
		paraMap.put("lecture_seq", lecture_seq);
		
		int n = sqlSession.insert("student.insert_tbl_attendance", paraMap);
		return n;
	}

	
	// play_time 컬럼과 lecture_time 컬럼을 비교 
	@Override
	public int select_play_time_lecture_time(String play_time, String lecture_seq, int userid) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", String.valueOf(userid));
		paraMap.put("lecture_seq", lecture_seq);
		paraMap.put("play_time", play_time);
		
		int i = sqlSession.selectOne("student.select_play_time_lecture_time", paraMap);
		
		return i;
	}
	

	// 동영상 재생 이력이 있는 경우 tbl_attendance play_time 컬럼 update
	@Override
	public int update_tbl_attendance(String play_time, String lecture_seq, int userid) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", String.valueOf(userid));
		paraMap.put("play_time", play_time);
		paraMap.put("lecture_seq", lecture_seq);
		
		int n1 = sqlSession.update("student.update_tbl_attendance", paraMap);
		System.out.println("dao 에서 n 체크 => " +  n1);
		
		return n1;
	}

	
	// 출석을 완료했을 경우 isAttended 컬럼 1로 update 하기
	@Override
	public int update_tbl_attendance_isAttended(String lecture_seq, int userid) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", String.valueOf(userid));
		paraMap.put("lecture_seq", lecture_seq);
		
		int n2 = sqlSession.update("student.update_tbl_attendance_isAttended", paraMap);
		return n2;
	}



	
	
	
	
	
}
