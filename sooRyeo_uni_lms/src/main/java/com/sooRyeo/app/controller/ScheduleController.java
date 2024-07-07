package com.sooRyeo.app.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Schedule;
import com.sooRyeo.app.domain.Student;
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
	public String showSchedule(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Student loginuser = (Student)session.getAttribute("loginuser");
		
		int userid = loginuser.getStudent_id();
		
		List<Schedule> assignment_list = service.showAssignment(userid);
		List<Schedule> todo_list = service.showTodo(userid);
		
		JSONArray jsonArr = new JSONArray();
		for(Schedule schedule : assignment_list) {
			JSONObject jsonobj  = new JSONObject();
			jsonobj.put("schedule_seq", schedule.getSchedule_seq());
			jsonobj.put("schedule_type", schedule.getSchedule_type());
			jsonobj.put("title", schedule.getTitle());
			jsonobj.put("start_date", schedule.getStart_date());
			jsonobj.put("end_date", schedule.getEnd_date());
			
			jsonArr.put(jsonobj);
		}
		
		for(Schedule schedule : todo_list) {
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
	
	
	

	// === 일정상세보기 ===
	@RequestMapping(value="/schedule/detailSchedule.lms")
	public ModelAndView detailSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String schedule_seq = request.getParameter("schedule_seq");
		
		try {
			Integer.parseInt(schedule_seq);
			Map<String,String> map = service.detailSchedule(schedule_seq);
			mav.addObject("map", map);
			mav.setViewName("schedule/detailSchedule.student");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/scheduleManagement.lms");
		}
		
		return mav;
	}



	
	
	
	
	
	
}
