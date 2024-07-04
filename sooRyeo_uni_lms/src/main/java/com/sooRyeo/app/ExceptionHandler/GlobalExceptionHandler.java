package com.sooRyeo.app.ExceptionHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(LoginException.class) 
	public ModelAndView handleLoginException(LoginException exception) {
		ModelAndView modelView = new ModelAndView();
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		
		modelView.addObject("message", exception.getMessage());
		modelView.addObject("loc", request.getContextPath());
		modelView.setViewName("msg");
		
		return modelView;
		
	}
	
	
	@ExceptionHandler(AuthException.class) 
	public ModelAndView handleAuthException(AuthException exception) {
		ModelAndView modelView = new ModelAndView();
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		
		
		HttpSession session = request.getSession();
		
		Object loginuser = session.getAttribute("loginuser");
		
		String loc = request.getContextPath();
		

		if(loginuser instanceof Student) {
			loc += "/student/dashboard.lms";
		}
		else if (loginuser instanceof Professor) {
			
			loc += "/professor/dashboard.lms";
		}
		else {
			
			loc += "/admin/dashboard.lms";
		}
		
		modelView.addObject("message", exception.getMessage());
		modelView.addObject("loc", loc);
		modelView.setViewName("msg");
		
		return modelView;
	}
	
	
	@ExceptionHandler(AlreadyLoggedInException.class) 
	public ModelAndView handleAlreadyLoggedInException(AlreadyLoggedInException exception) {
		ModelAndView modelView = new ModelAndView();
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		
		
		HttpSession session = request.getSession();
		
		Object loginuser = session.getAttribute("loginuser");
		
		String loc = request.getContextPath();
		

		if(loginuser instanceof Student) {
			loc += "/student/dashboard.lms";
		}
		else if (loginuser instanceof Professor) {
			
			loc += "/professor/dashboard.lms";
		}
		else {
			
			loc += "/admin/dashboard.lms";
		}
		
		modelView.addObject("message", exception.getMessage());
		modelView.addObject("loc", loc);
		modelView.setViewName("msg");
		
		return modelView;
	}
	
	/*
	@ResponseBody
	@ExceptionHandler(NumberFormatException.class) 
	public String handleNumberFormatExceptionWtihJSON(NumberFormatException exception) {

		return "";
	}
	*/
}
