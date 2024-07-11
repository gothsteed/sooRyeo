package com.sooRyeo.app.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.service.ProfessorService;


@Controller
@RequireLogin(type = {Professor.class})
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
	
	
	@ResponseBody
	@PostMapping(value = "/professor/pwdDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String pwdDuplicateCheck(HttpServletRequest request, Professor professor) {// 교수 비밀번호 중복확인		
		
		JSONObject json = service.pwdDuplicateCheck(request);						
		
		return json.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value = "/professor/telDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String telDuplicateCheck(HttpServletRequest request, Professor professor) {// 교수 전화번호 중복확인		
		
		JSONObject json = service.telDuplicateCheck(request);						
		
		return json.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value = "/professor/emailDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String emailDuplicateCheck(HttpServletRequest request, Professor professor) {// 교수 전화번호 중복확인		
		
		JSONObject json = service.emailDuplicateCheck(request);						
		
		return json.toString();
	}
	
	
	@PostMapping(value = "/professor/professor_info_edit.lms")
	public ModelAndView professor_info_edit( ModelAndView mav, Professor professor, MultipartHttpServletRequest mrequest) {// 첨부파일 없는 교수 정보 수정
		     
	      int n = service.professor_info_edit(professor, mrequest);
      
	      if(n == 1) {
	    	  mav.addObject("message", "교수정보 수정을 성공하였습니다.");
	    	  mav.addObject("loc", mrequest.getContextPath()+"/professor/dashboard.lms");
	    	  mav.setViewName("msg");
	      }
	      else {
	    	  mav.addObject("message", "교수정보 수정이 실패하였습니다.");
	    	  mav.addObject("loc", mrequest.getContextPath()+ "/professor/info.lms");
	    	  mav.setViewName("msg");
	      }
      
	      return mav;
	}
		
	
}
