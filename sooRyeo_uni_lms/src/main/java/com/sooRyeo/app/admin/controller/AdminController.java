package com.sooRyeo.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminController {

	@RequestMapping(value = "/admin/admin_Main.lms", method = RequestMethod.GET)
	public String AdminController() {

		return "admin_Main.admin";
	}
	
}
