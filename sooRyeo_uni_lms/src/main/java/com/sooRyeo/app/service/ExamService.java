package com.sooRyeo.app.service;

import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Exam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ExamService {
    ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

    // 시험을 select 하는 메소드
	Exam getExam();
}
