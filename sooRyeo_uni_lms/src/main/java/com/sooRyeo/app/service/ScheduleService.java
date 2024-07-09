package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Schedule;


public interface ScheduleService {

	// 과제테이블 select
	List<Schedule> showAssignment(int userid);

	// 일정테이블 select 
	List<Map<String, String>> showTodo(int userid);

	// 내 개인일정 수정 - 스케줄테이블 update
	int update_tbl_schedule(String schedule_seq, String title, String start_date, String end_date);

	// 내 개인일정 수정 - todo테이블 update
	int update_tbl_todo(String schedule_seq, String content);

	
	

}
