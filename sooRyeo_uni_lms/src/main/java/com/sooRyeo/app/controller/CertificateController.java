package com.sooRyeo.app.controller;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.CertificateService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@RequireLogin(type = {Student.class})
@Controller
public class CertificateController {

	@Autowired
	private CertificateService certificateService;

	
    @GetMapping("/student/certificate/menu.lms")
    public ModelAndView menu(ModelAndView mav, HttpServletRequest request) {
        mav.setViewName("certificate/menu");
        return mav;
    }
    
    
    @PostMapping("/certificate/grade.lms")
    public ModelAndView grade(ModelAndView mav, HttpServletRequest request) {
    
    	int n = 0;
    	
    	n = certificateService.getGrade();
    	
    	
    	
    	if(n==1) {
			 mav.addObject("message", "증명서가 발급되었습니다.");
			 mav.addObject("loc", request.getContextPath()+"/student/certificate/menu.lms");
    	}
    	else {
    		mav.addObject("message", "오류가 발생하여 증명서를 발급하지 못했습니다.");
    		mav.addObject("loc", "javascript:history.back()");
    	}
    	
    	mav.setViewName("msg");
    	
    	return mav;  	
    }


}
