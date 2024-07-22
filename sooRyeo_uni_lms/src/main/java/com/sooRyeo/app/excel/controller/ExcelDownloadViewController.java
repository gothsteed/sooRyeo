package com.sooRyeo.app.excel.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.sooRyeo.app.aop.NoView;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.StudentService;

@Controller
public class ExcelDownloadViewController {
	
	@Autowired
	private StudentService service;

	
	// === 웹에서 보여지는 결과물을 Excel 파일로 다운받기  === //
	@NoView
	@PostMapping(value="/downloadExcelFile.action")
	public String downloadExcelFile(@RequestParam(defaultValue = "") String name,
									Model model,
									HttpServletRequest request) {
		
		
		service.employeeList_to_Excel(name, model, request);
	      
		return "excelDownloadView";
		// "excelDownloadView" 접두어 접미어
		// excelDownloadView 은 /WEB-INF/spring/appServlet/servlet-context.xml 파일에서 
		// #19. 에서 기술된 bean의 id 값이다.
	
	} // end of public String downloadExcelFile
}
