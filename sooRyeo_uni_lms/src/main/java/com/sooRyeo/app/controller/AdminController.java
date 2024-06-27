package com.sooRyeo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sooRyeo.app.aop.MemberType;
import com.sooRyeo.app.aop.RequireLogin;

@Controller
@RequireLogin(type = MemberType.ADMIN)
public class AdminController {

	@RequestMapping(value = "/admin/admin_Main.lms", method = RequestMethod.GET)
	public String admin_Main() {

		return "admin_Main.admin";
	}
	
	@RequestMapping(value = "/admin/MemberCheck.lms", method = RequestMethod.GET)
	public String MemberCheck() {
		
		return "MemberCheck.admin";
	}
	
	@RequestMapping(value = "/admin/MemberRegister.lms", method = RequestMethod.GET)
	public String MemberRegister() {
		
		return "MemberRegister.admin";
	}
	
}
