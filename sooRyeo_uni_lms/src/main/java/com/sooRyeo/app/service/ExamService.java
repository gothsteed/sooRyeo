package com.sooRyeo.app.service;

import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ExamService {
    ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);
}
