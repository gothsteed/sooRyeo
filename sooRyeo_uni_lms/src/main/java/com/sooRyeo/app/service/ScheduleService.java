package com.sooRyeo.app.service;

import java.util.List;

import com.sooRyeo.app.domain.Schedule;


public interface ScheduleService {

	// 스케줄테이블 select
	List<Schedule> showSchedule();

}
