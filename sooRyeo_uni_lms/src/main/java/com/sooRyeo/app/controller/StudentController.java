package com.sooRyeo.app.controller;

import java.util.List;
import java.util.Map;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.StudentDTO;
import com.sooRyeo.app.service.StudentService;

@Controller
@RequireLogin(type = Student.class)
public class StudentController {
	
	@Autowired
	private StudentService service;

	@Autowired
	private StudentService studentservice;
	
	@Autowired
	private FileManager fileManager;
	
	
	@RequestMapping(value = "/student/dashboard.lms", method = RequestMethod.GET)
	public String student() {

		return "student_Main.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	@RequestMapping(value = "/student/lectureList.lms", method = RequestMethod.GET)
	public String lectureList() {
		
		return "lectureList.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	@GetMapping(value="/student/classList.lms")
	public String classList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Student loginuser = (Student)session.getAttribute("loginuser");
		
		int userid = loginuser.getStudent_id();
		
		List<Map<String, String>> mapList = service.classList(userid);
		
		request.setAttribute("mapList", mapList);

		return "classList.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
	@GetMapping("/student/assignment_List.lms")
	public String assignment_List(HttpServletRequest request) {
		
		
		return "assignment_List.student";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	// 내정보 보기
	@RequestMapping(value="/student/myInfo.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView myInfo(ModelAndView mav, HttpServletRequest request) {
		
		StudentDTO member_student = studentservice.getViewInfo(request);
		
		// System.out.println(member_student.getStatus());
		
		mav.addObject("member_student", member_student);
		mav.setViewName("myInfo.student");
		// /WEB-INF/views/student/{1}.jsp
		
		return mav;
		
	} // end of public ModelAndView myInfo
	
	
	
	
	// 내정보 수정 및 파일 첨부(이미지)
	@PostMapping(value="/student/myInfoUpdate.lms")
	public ModelAndView myInfoUpdate(HttpServletRequest request, ModelAndView mav, StudentDTO student, MultipartHttpServletRequest mrequest) {
		
		String tel = request.getParameter("a2") + request.getParameter("hp2") + request.getParameter("hp3"); // 전화번호
		
		student.setTel(tel);
		
		
		MultipartFile attach =  student.getAttach();
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
	    	student.setImg_name(newFileName);
		   // WAS(톰캣)에 저장된 파일명(2024062712074811660790417300.xlsx) 이다.	
		   
	} catch (Exception e) {
		e.printStackTrace();
	}
	

	int n = studentservice.myInfoUpdate(student);
	
	if(n == 1) {
		mav.addObject("message", "정보 수정을 성공하였습니다.");
		mav.addObject("loc", request.getContextPath()+"/student/myInfo.lms");
		mav.setViewName("msg");
	}
	else {
		mav.addObject("message", "정보 수정을 실패하였습니다.");
		mav.addObject("loc", request.getContextPath()+"/student/myInfo.lms");
		mav.setViewName("msg");
	}
	
	return mav;
		
	} // end of public ModelAndView myInfoUpdate
	
	
	
	
	@ResponseBody
	@PostMapping(value="/student/emailDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String addComment(String email) {
		
		String emailDuplicateCheck = studentservice.emailDuplicateCheck(email);
		// 수정시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("emailDuplicateCheck", emailDuplicateCheck);
		
		return jsonObj.toString();
	} // end of public String addComment
	
	
	
	// 수업  - 내 강의보기
	@RequestMapping(value="/student/myLecture.lms", produces="text/plain;charset=UTF-8")
	public String myLecture() {
		return "myLecture.student";
		// /WEB-INF/views/student/{1}.jsp
		
	} // end of public String myLecture
	
	
	
	
}
