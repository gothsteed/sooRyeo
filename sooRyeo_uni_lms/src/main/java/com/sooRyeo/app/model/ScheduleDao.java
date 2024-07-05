package com.sooRyeo.app.model;

import java.util.List;

import com.sooRyeo.app.domain.Schedule;

public interface ScheduleDao {
	
	// 스케줄테이블 select
	List<Schedule> showSchedule();

}
