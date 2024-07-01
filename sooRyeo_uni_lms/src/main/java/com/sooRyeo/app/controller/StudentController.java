package com.sooRyeo.app.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.StudentDTO;
import com.sooRyeo.app.service.StudentService;

@Controller
@RequireLogin(type = Student.class)
public class StudentController {

	@Autowired
	private StudentService studentservice;
	
	
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
	
	
	
	// 내정보 보기
	@RequestMapping(value="/student/myInfo.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView myInfo(ModelAndView mav, HttpServletRequest request) {
		
		StudentDTO member_student = studentservice.getViewInfo(request);
		
		mav.addObject("member_student", member_student);
		mav.setViewName("myInfo.student");
		// /WEB-INF/views/student/{1}.jsp
		
		return mav;
		
	}
	
	
	
}
