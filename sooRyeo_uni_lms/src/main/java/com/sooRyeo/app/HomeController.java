package com.sooRyeo.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.service.LoginService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private LoginService loginService;
	
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@ResponseBody
	@PostMapping(value="/student/login.lms")
	public String home(HttpServletRequest resquest,  LoginDTO loginDTO) {
		System.out.println("id : " + loginDTO.getId());
		System.out.println("pwd : " + loginDTO.getPassword());
		
		JSONObject json = loginService.studentLogin(resquest, loginDTO);
		
		
		return json.toString();
	}
	
	

	@GetMapping("/logout.lms")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {// 로그아웃
		
		mav = loginService.logout(mav, request);
		
		return mav;
		
	}
	
	
	@ResponseBody
	@PostMapping(value="/professor/login.lms")
	public String professorLogin(HttpServletRequest resquest,  LoginDTO loginDTO) {// 교수 로그인
		
		System.out.println("id : " + loginDTO.getId());
		System.out.println("pwd : " + loginDTO.getPassword());
		
		JSONObject json = loginService.professorLogin(resquest, loginDTO);
			
		return json.toString();
		
	}
	
	@ResponseBody
	@PostMapping(value="/admin/login.lms")
	public String adminLogin(HttpServletRequest resquest,  LoginDTO loginDTO) {// 교수 로그인
		
		System.out.println("id : " + loginDTO.getId());
		System.out.println("pwd : " + loginDTO.getPassword());
		
		JSONObject json = loginService.adminLogin(resquest, loginDTO);
			
		return json.toString();
		
	}
	
	
	
	
	
}
