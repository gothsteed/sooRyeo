package com.sooRyeo.app.mongo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sooRyeo.app.mongo.service.LogService;

@Controller
public class LogController {
	
	@Autowired
	private LogService logService;
	
	
	
	@ResponseBody
	@PostMapping(value = "/chart/showCount.lms", produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> showCount(HttpServletRequest request, HttpServletResponse response) {

        return logService.showCount(request, response);
    }
	

}
