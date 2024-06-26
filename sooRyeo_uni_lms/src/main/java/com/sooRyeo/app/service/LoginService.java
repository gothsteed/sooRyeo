package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;

import com.sooRyeo.app.dto.LoginDTO;

public interface LoginService {

	JSONObject studentLogin(HttpServletRequest resquest, LoginDTO loginDTO);

}
