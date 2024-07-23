package com.sooRyeo.app.mongo.service;


import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	
	@Autowired
	private ObjectMapper objectMapper;
	
	@Override
	public ResponseEntity<String> showCount(HttpServletRequest request, HttpServletResponse response) {		
		
		int AdminCount = 0;
	    int ProCount = 0;
	    int StudCount = 0;
		
        List<LoginLog> countAdminList = loginLogRepository.findAllByMemberType(MemberType.ADMIN.toString());
        List<LoginLog> countProList = loginLogRepository.findAllByMemberType(MemberType.PROFESSOR.toString());
        List<LoginLog> countStudList = loginLogRepository.findAllByMemberType(MemberType.STUDENT.toString());       	
		
        ZoneId zoneId = ZoneId.systemDefault(); // 시스템 기본 시간대 사용

        LocalDate today = LocalDate.now(zoneId);
        LocalDateTime startOfDay = today.atStartOfDay(); // 오늘 00:00:00
        LocalDateTime endOfDay = today.atTime(LocalTime.MAX); // 오늘 23:59:59.999999999
   
        
        
        Instant startOfDayInstant = startOfDay.atZone(zoneId).toInstant();
        Instant endOfDayInstant = endOfDay.atZone(zoneId).toInstant();

        //System.out.println("Start of day: " + startOfDayInstant);
        //System.out.println("End of day: " + endOfDayInstant);
        
        Instant oneDayBefore = startOfDayInstant.minus(1, ChronoUnit.DAYS); 		// 하루 전
        Instant twoDayBefore = startOfDayInstant.minus(2, ChronoUnit.DAYS); 		// 이틀 전
        Instant threeDayBefore = startOfDayInstant.minus(3, ChronoUnit.DAYS); 	// 3일 전
        Instant fourDayBefore = startOfDayInstant.minus(4, ChronoUnit.DAYS); 	// 4일 전
        Instant fiveDayBefore = startOfDayInstant.minus(5, ChronoUnit.DAYS); 	// 5일 전
        Instant sixDayBefore = startOfDayInstant.minus(6, ChronoUnit.DAYS); 		// 6일 전
        Instant sevenDayBefore = startOfDayInstant.minus(7, ChronoUnit.DAYS); 		// 7일 전
        
        

        //System.out.println("확인용 endOfDay : " + endOfDay);
        //System.out.println("확인용 startOfDay : " + startOfDay);
        //System.out.println("확인용 oneDayBefore : " + oneDayBefore);

        List<LoginLog> countDateList = loginLogRepository.findByTimestampBetween(startOfDayInstant.minus(7, ChronoUnit.DAYS), endOfDayInstant);
        
        Map<String, Integer> dailyCountMap = new HashMap<>();
        	dailyCountMap.put("day1", 0);
        	dailyCountMap.put("day2", 0);
        	dailyCountMap.put("day3", 0);
        	dailyCountMap.put("day4", 0);
        	dailyCountMap.put("day5", 0);
        	dailyCountMap.put("day6", 0);
        	dailyCountMap.put("day7", 0);
        	dailyCountMap.put("totalday", 0);
        		
        if(countDateList.size() != 0) {
            for(LoginLog loginlog : countDateList) {
            	
            	LocalDate logDate = loginlog.getTimestamp().toLocalDate();
            	//System.out.println("확인용 logDate : " + logDate);
            	
            	LocalDateTime localDateTime = loginlog.getTimestamp();          	
            	
            	Instant logTimestamp = localDateTime.atZone(zoneId).toInstant();
                
                //System.out.println("확인용 logTimestamp : " + logTimestamp);
                
                
                if (logTimestamp.isAfter(oneDayBefore) && !logTimestamp.isAfter(endOfDayInstant)) {
                	
                    dailyCountMap.put("day1", dailyCountMap.get("day1") + 1);
                    
                } else if (logTimestamp.isAfter(twoDayBefore) && !logTimestamp.isAfter(oneDayBefore)) {
                	
                    dailyCountMap.put("day2", dailyCountMap.get("day2") + 1);
                    
                } else if (logTimestamp.isAfter(threeDayBefore) && !logTimestamp.isAfter(twoDayBefore)) {
                	
                    dailyCountMap.put("day3", dailyCountMap.get("day3") + 1);
                    
                } else if (logTimestamp.isAfter(fourDayBefore) && !logTimestamp.isAfter(threeDayBefore)) {
                	
                    dailyCountMap.put("day4", dailyCountMap.get("day4") + 1);
                    
                } else if (logTimestamp.isAfter(fiveDayBefore) && !logTimestamp.isAfter(fourDayBefore)) {
                	
                    dailyCountMap.put("day5", dailyCountMap.get("day5") + 1);
                    
                } else if (logTimestamp.isAfter(sixDayBefore) && !logTimestamp.isAfter(fiveDayBefore)) {
                	
                    dailyCountMap.put("day6", dailyCountMap.get("day6") + 1);
                    
                } else if (logTimestamp.isAfter(sevenDayBefore) && !logTimestamp.isAfter(sixDayBefore)) {
                	
                    dailyCountMap.put("day7", dailyCountMap.get("day7") + 1);
                
            	} 
                            
                if (logDate.getMonth() == today.getMonth() && logDate.getYear() == today.getYear()) {
                    dailyCountMap.put("totalday", dailyCountMap.get("totalday") + 1);
                }
                
                
            }// end of for(LoginLog loginlog : countDateList) 
        }// end of if(countDateList.size() != 0)
        
       
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
        
        for (Map.Entry<String, Integer> entry : dailyCountMap.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
        
        
        //System.out.println("확인용 AdminCount : " + AdminCount);
        //System.out.println("확인용 ProCount : " + ProCount);
        //System.out.println("확인용 StudCount : " + StudCount);
        
        
        String jsonResponse = "";
		try {
			jsonResponse = objectMapper.writeValueAsString(dailyCountMap);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
        return ResponseEntity.ok().body(jsonResponse);
		
	}

}
