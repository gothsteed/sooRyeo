package com.sooRyeo.app.service;

import java.util.List;

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
	public List<Schedule> showSchedule() {
		List<Schedule> schedule = dao.showSchedule();
		return schedule;
	}

}
