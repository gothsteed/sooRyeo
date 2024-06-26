package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.dto.LoginDTO;

public interface LoginService {

	JSONObject studentLogin(HttpServletRequest resquest, LoginDTO loginDTO);
	
	// 로그아웃
	ModelAndView logout(ModelAndView mav, HttpServletRequest request);

}
