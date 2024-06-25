package com.sooRyeo.app.professor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ProfessorController {
	
	@RequestMapping(value = "/professor.lms", method = RequestMethod.GET)
	public String professor() {

		return "professor_dashboard.professor";
	}
	
}
