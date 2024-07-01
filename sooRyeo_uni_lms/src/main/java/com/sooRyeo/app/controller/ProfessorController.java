package com.sooRyeo.app.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.service.ProfessorService;


@Controller
@RequireLogin(type = Professor.class)
public class ProfessorController {
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	// @Qualifier("boardService_imple") DAO는 하나이기 때문에 Qualifier를 통해 지정할 필요가 거의 없다.
	private ProfessorService service;
	
	
	@RequestMapping(value = "/professor/dashboard.lms", method = RequestMethod.GET)
	public String professor() {// 대시보드 뷰단

		return "professor_dashboard.professor";
	}
	
	
	@RequestMapping(value = "/professor/request.lms", method = RequestMethod.GET)
	public String professor_request() {// 교수 강의신청 뷰단

		return "professor_request.professor";
	}
	
	
	@GetMapping("/professor/info.lms")
	public ModelAndView professor_info(HttpServletRequest request, ModelAndView mav, Professor professor) {// 교수 내 정보 뷰단
			
		professor = service.getInfo(request);
		
		// System.out.println("확인용 professor name : " + professor.getName());
		
		if(professor == null) {
			mav.setViewName("redirect:/professor/dashboard.lms");
			return mav;
		}
		
		mav.addObject("professor", professor);
		mav.setViewName("professor_info.professor");
		
		return mav;	
	}
	
}
