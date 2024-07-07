package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Schedule;


public interface ScheduleService {

	// 과제테이블 select
	List<Schedule> showAssignment(int userid);

	// 일정테이블 select 
	List<Schedule> showTodo(int userid);
	
	// 일정상세보기 
	Map<String, String> detailSchedule(String schedule_seq);

}
