package com.sooRyeo.app.mongo.service;


import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.mongo.entity.LoginLog;
import com.sooRyeo.app.mongo.entity.MemberType;
import com.sooRyeo.app.mongo.repository.LoginLogRepository;

@Service
public class LogService_imple implements LogService {
	
	@Autowired
	private LoginLogRepository loginLogRepository;
	
	@Autowired
    private JsonBuilder jsonBuilder;
	
	@Override
	public ResponseEntity<String> showCount(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("fffffff");
	    
		
        List<LoginLog> countList = loginLogRepository.findAllByMemberType(MemberType.ADMIN.toString());
        for(LoginLog l : countList) {
        	
        	System.out.println(l.getId());
        }

        return ResponseEntity.ok().body(jsonBuilder.toJson(countList));
		
	}

}
