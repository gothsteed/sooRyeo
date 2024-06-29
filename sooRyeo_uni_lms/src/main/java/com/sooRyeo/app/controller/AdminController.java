package com.sooRyeo.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.dto.RegisterDTO;
import com.sooRyeo.app.service.AdminService;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Admin;

@Controller
@RequireLogin(type = Admin.class)
public class AdminController {
	
	@Autowired
	private AdminService adminService;

	@RequestMapping(value = "/admin/dashboard.lms", method = RequestMethod.GET)
	public String admin_Main() {

		return "admin_Main.admin";
	}
	
	@RequestMapping(value = "/admin/MemberCheck.lms", method = RequestMethod.GET)
	public String MemberCheck() {
		
		return "MemberCheck.admin";
	}
	
	@RequestMapping(value = "/admin/MemberRegister.lms", method = RequestMethod.GET)
	public String MemberRegister(HttpServletRequest request) {
		
		// select 태그에 학과를 전부 불러오는 메소드
		List<Department> departmentList = adminService.departmentList_select();
		
		request.setAttribute("departmentList", departmentList);
		
		return "MemberRegister.admin";
	}

	@PostMapping(value = "/admin/memberRegister_end.lms")
	public ModelAndView memberRegister_end(HttpServletRequest request, ModelAndView mav, RegisterDTO rdto) {
/*
		String name = request.getParameter("name"); 	// 이름
		String pwd = request.getParameter("pwd");		// 비밀번호
		String email = request.getParameter("email");	// 이메일
		String jubun = request.getParameter("jubun");	// 주민번호
		String tel = request.getParameter("a2") + request.getParameter("hp2") + request.getParameter("hp3"); // 전화번호
		String fk_department_seq = request.getParameter("department_seq");	// 학과
		String address = request.getParameter("address") + request.getParameter("detailaddress") + request.getParameter("extraaddress");	// 주소
		String register_year = request.getParameter("register_year");	// 입학년도
*/		
		// 학생 회원 등록정보를 인서트 하는 메소드
		int n = adminService.memberRegister_end(rdto);
		
		System.out.println("확인용@@@@@@@@@@@@@@@@"+rdto.getAddress());
		System.out.println(rdto.getEmail());
		System.out.println(rdto.getFk_department_seq());
		
		if(n == 1) {
			mav.addObject("message", "학생회원 등록을 성공하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/admin/MemberCheck.lms");
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "학생회원 등록을 실패하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/admin/MemberRegister.lms");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	
	
	
	
	
}
