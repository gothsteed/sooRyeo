package com.sooRyeo.app.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.dto.CurriculumRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;
import com.sooRyeo.app.dto.RegisterDTO;
import com.sooRyeo.app.service.AdminService;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.service.DepartmentService;

@Controller
@RequireLogin(type = Admin.class)
public class AdminController {
	
	@Autowired
	private AdminService adminService;

	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private FileManager fileManager;

	@RequestMapping(value = "/admin/dashboard.lms", method = RequestMethod.GET)
	public String admin_Main() {

		return "admin_Main.admin";
	}
	
	@RequestMapping(value = "/admin/MemberCheck.lms", method = RequestMethod.GET)
	public String MemberCheck() {
		
		return "MemberCheck.admin";
	}
	
	@RequestMapping(value = "/admin/MemberRegister.lms", method = RequestMethod.GET)
	public String MemberRegister(HttpServletRequest request) {
		
		// select 태그에 학과를 전부 불러오는 메소드
		List<Department> departmentList = adminService.departmentList_select();
		
		request.setAttribute("departmentList", departmentList);
		
		return "MemberRegister.admin";
	}
	
	@RequestMapping(value = "/admin/ProfessorRegister.lms", method = RequestMethod.GET)
	public String ProfessorRegister(HttpServletRequest request) {
		
		// select 태그에 학과를 전부 불러오는 메소드
		List<Department> departmentList = adminService.departmentList_select();
		
		request.setAttribute("departmentList", departmentList);
		
		return "ProfessorRegister.admin";
	}

	@PostMapping(value = "/admin/memberRegister_end.lms")
	public ModelAndView memberRegister_end(HttpServletRequest request, ModelAndView mav, RegisterDTO rdto, MultipartHttpServletRequest mrequest) {
		
		String tel = request.getParameter("a2") + request.getParameter("hp2") + request.getParameter("hp3"); // 전화번호
		rdto.setTel(tel);
		
		if(rdto.getGrade() != null) {
			String address = request.getParameter("address") + " " + request.getParameter("detailaddress") + request.getParameter("extraaddress");	// 주소
			rdto.setAddress(address);
		}
		else {
			String office_address = request.getParameter("address") + " " + request.getParameter("detailaddress") + request.getParameter("extraaddress");	// 주소
			rdto.setOffice_address(office_address);
		}
		
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
			mav.addObject("message", "회원 등록을 성공하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/admin/MemberCheck.lms");
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "회원 등록을 실패하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/admin/MemberRegister.lms");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping(value="/admin/emailDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String addComment(String email) {
		
		String emailDuplicateCheck = adminService.emailDuplicateCheck(email);
		// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("emailDuplicateCheck", emailDuplicateCheck);
		
		return jsonObj.toString();
	}
	
	@RequestMapping(value = "/admin/curriculum.lms", method = RequestMethod.GET)
	public ModelAndView curriculumPage(HttpServletRequest request, ModelAndView mav) {
		
		
		return adminService.ShowCurriculumPage(request, mav);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/admin/curriculumJSON.lms", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String getCurriculumPage(HttpServletRequest request, ModelAndView mav, CurriculumPageRequestDto requestDto) {
		
		return adminService.getCurriculumPage(request, mav, requestDto);
	}
	
	
	
	
	
	@RequestMapping(value = "/admin/add_curriculum.lms", method = RequestMethod.GET)
	public ModelAndView addCurriculumPage(ModelAndView mav) {
		
		List<Department> departments =  adminService.getDeptartments();

		
		mav.addObject("departments", departments);
		mav.setViewName("add_curriculum.admin");
		
		return mav;
	}
	
	
	
	
	@RequestMapping(value = "/admin/add_curriculum_end.lms", method = RequestMethod.POST)
	public ModelAndView insertCurriculum(HttpServletRequest request, ModelAndView mav, CurriculumRequestDto requestDto) {
		
		return adminService.insertCurriculum(request, mav, requestDto);
	}
	
	
	@GetMapping("/admin/announcement.lms")
	public ModelAndView announcement(ModelAndView mav, Announcement an) {
	
		List<Announcement> announcementList =  adminService.getAnnouncement(an);
		
		mav.addObject("announcementList", announcementList);
		mav.setViewName("announcement.admin");

		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/admin/deleteCurriculumREST.lms", method = RequestMethod.DELETE, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> deleteCurriculumREST(HttpServletRequest request, ModelAndView mav) {
		return adminService.deleteCurriculum(request, mav);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/admin/updateCurriculumREST.lms", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> updateCurriculumREST(HttpServletRequest request, ModelAndView mav, @RequestBody CurriculumRequestDto requestDto) {
		return adminService.updateCurriculum(request, mav, requestDto);
	}
	
	
}
