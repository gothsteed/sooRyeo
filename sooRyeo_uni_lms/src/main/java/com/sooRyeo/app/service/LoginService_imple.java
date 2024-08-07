package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sooRyeo.app.aop.LogType;
import com.sooRyeo.app.aop.Logging;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.model.AdminDao;
import com.sooRyeo.app.model.ProfessorDao;
import com.sooRyeo.app.model.StudentDao;


@Service
@Logging(type = LogType.LOGIN)
public class LoginService_imple implements LoginService {
	
	@Autowired
	private StudentDao studentDao;
	@Autowired
	private AES256 aES256;
	
	@Autowired
	private ProfessorDao professorDao;
	
	@Autowired
	private AdminDao adminDao;
	

	@Override
	public JSONObject studentLogin(HttpServletRequest resquest, LoginDTO loginDTO) {
		
		Student loginStudent = studentDao.selectStudent(loginDTO);
		
		
		// System.out.println("~~~ 확인용 : " + img_name);
		// ~~~ 확인용 : 202407051559321925805007091400.jpg
		
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

	
	@Override
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.invalidate();

		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/"; 
		
		// String loc = request.getHeader("refer");
		// request.getHeader("refer"); 은 이전 페이지의 URL을 가져오는 것이다!!!!!!!!!!
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
			
		return mav;
	}


	@Override
	public JSONObject professorLogin(HttpServletRequest resquest, LoginDTO loginDTO) {

		Professor loginProfessor = professorDao.selectProfessor(loginDTO);
		
		JSONObject jsonObject = new JSONObject();
		
		if(loginProfessor == null) {
			jsonObject.put("isSuccess", false);
			
			return jsonObject;
		}
		
		loginProfessor.setDecodedEmail(aES256);
		loginProfessor.setDecodeTel(aES256);
		
		
		HttpSession session = resquest.getSession();
		session.setAttribute("loginuser", loginProfessor);

		System.out.println("email : " + loginProfessor.getEmail());
			
		
		jsonObject.put("isSuccess", true);
		jsonObject.put("redirectUrl", resquest.getContextPath() +  "/professor/dashboard.lms");
		return jsonObject;
	}


	@Override
	public JSONObject adminLogin(HttpServletRequest resquest, LoginDTO loginDTO) {
		
		Admin loginAdmin = adminDao.selectAdmin(loginDTO);
		
		JSONObject jsonObject = new JSONObject();
		
		if(loginAdmin == null) {
			jsonObject.put("isSuccess", false);
			
			return jsonObject;
		}
		
		loginAdmin.setDecodedEmail(aES256);
		loginAdmin.setDecodeTel(aES256);
		
		
		HttpSession session = resquest.getSession();
		session.setAttribute("loginuser", loginAdmin);

		System.out.println("email : " + loginAdmin.getEmail());
			
		
		jsonObject.put("isSuccess", true);
		jsonObject.put("redirectUrl", resquest.getContextPath() +  "/admin/dashboard.lms");
		return jsonObject;
	}

	
}
