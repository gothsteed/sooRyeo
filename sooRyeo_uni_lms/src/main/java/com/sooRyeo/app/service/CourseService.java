package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.dto.CourseInsertReqeustDTO;
import com.sooRyeo.app.dto.CourseUpdateRequestDto;

public interface CourseService {

	String getProfTimetable(HttpServletRequest request, ModelAndView mav);

	ResponseEntity<String> insertCourse(HttpServletRequest request, CourseInsertReqeustDTO courseInsertReqeustDTO);

	ResponseEntity<String> deleteCourse(HttpServletRequest request);

	ResponseEntity<String> getCourse(HttpServletRequest request);

	ResponseEntity<String> updateCourse(HttpServletRequest request, CourseUpdateRequestDto requestDto);

}
