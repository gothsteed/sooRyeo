package com.sooRyeo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ProfessorController {
	

	@RequestMapping(value = "/professor/dashboard.lms", method = RequestMethod.GET)
	public String professor() {

		return "professor_dashboard.professor";
	}
	
	@RequestMapping(value = "/professor/request.lms", method = RequestMethod.GET)
	public String professor_request() {

		return "professor_request.professor";
	}
	
}
