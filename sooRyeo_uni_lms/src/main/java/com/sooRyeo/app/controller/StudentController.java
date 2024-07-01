package com.sooRyeo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;

@Controller
@RequireLogin(type = Student.class)
public class StudentController {

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
	public String classList() {
		
		return "classList.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
}
