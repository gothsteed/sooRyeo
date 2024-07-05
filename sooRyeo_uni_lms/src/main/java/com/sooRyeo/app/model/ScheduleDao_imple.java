package com.sooRyeo.app.model;

import java.util.List;

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
	public List<Schedule> showSchedule() {
		List<Schedule> Schedule = sqlSession.selectList("schedule.showSchedule");
		return Schedule;
	}

}
