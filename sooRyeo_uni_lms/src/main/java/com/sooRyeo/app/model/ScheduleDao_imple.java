package com.sooRyeo.app.model;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Schedule> showAssignment(int userid) {
		List<Schedule> Schedule = sqlSession.selectList("schedule.showAssignment", userid);
		// Schedule = sqlSession.selectList("schedule.showExam");

		return Schedule;
	}


	// 내 일정 테이블 select
	@Override
	public List<Map<String, String>> showTodo(int userid) {
		List<Map<String, String>> Schedule = sqlSession.selectList("schedule.showTodo", userid);
		return Schedule;
	}

	// 일정상세보기
	@Override
	public Map<String, String> detailSchedule(String schedule_seq, String schedule_type) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("schedule_seq", schedule_seq);
		paraMap.put("schedule_type", schedule_type);
		
		Map<String, String> map =  sqlSession.selectOne("schedule.detailSchedule", paraMap);
		return map;
	}


}
