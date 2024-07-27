package com.sooRyeo.app.model;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.dto.ConsultApprovalDto;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Consult;

@Repository
public class ScheduleDao_imple implements ScheduleDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;

	
	// 스케줄테이블 select
	@Override
	public List<Map<String, String>> showAssignment(int userid) {
		List<Map<String, String>> Schedule = sqlSession.selectList("schedule.showAssignment", userid);
		// Schedule = sqlSession.selectList("schedule.showExam");

		return Schedule;
	}


	// 내 일정 테이블 select
	@Override
	public List<Map<String, String>> showTodo(int userid) {
		List<Map<String, String>> Schedule = sqlSession.selectList("schedule.showTodo", userid);
		return Schedule;
	}
	
	
	// 상담 테이블 select
	@Override
	public List<Map<String, String>> showConsult(int userid) {
		List<Map<String, String>> Schedule = sqlSession.selectList("schedule.showConsult", userid);
		return Schedule;
	}


	// 내 개인일정 update - 스케줄테이블 update
	@Override
	public int update_tbl_schedule(String schedule_seq, String title, String start_date, String end_date) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("schedule_seq", schedule_seq);
		paraMap.put("title", title);
		paraMap.put("start_date", start_date);
		paraMap.put("end_date", end_date);
		
		int n1= sqlSession.update("schedule.update_tbl_schedule", paraMap);
		return n1;
	}


	// 내 개인일정 update - todo테이블 update
	@Override
	public int update_tbl_todo(String schedule_seq, String content) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("schedule_seq", schedule_seq);
		paraMap.put("content", content);
		
		int n2 = sqlSession.update("schedule.update_tbl_todo", paraMap);
		return n2;
	}


	// 내 개인일정 insert - 스케줄테이블 insert
	@Override
	public int insert_tbl_schedule(String title, String start_date, String end_date, String content, int userid) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("title", title);
		paraMap.put("start_date", start_date);
		paraMap.put("end_date", end_date);
		
		sqlSession.insert("schedule.insert_tbl_schedule", paraMap);
		
		System.out.println(paraMap.get("schedule_seq"));
		String schedule_seq = (String) paraMap.get("schedule_seq");
		
		paraMap.put("schedule_seq", schedule_seq);
		paraMap.put("content", content);
		paraMap.put("userid", String.valueOf(userid));
		
		int n = sqlSession.insert("schedule.insert_tbl_todo", paraMap);
		
		return n;
	}

	// 내 개인일정 삭제 - todo 테이블 delete
	@Override
	public int delete_tbl_todo(String schedule_seq) {
		int n1 = sqlSession.delete("schedule.delete_tbl_todo", schedule_seq);
		return n1;
	}
	
	// 내 개인일정 삭제 - 스케줄 테이블 delete
	@Override
	public int delete_tbl_schedule(String schedule_seq) {
		int n2 = sqlSession.delete("schedule.delete_tbl_schedule", schedule_seq);
		return n2;
	}


	@Override
	public List<Consult> getUnconfirmedConsultList(int currentPage, int sizePerPage, int professor_id) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("professor_id", professor_id);
		
		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		map.put("startRno", startRno);
		map.put("endRno", endRno);
		
		return sqlSession.selectList("schedule.getUnconfirmedConsultList", map);
	}


	@Override
	public int getUnconfirmedConsultCount(int professor_id) {
		
		return sqlSession.selectOne("schedule.getUnconfirmedConsultCount", professor_id);
	}

	@Override
	public Consult getConsult(int schedule_seq) {
		return  sqlSession.selectOne("schedule.getConsult", schedule_seq);
	}

	@Override
	public int updateConsultApproveStatus(ConsultApprovalDto consultApprovalDto) {
		Map<String, Object> map = new HashMap<>();
		map.put("schedule_seq", consultApprovalDto.getSchedule_seq());
		map.put("approved", consultApprovalDto.getIsApproved()?1:0);

		return sqlSession.update("schedule.updateConsultApproveStatus", map);
	}

	@Override
	public int deleteUnapprovedConsult(ConsultApprovalDto consultApprovalDto) {
		int schedule_seq = consultApprovalDto.getSchedule_seq();
		return sqlSession.delete("schedule.deleteUnapprovedConsult", schedule_seq);
	}

	@Override
	public List<Consult> getConfirmedConsultList(int professor_id, int currentPage, int sizePerPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("professor_id", professor_id);

		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		map.put("startRno", startRno);
		map.put("endRno", endRno);

		return sqlSession.selectList("schedule.getConfirmedConsultList", map);
	}

	@Override
	public int getConfirmedConsultCount(int professor_id) {
		return sqlSession.selectOne("schedule.getConfirmedConsultCount", professor_id);
	}

	@Override
	public void updateToComplete(Integer scheduleSeq) {
		sqlSession.update("schedule.updateToComplete", scheduleSeq);
	}

	@Override
	public List<Consult> getStudentConfirmedConsultList(int studentId, int currentPage, int sizePerPage) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("studentId", studentId);

		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		map.put("startRno", startRno);
		map.put("endRno", endRno);
		return sqlSession.selectList("schedule.getStudentConfirmedConsultList", map);
	}

	@Override
	public int getStudentConfirmedConsultCount(int studentId) {
		return sqlSession.selectOne("schedule.getStudentConfirmedConsultCount", studentId);
	}

	@Override
	public List<Exam> getExamList(int currentPage, int sizePerPage, int courseSeq) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("courseSeq", courseSeq);

		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		map.put("startRno", startRno);
		map.put("endRno", endRno);

		return sqlSession.selectList("schedule.getExamList", map);
	}

	@Override
	public int getExamCount(int courseSeq) {
		return sqlSession.selectOne("schedule.getExamCount", courseSeq);
	}

	@Override
	public Exam getExamSchedule(int schedule_seq) {
		return sqlSession.selectOne("schedule.getExamSchedule", schedule_seq);

	}


	@Override
	public Exam getExam(int schedule_seq) {
		
		Exam examView = sqlSession.selectOne("schedule.getExam", schedule_seq);
		
		return examView;
	}


}
