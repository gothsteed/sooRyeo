package com.sooRyeo.app;

import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.IsAlreadyLogin;
import com.sooRyeo.app.common.GoogleMail;
import com.sooRyeo.app.dto.LoginDTO;
import com.sooRyeo.app.service.FindService;
import com.sooRyeo.app.service.LoginService;

/**
 * Handles requests for the application home page.
 */
@Controller
@IsAlreadyLogin
public class HomeController {
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private FindService findService;
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "home";
	}
	
	@ResponseBody
	@PostMapping(value="/student/login.lms")
	public String home(HttpServletRequest resquest,  LoginDTO loginDTO) {
		
		System.out.println("id : " + loginDTO.getId());
		System.out.println("pwd : " + loginDTO.getPassword());
		
		JSONObject json = loginService.studentLogin(resquest, loginDTO);
		
		
		return json.toString();
	}
	
	

	@GetMapping("/logout.lms")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {// 로그아웃
		
		mav = loginService.logout(mav, request);
		
		return mav;
		
	}
	
	
	@ResponseBody
	@PostMapping(value="/professor/login.lms")
	public String professorLogin(HttpServletRequest resquest,  LoginDTO loginDTO) {// 교수 로그인
		
		System.out.println("id : " + loginDTO.getId());
		System.out.println("pwd : " + loginDTO.getPassword());
		
		JSONObject json = loginService.professorLogin(resquest, loginDTO);
			
		return json.toString();
		
	}
	
	@ResponseBody
	@PostMapping(value="/admin/login.lms")
	public String adminLogin(HttpServletRequest resquest,  LoginDTO loginDTO) {// 교수 로그인
		
		JSONObject json = loginService.adminLogin(resquest, loginDTO);
			
		return json.toString();
		
	}
	
	// 아이디 찾기
    @RequestMapping(value = "/member/idfind.lms", produces="text/plain;charset=UTF-8")
    public ModelAndView idFind(ModelAndView mav, HttpServletRequest request) {
    	
      String method = request.getMethod();
      	
      if("GET".equalsIgnoreCase(method)) {
    	  
    	  mav.addObject("method", method);
    	  
    	  mav.setViewName("idFind");
    	  
    	  return mav;
          // /WEB-INF/views/idFind.jsp
      }
      else {

          String name = request.getParameter("name");
          String email = request.getParameter("email");
          String memberType = request.getParameter("memberType");
          
          String userid = findService.idFind(name, email, memberType);
          
          mav.addObject("method", method);
          mav.addObject("userid", userid);
        	
          mav.setViewName("idFind");
          // /WEB-INF/views/idFind.jsp
          
          return mav;
      }

    }
    
    
    // 비밀번호 찾기
	@RequestMapping(value = "/member/pwdfind.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView pwdFind(ModelAndView mav, HttpServletRequest request) {
		
		  String method = request.getMethod();
      	
	      if("GET".equalsIgnoreCase(method)) {
	    	  
	    	  mav.addObject("method", method);
	    	  
	    	  mav.setViewName("pwdFind");
	    	  
	    	  return mav;
	          // /WEB-INF/views/pwdFind.jsp
	      }
	      else {

	          String id = request.getParameter("id");
	          String email = request.getParameter("email");
	          String memberType = request.getParameter("memberType");
	          
	          // 데이터베이스에 회원이 존재하는지 확인하는 메소드
	          boolean isUserExist = findService.memberCheck(id, email, memberType);
	          
	          boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
	          if(isUserExist) { // 회원이 존재하는 경우
	        	  
					// 인증키를 랜덤하게 생성하도록 한다.
					Random rnd = new Random();

					String certification_code = "";
					// 인증키는 영문 대문자 5글자로 생성

					char randchar = ' ';
					for (int i = 0; i < 5; i++) {

						randchar = (char) (rnd.nextInt('Z' - 'A' + 1) + 'A');
						certification_code += randchar;
						
					} // end of for ---------------------
					
					// 랜덤하게 생성한 인증코드(certification_code)를 비밀번호 찾기를 하고자 하는 사용자의 email 로 전송시킨다.
					GoogleMail mail = new GoogleMail();
					
					try {
						mail.send_certification_code(email, certification_code);
						sendMailSuccess = true;
						
						// 세션 불러오기
						HttpSession session = request.getSession();
						session.setAttribute("certification_code", certification_code);
						
					} catch (Exception e) {
						// 메일 전송이 실패한 경우
						e.printStackTrace();
					}
	          }
	          
	          mav.addObject("method", method);
	          mav.addObject("email", email);
	          mav.addObject("id", id);
	          mav.addObject("isUserExist", isUserExist); // 사용자가 맞는지 확인
	          mav.addObject("sendMailSuccess", sendMailSuccess); // 메일이 잘 갔는지
	          
	        	
	          mav.setViewName("pwdFind");
	          // /WEB-INF/views/pwdFind.jsp
	          
	          return mav;
	      }
	
	}
	
	
	// 인증코드 확인
	@PostMapping("/member/verifyCertification.lms")
	public ModelAndView verifyCertification(ModelAndView mav, HttpServletRequest request) {
		
		String userCertificationCode = request.getParameter("userCertificationCode");
		String userid = request.getParameter("userid");
		String memberType = request.getParameter("memberType");
		
		
		HttpSession session = request.getSession(); // 세션 불러오기
		String certification_code = (String)session.getAttribute("certification_code");
		
		String msg = "";
		String loc = "";
		
		if(certification_code.equals(userCertificationCode)) { // 이메일로 보낸 인증코드와 사용자가 입력한 인증코드가 같다면
			
			msg = "인증이 성공되었습니다.";
			loc = request.getContextPath() + "/member/pwdFindEnd.lms?userid=" + userid + "&memberType=" + memberType;
			
			mav.addObject("message", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		} else {
			msg = "발급된 인증코드와 일치하지 않습니다.\\n메인화면으로 돌아갑니다.";
			loc = request.getContextPath();
			
			mav.addObject("message", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	
	// 인증코드가 맞으면 비밀번호 변경
	@GetMapping ("/member/pwdFindEnd.lms")
	public ModelAndView pwdFindEnd(ModelAndView mav, HttpServletRequest request) {
		
  	    String userid = request.getParameter("userid");
  	    String memberType = request.getParameter("memberType");
  	    
  	    
  	    System.out.println("userid 확인!!!! =>" + userid);
  	    System.out.println("memberType 확인!!!! =>" + memberType);

  	  
		String method = request.getMethod();

	    	  mav.addObject("method", method);
	    	  mav.addObject("userid",userid);
	    	  mav.addObject("memberType",memberType);
	    	  
	  		  mav.setViewName("pwdFindEnd");
			  // /WEB-INF/views/pwdFindEnd.jsp

		return mav;
	}
	
	@PostMapping("/member/pwdFindEnd.lms")
	public ModelAndView pwdFindEnd2(ModelAndView mav, HttpServletRequest request) {
		
		
        String pwd = request.getParameter("pwd");
  	    String userid = request.getParameter("userid");
  	    String memberType = request.getParameter("memberType");
  	    
  	    System.out.println("userid 확인!!!! =>" + userid);
  	    System.out.println("memberType 확인!!!! =>" + memberType);
        
        String msg = "";
        String loc = "";
       
       int n = findService.pwdFindEnd(pwd, userid, memberType);
       
       if(n==1) {
          
            msg = "비밀번호가 변경되었습니다.";
            loc = request.getContextPath();
          
	        mav.addObject("message", msg);
	        mav.addObject("loc", loc);
	          
	        mav.setViewName("msg");
	          
       }
       else {
          
	          msg = "비밀번호 변경에 실패하셨습니다.";
	          loc = request.getContextPath();
	          
	          mav.addObject("message", msg);
	          mav.addObject("loc", loc);
	          
	          mav.setViewName("msg");

       }
       
       	return mav;
       
	}
	
	

	
	
	
	
}
