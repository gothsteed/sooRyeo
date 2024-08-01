package com.sooRyeo.app.mongo.service;


import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
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
		int TotalMonthCount = 0;
	    
        List<LoginLog> countAdminList = loginLogRepository.findAllByMemberType(MemberType.ADMIN.toString());
        List<LoginLog> countProList = loginLogRepository.findAllByMemberType(MemberType.PROFESSOR.toString());
        List<LoginLog> countStudList = loginLogRepository.findAllByMemberType(MemberType.STUDENT.toString());       	
		
        ZoneId zoneId = ZoneId.of("Asia/Seoul"); // KMT 사용
        
        // 하루 총 시간
        LocalDate today = LocalDate.now(zoneId);
        LocalDateTime startOfDay = today.atStartOfDay(); // 오늘 00:00:00        
        LocalDateTime endOfDay = today.atTime(LocalTime.MAX); // 오늘 23:59:59.999999999
 


        // LocalDateTime을 Instant로 변환 (UTC 기준으로 변환)
        Instant insStartDay = startOfDay.atZone(zoneId).toInstant();
        Instant insEndDay = endOfDay.atZone(zoneId).toInstant();


        // Instant를 ZonedDateTime으로 변환 (한국 시간대 기준)
        ZonedDateTime zonedStartTime = insStartDay.atZone(zoneId);
        ZonedDateTime zonedEndTime = insEndDay.atZone(zoneId);

        // ZonedDateTime에 9시간 추가
        ZonedDateTime adjustedzonedStartTime = zonedStartTime.plusHours(9);
        ZonedDateTime adjustedzonedEndTime = zonedEndTime.plusHours(9);


        // 조정된 ZonedDateTime을 다시 Instant로 변환
        Instant startOfDayInstant = adjustedzonedStartTime.toInstant();
        Instant endOfDayInstant = adjustedzonedEndTime.toInstant();


        System.out.println("startOfDayInstant: " + startOfDayInstant);
        System.out.println("endOfDayInstant: " + endOfDayInstant);
        
        Instant oneDayBefore = startOfDayInstant.minus(1, ChronoUnit.DAYS); 		// 하루 전
        Instant twoDayBefore = startOfDayInstant.minus(2, ChronoUnit.DAYS); 		// 이틀 전
        Instant threeDayBefore = startOfDayInstant.minus(3, ChronoUnit.DAYS); 	// 3일 전
        Instant fourDayBefore = startOfDayInstant.minus(4, ChronoUnit.DAYS); 	// 4일 전
        Instant fiveDayBefore = startOfDayInstant.minus(5, ChronoUnit.DAYS); 	// 5일 전
        Instant sixDayBefore = startOfDayInstant.minus(6, ChronoUnit.DAYS); 		// 6일 전
        
        // System.out.println("확인용 endOfDay : " + endOfDay);
        // System.out.println("확인용 startOfDay : " + startOfDay);
        System.out.println("확인용 oneDayBefore : " + oneDayBefore);
        System.out.println("확인용 twoDayBefore : " + oneDayBefore);
        
        
        // 이번 달의 첫 날과 마지막 날 계산
        LocalDate firstDayOfMonth = today.withDayOfMonth(1); // 이번 달의 첫 날
        LocalDate lastDayOfMonth = today.withDayOfMonth(today.lengthOfMonth()); // 이번 달의 마지막 날

        // LocalDateTime 변환
        LocalDateTime startOfMonth = firstDayOfMonth.atStartOfDay(); // 첫 날 00:00:00
        LocalDateTime endOfMonth = lastDayOfMonth.atTime(LocalTime.MAX); // 마지막 날 23:59:59.999999999  
              
        
        System.out.println("확인용 startOfMonth : " + startOfMonth);
        System.out.println("확인용 endOfMonth : " + endOfMonth);
        
        // Instant 변환
        Instant startOfMonthInstant = startOfMonth.atZone(zoneId).toInstant();
        Instant endOfMonthInstant = endOfMonth.atZone(zoneId).toInstant();
        
        // 오늘부터 6일전까지 계산
        List<LoginLog> countDateList = loginLogRepository.findByTimestampBetween(startOfDayInstant.minus(7, ChronoUnit.DAYS), endOfDayInstant);
        // 오늘 기준 한달 계산
        List<LoginLog> countMonthList = loginLogRepository.findByTimestampBetween(startOfMonthInstant, endOfMonthInstant);     
        
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
            	          	
				/*
				 * LocalDateTime localDateTime = loginlog.getTimestamp();
				 * System.out.println("확인용 localDateTime : " + localDateTime);
				 * 
				 * Instant logTimestamp = localDateTime.atZone(zoneId).toInstant();
				 * 
				 * System.out.println("확인용 logTimestamp : " + logTimestamp);
				 */
                
             // LocalDateTime 생성 (예: 현재 한국 시간)
                LocalDateTime localDateTime = loginlog.getTimestamp();
                // System.out.println("Original LocalDateTime: " + localDateTime);

                // LocalDateTime을 Instant로 변환 (UTC 기준으로 변환)
                Instant instant = localDateTime.atZone(zoneId).toInstant();
                // System.out.println("Original Instant (UTC): " + instant);

                // Instant를 ZonedDateTime으로 변환 (한국 시간대 기준)
                ZonedDateTime zonedDateTime = instant.atZone(zoneId);

                // ZonedDateTime에 9시간 추가
                ZonedDateTime adjustedZonedDateTime = zonedDateTime.plusHours(9);
                // System.out.println("Adjusted ZonedDateTime (Asia/Seoul): " + adjustedZonedDateTime);

                // 조정된 ZonedDateTime을 다시 Instant로 변환
                Instant logTimestamp = adjustedZonedDateTime.toInstant();
                System.out.println("logTimestamp (UTC): " + logTimestamp);
                
                
                if (logTimestamp.isAfter(startOfDayInstant) && !logTimestamp.isAfter(endOfDayInstant)) {
                	
                    dailyCountMap.put("day1", dailyCountMap.get("day1") + 1);
                    
                } else if (logTimestamp.isAfter(oneDayBefore) && !logTimestamp.isAfter(startOfDayInstant)) {
                	
                    dailyCountMap.put("day2", dailyCountMap.get("day2") + 1);
                    
                } else if (logTimestamp.isAfter(twoDayBefore) && !logTimestamp.isAfter(oneDayBefore)) {
                	
                    dailyCountMap.put("day3", dailyCountMap.get("day3") + 1);
                    
                } else if (logTimestamp.isAfter(threeDayBefore) && !logTimestamp.isAfter(twoDayBefore)) {
                	
                    dailyCountMap.put("day4", dailyCountMap.get("day4") + 1);
                    
                } else if (logTimestamp.isAfter(fourDayBefore) && !logTimestamp.isAfter(threeDayBefore)) {
                	
                    dailyCountMap.put("day5", dailyCountMap.get("day5") + 1);
                    
                } else if (logTimestamp.isAfter(fiveDayBefore) && !logTimestamp.isAfter(fourDayBefore)) {
                	
                    dailyCountMap.put("day6", dailyCountMap.get("day6") + 1);
                    
                } else if (logTimestamp.isAfter(sixDayBefore) && !logTimestamp.isAfter(fiveDayBefore)) {
                	
                    dailyCountMap.put("day7", dailyCountMap.get("day7") + 1);
                
            	} 
                            
				/*// 7일간 방문자수
				 * if (logDate.getMonth() == today.getMonth() && logDate.getYear() ==
				 * today.getYear()) { dailyCountMap.put("totalday",
				 * dailyCountMap.get("totalday") + 1); }
				 */
                
                
            }// end of for(LoginLog loginlog : countDateList) 
        }// end of if(countDateList.size() != 0)
        
        
        if(countMonthList.size() != 0) {
        	for(LoginLog loginlog : countMonthList) {
        		
        		TotalMonthCount++;
        	}
        	
        }
        
       
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
        
        dailyCountMap.put("totalday", TotalMonthCount);
        
        
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
