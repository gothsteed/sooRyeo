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
		
        List<LoginLog> countAdminList = loginLogRepository.findAllByMemberType(MemberType.ADMIN.toString());
        List<LoginLog> countProList = loginLogRepository.findAllByMemberType(MemberType.PROFESSOR.toString());
        List<LoginLog> countStudList = loginLogRepository.findAllByMemberType(MemberType.STUDENT.toString());
        
        int AdminCount = 0;
        int ProCount = 0;
        int StudCount = 0;
        
        
        if(countAdminList.size() != 0) {
	        for(LoginLog loginlog : countAdminList) {
	        	
	        	AdminCount++;     	
	        }
        }
        if(countProList.size() != 0) {
        	for(LoginLog loginlog : countProList) {
        	
        		ProCount++;     	
        	}
        }
        if(countStudList.size() != 0) {
        	for(LoginLog loginlog : countStudList) {
	
        		StudCount++;     	
        	}
        }
        
        System.out.println("확인용 AdminCount : " + AdminCount);
        System.out.println("확인용 ProCount : " + ProCount);
        System.out.println("확인용 StudCount : " + StudCount);

        return ResponseEntity.ok().body(jsonBuilder.toJson(countAdminList));
		
	}

}
