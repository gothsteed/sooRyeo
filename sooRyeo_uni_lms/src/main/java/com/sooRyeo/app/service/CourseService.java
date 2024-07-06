package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface CourseService {

	String getProfTimetable(HttpServletRequest request, ModelAndView mav);

}
