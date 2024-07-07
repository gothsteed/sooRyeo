package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Schedule;

public interface ScheduleDao {
	
	// 스케줄테이블 select
	List<Schedule> showAssignment(int userid);
	
	// 내 일정 테이블 select
	List<Schedule> showTodo(int userid);
	
	// 일정상세보기
	Map<String, String> detailSchedule(String schedule_seq, String schedule_type);

}
