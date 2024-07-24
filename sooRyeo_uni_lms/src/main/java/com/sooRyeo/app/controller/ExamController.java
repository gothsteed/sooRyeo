package com.sooRyeo.app.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.ExamService;

@Controller
@RequireLogin(type = {Admin.class, Student.class, Professor.class})
public class ExamController {

    @Autowired
    private ExamService examService;
    
	@GetMapping("/exam/test.lms")
	public ModelAndView test(ModelAndView mav, HttpServletRequest request) {
		
		Exam examView = examService.getExam();
		
		mav.addObject("examView", examView);
		mav.setViewName("test");
		
		return mav;
		
	}
}
