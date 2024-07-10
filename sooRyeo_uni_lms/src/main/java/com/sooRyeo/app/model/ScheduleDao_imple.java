package com.sooRyeo.app.model;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Schedule;

@Repository
public class ScheduleDao_imple implements ScheduleDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;

	
	// 스케줄테이블 select
	@Override
	public List<Schedule> showAssignment(int userid) {
		List<Schedule> Schedule = sqlSession.selectList("schedule.showAssignment", userid);
		// Schedule = sqlSession.selectList("schedule.showExam");

		return Schedule;
	}


	// 내 일정 테이블 select
	@Override
	public List<Map<String, String>> showTodo(int userid) {
		List<Map<String, String>> Schedule = sqlSession.selectList("schedule.showTodo", userid);
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






}
