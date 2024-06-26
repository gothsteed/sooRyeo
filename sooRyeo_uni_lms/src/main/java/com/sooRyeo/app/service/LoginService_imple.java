package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.model.StudentDao;

import oracle.net.aso.a;

@Service
public class LoginService_imple implements LoginService {
	
	@Autowired
	private StudentDao studentDao;
	@Autowired
	private AES256 aES256;
	

	@Override
	public JSONObject studentLogin(HttpServletRequest resquest, LoginDTO loginDTO) {
		
		Student loginStudent = studentDao.selectStudent(loginDTO);
		
		JSONObject jsonObject = new JSONObject();
		
		if(loginStudent == null) {
			jsonObject.put("isSuccess", false);
			
			return jsonObject;
		}
		loginStudent.setDecodedEmail(aES256);
		loginStudent.setDecodeTel(aES256);
		
		
		HttpSession session = resquest.getSession();
		session.setAttribute("loginuser", loginStudent);

		System.out.println("email : " + loginStudent.getEmail());
			
		
		jsonObject.put("isSuccess", true);
		jsonObject.put("redirectUrl", resquest.getContextPath() +  "/student/dashboard.lms");
		return jsonObject;
		
	}

}
