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

	
	@Override
	public List<Schedule> showTodo(int userid) {
		List<Schedule> schedule = dao.showTodo(userid);
		return schedule;
	}


	// 일정상세보기 
	@Override
	public Map<String, String> detailSchedule(String schedule_seq, String schedule_type) {
		Map<String, String> map =  dao.detailSchedule(schedule_seq, schedule_type);
		return map;
	}


}
