package com.sooRyeo.app;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WeatherController {
	
	@GetMapping("/weatherXML.lms")
	public String weatherXML() {
		
		return "weatherXML";
		// /board/src/main/webapp/WEB-INF/views/weather/weatherXML.jsp 파일을 생성한다.
	}
	
	

}
