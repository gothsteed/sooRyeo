package com.sooRyeo.app.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sooRyeo.app.dto.ConsultApprovalDto;
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
	private ScheduleService service;
	
	
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
		
		List<Map<String, String>> assignment_list = service.showAssignment(userid);
		List<Map<String, String>> todo_list = service.showTodo(userid);
		List<Map<String, String>> consult_list = service.showConsult(userid);
		List<Map<String, String>> exam_list = service.showExam(userid);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, String> schedule : assignment_list) {
			JSONObject jsonobj  = new JSONObject();
			jsonobj.put("fk_student_id", schedule.get("fk_student_id"));
			jsonobj.put("course_seq", schedule.get("course_seq"));
			jsonobj.put("schedule_seq", schedule.get("schedule_seq"));
			jsonobj.put("title", schedule.get("title"));
			jsonobj.put("schedule_type", schedule.get("schedule_type"));
			jsonobj.put("start_date", schedule.get("start_date"));
			jsonobj.put("end_date", schedule.get("end_date"));
			
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
		
		
		for(Map<String, String> schedule : consult_list) {
			JSONObject jsonobj  = new JSONObject();
			jsonobj.put("schedule_seq", schedule.get("schedule_seq"));
			jsonobj.put("schedule_type", schedule.get("schedule_type"));
			jsonobj.put("title", schedule.get("title"));
			jsonobj.put("content", schedule.get("content"));
			jsonobj.put("start_date", schedule.get("start_date"));
			jsonobj.put("end_date", schedule.get("end_date"));
			jsonobj.put("professor_name", schedule.get("name"));
			
			jsonArr.put(jsonobj);
		}
		
		
		for(Map<String, String> schedule : exam_list) {
			JSONObject jsonobj  = new JSONObject();
			jsonobj.put("fk_student_id", schedule.get("fk_student_id"));
			jsonobj.put("course_seq", schedule.get("course_seq"));
			jsonobj.put("schedule_seq", schedule.get("schedule_seq"));
			jsonobj.put("title", schedule.get("title"));
			jsonobj.put("schedule_type", schedule.get("schedule_type"));
			jsonobj.put("start_date", schedule.get("start_date"));
			jsonobj.put("end_date", schedule.get("end_date"));
			
			jsonArr.put(jsonobj);
			
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
		
		int n1 = service.update_tbl_schedule(schedule_seq, title, start_date, end_date);
		int n2 = service.update_tbl_todo(schedule_seq, content);
		
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
		
		int n = service.insert_tbl_schedule(title, start_date, end_date, content, userid);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n);
		
		return jsonobj.toString();
	}
	
	
	@RequireLogin(type = {Student.class})
	@ResponseBody
	@PostMapping("/schedule/deleteSchedule.lms")
	public String deleteSchedule(HttpServletRequest request) {
		
		String schedule_seq =request.getParameter("schedule_seq");
		
		int n1 = service.delete_tbl_todo(schedule_seq);
		int n2 = service.delete_tbl_schedule(schedule_seq);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n1*n2);
		
		return jsonobj.toString();
	}

	@RequireLogin(type = {Professor.class})
	@GetMapping("/professor/approveConsult.lms")
	public ModelAndView approveConsultPage(ModelAndView mav, HttpServletRequest request) {
		return service.makeApproveConsultPage(request, mav);
	}

	@RequireLogin(type = {Professor.class})
	@PostMapping("/schedule/detailREST.lms")
	public ResponseEntity<String> getScheduleDetail(HttpServletRequest request) {

		return  service.getConsultDetail(request);
	}


	@RequireLogin(type = {Professor.class})
	@PostMapping(value="/schedule/approveREST.lms", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> updateConsultApproveStatus(HttpServletRequest request, @RequestBody ConsultApprovalDto consultApprovalDto) {
		return service.updateConsultApproveStatus(request, consultApprovalDto);
	}
	
	
}
