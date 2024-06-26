package com.sooRyeo.app;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.model.StudentDao;
import com.sooRyeo.app.service.StudentService;

@Controller
public class TestController {
	
	@Autowired
	private StudentService studentService;
	
	@GetMapping("/test")
	public String test() {
		return "testMain.student";
	}

	
	
	@GetMapping("/testselect")
	public String testSelect() {
		
		//List<Student> student =  studentService.getAllStudent();
		
		
		return "testMain.student";
	}

}
