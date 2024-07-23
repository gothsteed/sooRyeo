package com.sooRyeo.app.service;

import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ExamService {
    ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

    // 시험 출제 시 몽고db에 insert
	int insert_examAnswer(String string, String string2, String string3);
}
