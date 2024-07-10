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
import org.springframework.web.bind.annotation.PostMapping;
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
	public ModelAndView showSchedule(ModelAndView mav, HttpServletRequest request) {
		
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
		List<Map<String, String>> todo_list = service.showTodo(userid);
		
		JSONArray jsonArr = new JSONArray();
		for(Schedule schedule : assignment_list) {
			
			JSONObject jsonobj  = new JSONObject();
			jsonobj.put("schedule_seq", schedule.getSchedule_seq());
			jsonobj.put("schedule_type", schedule.getSchedule_type());
			jsonobj.put("course_seq", schedule.getSchedule_type());
			jsonobj.put("title", schedule.getTitle());
			jsonobj.put("start_date", schedule.getStart_date());
			jsonobj.put("end_date", schedule.getEnd_date());
			
			// System.out.println(schedule.getStart_date());
			
			jsonArr.put(jsonobj);
		}
		
		for(Map<String, String> schedule : todo_list) {
			JSONObject jsonobj  = new JSONObject();
			jsonobj.put("schedule_seq", schedule.get("schedule_seq"));
			jsonobj.put("schedule_type", schedule.get("schedule_type"));
			jsonobj.put("title", schedule.get("title"));
			jsonobj.put("content", schedule.get("content"));
			jsonobj.put("start_date", schedule.get("start_date"));
			jsonobj.put("end_date", schedule.get("end_date"));
			
			jsonArr.put(jsonobj);
		}
		
		return jsonArr.toString();
	}

	
	// 내 개인일정 update 하기
	@ResponseBody
	@PostMapping("/schedule/updateSchedule.lms")
	public String updateSchedule(HttpServletRequest request) {
		
		String schedule_seq = request.getParameter("schedule_seq");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		
		int n1 = service.update_tbl_schedule(schedule_seq, title, start_date, end_date);
		int n2 = service.update_tbl_todo(schedule_seq, content);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n1*n2);
		
		return jsonobj.toString();
	}
	
	
	@ResponseBody
	@PostMapping("/schedule/insertSchedule.lms")
	public String insertSchedule(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		String title =request.getParameter("title");
		String content = request.getParameter("content");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		
		int n = service.insert_tbl_schedule(title, start_date, end_date, content, userid);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n);
		
		return jsonobj.toString();
	}


	
}
