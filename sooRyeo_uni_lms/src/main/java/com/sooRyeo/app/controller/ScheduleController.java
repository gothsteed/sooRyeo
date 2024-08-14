package com.sooRyeo.app.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.ScheduleInterface;
import com.sooRyeo.app.dto.ConsultApprovalDto;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.ScheduleService;


@Controller

public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
    @Autowired
    private JsonBuilder jsonBuilder;


	// 캘린더 띄우기
	@RequireLogin(type = {Student.class})
	@GetMapping("/student/scheduleManagement.lms")
	public ModelAndView showSchedule(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("schedule/scheduleManagement");
		return mav;
	}
	
	
	@RequireLogin(type = {Student.class})
	@ResponseBody
	@GetMapping("/api/schedules")
	public String showSchedule(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();

		List<ScheduleInterface> scheduleList = scheduleService.getSchedules(userid);
		
		JSONArray jsonArr = new JSONArray();

		for(ScheduleInterface schedule : scheduleList) {
			jsonArr.put(schedule.toJson());
		}
		
		return jsonArr.toString();
	}

	
	// 내 개인일정 update 하기
	@RequireLogin(type = {Student.class})
	@ResponseBody
	@PostMapping("/schedule/updateSchedule.lms")
	public String updateSchedule(HttpServletRequest request) {
		
		String schedule_seq = request.getParameter("schedule_seq");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		
		int n1 = scheduleService.update_tbl_schedule(schedule_seq, title, start_date, end_date);
		int n2 = scheduleService.update_tbl_todo(schedule_seq, content);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n1*n2);
		
		return jsonobj.toString();
	}
	
	
	@RequireLogin(type = {Student.class})
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
		
		int n = scheduleService.insert_tbl_schedule(title, start_date, end_date, content, userid);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n);
		
		return jsonobj.toString();
	}
	
	
	@RequireLogin(type = {Student.class})
	@ResponseBody
	@PostMapping("/schedule/deleteSchedule.lms")
	public String deleteSchedule(HttpServletRequest request) {
		
		String schedule_seq =request.getParameter("schedule_seq");
		
		int n1 = scheduleService.delete_tbl_todo(schedule_seq);
		int n2 = scheduleService.delete_tbl_schedule(schedule_seq);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n1*n2);
		
		return jsonobj.toString();
	}

	@RequireLogin(type = {Professor.class})
	@GetMapping("/professor/approveConsult.lms")
	public ModelAndView approveConsultPage(ModelAndView mav, HttpServletRequest request) {
		return scheduleService.makeApproveConsultPage(request, mav);
	}

	@RequireLogin(type = {Professor.class})
	@PostMapping("/schedule/detailREST.lms")
	public ResponseEntity<String> getScheduleDetail(HttpServletRequest request) {

		return  scheduleService.getConsultDetail(request);
	}


	@RequireLogin(type = {Professor.class})
	@PostMapping(value="/schedule/approveREST.lms", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> updateConsultApproveStatus(HttpServletRequest request, @RequestBody ConsultApprovalDto consultApprovalDto) {
		return scheduleService.updateConsultApproveStatus(request, consultApprovalDto);
	}
	
	
}
