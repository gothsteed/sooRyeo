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

	// 내 개인일정 추가 - 스케줄테이블 insert
	int insert_tbl_schedule(String title, String start_date, String end_date, String content, int userid);

	// 내 개인일정 삭제 - todo 테이블 delete
	int delete_tbl_todo(String schedule_seq);
	
	// 내 개인일정 삭제 - 스케줄 테이블 delete
	int delete_tbl_schedule(String schedule_seq);


	

	

	
	

}
