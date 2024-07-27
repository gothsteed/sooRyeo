package com.sooRyeo.app.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.service.ExamService;

@Controller
public class ExamController {

    @Autowired
    private ExamService examService;


	@RequireLogin(type = {Student.class})
	@PostMapping("/exam/test.lms")
	public ModelAndView test(ModelAndView mav, HttpServletRequest request) {
		
		String schedule_seq = request.getParameter("schedule_seq");
		
		Exam examView = examService.getExam(schedule_seq);
		
		mav.addObject("schedule_seq", schedule_seq);
		mav.addObject("examView", examView);
		mav.setViewName("test");
		
		return mav;
		
	}
	
	@RequireLogin(type = {Student.class})
	@PostMapping("/exam/SelectAnswer.lms")
	public ModelAndView selectAnswer(ModelAndView mav, HttpServletRequest request) {
		
		String schedule_seq = request.getParameter("schedule_seq");
		
		int selCount = Integer.parseInt(request.getParameter("selCount"));
		
		List<String> inputAnswers = new ArrayList<>();
		
		for(int i=1; i<selCount+1; i++) {
			String selectAnswer = request.getParameter(String.valueOf(i));
			
			if (selectAnswer != null) {
				inputAnswers.add(selectAnswer);
	        }
		}
		
		examService.insertMongoStudentExamAnswer(inputAnswers, schedule_seq);
		
		/*
		if(n == 1) {
			mav.addObject("message", "회원 등록을 성공하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/admin/MemberCheck.lms");
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "회원 등록을 실패하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/admin/MemberRegister.lms");
			mav.setViewName("msg");
		}
		*/
		return mav;
		
	}


	@RequireLogin(type = {Professor.class})
	@GetMapping(value = "/professor/exam.lms")
	public ModelAndView professorExam(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		return examService.getExamPage(mav, request, response);
	}

	@RequireLogin(type = {Professor.class})
	@GetMapping("/professor/exam/result.lms")
	public ModelAndView getExamResultPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException {
		//todo : error handler 추가하기
		int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq") == null? "-1" : request.getParameter("schedule_seq"));
		mav.addObject("schedule_seq", schedule_seq);
		mav.setViewName("exam/examResult");
		return mav;
	}

	@RequireLogin(type = {Professor.class})
	@GetMapping("/professor/exam/resultREST.lms")
	public ResponseEntity<String> getExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		return examService.getExamResultData(mav, request, response);
	}

	@RequireLogin(type = {Student.class})
	@GetMapping(value = "/student/exam.lms")
	public ModelAndView studentExam(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException {
		return examService.getExamPage(mav, request, response);
	}


	@RequireLogin(type = {Student.class})
	@GetMapping("/student/exam/result.lms")
	public ModelAndView getStudentExamResult(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException {
		//todo : error handler 추가하기
		int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq") == null? "-1" : request.getParameter("schedule_seq"));
		mav.addObject("schedule_seq", schedule_seq);
		mav.setViewName("exam/examResult");
		return mav;
	}

	@RequireLogin(type = {Student.class})
	@GetMapping("/student/exam/resultREST.lms")
	public ResponseEntity<String> getStudentExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		return examService.getStudentExamResultData(mav, request, response);
	}


	
	
}
