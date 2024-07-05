package com.sooRyeo.app.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Schedule;
import com.sooRyeo.app.service.ScheduleService;


@Controller
public class ScheduleController {
	
	@Autowired
	private ScheduleService service;
	
	
	
	@GetMapping("/student/scheduleManagement.lms")
	public ModelAndView showSchedule(ModelAndView mav) {
		
		mav.setViewName("schedule/scheduleManagement.student");
		
		return mav;
	}
	
	
	
	@ResponseBody
	@GetMapping("/api/schedules")
	public String showSchedule() {
		
		List<Schedule> list = service.showSchedule();
		
		System.out.println("~~~ 확인용  schedule: "+ list);
		
		JSONArray jsonArr = new JSONArray();
		for(Schedule schedule : list) {
			JSONObject jsonobj  = new JSONObject();
			jsonobj.put("schedule_seq", schedule.getSchedule_seq());
			jsonobj.put("schedule_type", schedule.getSchedule_type());
			jsonobj.put("title", schedule.getTitle());
			jsonobj.put("start_date", schedule.getStart_date());
			jsonobj.put("end_date", schedule.getEnd_date());
			
			jsonArr.put(jsonobj);
		}
		
		return jsonArr.toString();
	}


	
	
	
	
	
	
}
