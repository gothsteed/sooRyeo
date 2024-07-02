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
	public ModelAndView professor_info_edit(HttpServletRequest request, ModelAndView mav) {// 교수 정보 수정
		  
	      String address = request.getParameter("address") + " " + request.getParameter("detailaddress") + request.getParameter("extraaddress");   // 주소
	      String tel = request.getParameter("a2") + request.getParameter("hp2") + request.getParameter("hp3"); // 전화번호
	      rdto.setAddress(address);
	      rdto.setTel(tel);
         
         
	      MultipartFile attach =  rdto.getAttach();
           /*
           1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
           >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
                                 우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
                                 조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
            */
	      // WAS 의 webapp 의 절대경로를 알아와야 한다. 
	      HttpSession session = mrequest.getSession(); 
	      String root = session.getServletContext().getRealPath("/");
        
	      // System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
	      // ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
        
	      String path = root+"resources"+File.separator+"files";
	      /*    File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
              	운영체제가 Windows 이라면 File.separator 는  "\" 이고,
              	운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
	       */
	      // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	      // System.out.println("~~~ 확인용 path => " + path);
	      // ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files
	      /*
         	2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
	       */
	      String newFileName = "";
	      // WAS(톰캣)의 디스크에 저장될 파일명
        
	      byte[] bytes = null;
	      // 첨부 파일의 내용물을 담은 것
        
	      try {
	    	  bytes = attach.getBytes();
	    	  // 첨부파일의 내용물을 읽어오는 것
         
	    	  String originalFilename =  attach.getOriginalFilename();
	    	  // attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
         
	    	  // System.out.println("~~~ 확인용 originalFilename => " + originalFilename); 
	    	  // ~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf 
         
	    	  newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
	    	  // 첨부되어진 파일을 업로드 하는 것이다.
         
	    	  // System.out.println("~~~ 확인용 newFileName => " + newFileName);
	    	  // ~~~ 확인용 newFileName => 2024062712074811660790417300.xlsx
         
	    	  /*
              	3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기  
	    	   */
	    	  rdto.setImg_name(newFileName);
	    	  // WAS(톰캣)에 저장된 파일명(2024062712074811660790417300.xlsx) 이다.   
            
	      } catch (Exception e) {
	    	  e.printStackTrace();
	      }
      
	      int n = adminService.memberRegister_end(rdto);
      
	      if(n == 1) {
	    	  mav.addObject("message", "학생회원 등록을 성공하였습니다.");
	    	  mav.addObject("loc", request.getContextPath()+"/admin/MemberCheck.lms");
	    	  mav.setViewName("msg");
	      }
	      else {
	    	  mav.addObject("message", "학생회원 등록을 실패하였습니다.");
	    	  mav.addObject("loc", request.getContextPath()+"/admin/MemberRegister.lms");
	    	  mav.setViewName("msg");
	      }
      
	      return mav;
	}
		
	
}
