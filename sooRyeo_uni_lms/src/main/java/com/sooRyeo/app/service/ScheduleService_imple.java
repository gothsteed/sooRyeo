package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.domain.Schedule;
import com.sooRyeo.app.model.ScheduleDao;

@Service
public class ScheduleService_imple implements ScheduleService {

	
	@Autowired
	private ScheduleDao dao;
	
	// 스케줄테이블 select
	@Override
	public List<Schedule> showAssignment(int userid) {
		List<Schedule> schedule = dao.showAssignment(userid);
		return schedule;
	}

	
	// 내개인일정테이블 select
	@Override
	public List<Map<String, String>> showTodo(int userid) {
		List<Map<String, String>> schedule = dao.showTodo(userid);
		return schedule;
	}


	// 내 개인일정 update - 스케줄테이블 update
	@Override
	public int update_tbl_schedule(String schedule_seq, String title, String start_date, String end_date) {
		
		int n1 = dao.update_tbl_schedule(schedule_seq, title, start_date, end_date);
		return n1;
	}


	// 내 개인일정 수정 - todo테이블 update
	@Override
	public int update_tbl_todo(String schedule_seq, String content) {
		int n2 = dao.update_tbl_todo(schedule_seq, content);
		return n2;
	}


	// 내 개인일정 insert - 스케줄테이블 insert
	@Override
	public int insert_tbl_schedule(String title, String start_date, String end_date, String content, int userid) {
		
		int n = dao.insert_tbl_schedule(title, start_date, end_date, content, userid);
		return n;
	}





	





}
