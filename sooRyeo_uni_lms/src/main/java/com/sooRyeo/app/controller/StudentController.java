package com.sooRyeo.app.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.StudentService;

@Controller
@RequireLogin(type = Student.class)
public class StudentController {
	
	@Autowired
	private StudentService service;

	@RequestMapping(value = "/student/dashboard.lms", method = RequestMethod.GET)
	public String student() {

		return "student_Main.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	@RequestMapping(value = "/student/lectureList.lms", method = RequestMethod.GET)
	public String lectureList() {
		
		return "lectureList.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
	@RequestMapping(value="/student/myInfo.lms", method = RequestMethod.GET)
	public String myInfo() {
		
		return "myInfo.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	@GetMapping(value="/student/classList.lms")
	public String classList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Student loginuser = (Student)session.getAttribute("loginuser");
		
		int userid = loginuser.getStudent_id();
		
		List<Map<String, String>> mapList = service.classList(userid);
		
		request.setAttribute("mapList", mapList);

		return "classList.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
}
