package com.sooRyeo.app.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {

		String currentUrl =  request.getRequestURL().toString();
//		System.out.println(currentUrl);
		
		String query = request.getQueryString();
		if(request.getQueryString() != null) {
			
			currentUrl += "?";
			currentUrl += query;
		}
		
		//System.out.print(currentUrl);
		int startIndex = currentUrl.indexOf(request.getContextPath()) + request.getContextPath().length();
	
		
		currentUrl = currentUrl.substring(startIndex);
		// System.out.println("myutil : " + currentUrl);
		
		return currentUrl;
	}
}
