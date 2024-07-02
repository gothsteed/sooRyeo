package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

public interface StudentService {
	
	// 수업명, 교수명  select 
	List<Map<String, String>> classList(int userid);
	
	

}
