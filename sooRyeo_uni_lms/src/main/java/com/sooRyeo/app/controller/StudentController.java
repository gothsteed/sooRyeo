package com.sooRyeo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
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
	
	
	@GetMapping(value = "/student/idfind.lms", produces="text/plain;charset=UTF-8")
	public String idFind() {
		
		return "idFind";
		// /WEB-INF/views/idFind.jsp
	}
	
	@GetMapping(value = "/student/pwdfind.lms", produces="text/plain;charset=UTF-8")
	public String pwdFind() {
		
		return "pwdFind";
		// /WEB-INF/views/pwdFind.jsp
	}
	
	
	
	@RequestMapping(value="/student/myInfo.lms", method = RequestMethod.GET)
	public String myInfo() {
		
		return "myInfo.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
}
