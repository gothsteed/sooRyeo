package com.sooRyeo.app.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.support.RequestContextUtils;

import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.domain.Pager;
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
import com.sooRyeo.app.common.MyUtil;

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
		
		if(rdto.getGrade() == null) {
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
	public ModelAndView announcement(ModelAndView mav, Announcement an, HttpServletRequest request) {

		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord == null) {
			searchWord = "";
		}
		if(searchWord != null) {
			searchWord = searchWord.trim();
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord",searchWord);
		
		int currentPage = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		
		// 학사공지사항을 전부 불러오는 메소드
		Pager<Announcement> announcementList =  adminService.getAnnouncement(currentPage);
		
		// System.out.println(announcementList.getObjectList());
		
		mav.addObject("announcementList", announcementList.getObjectList());
		mav.addObject("currentPage", announcementList.getPageNumber());
		mav.addObject("perPageSize", announcementList.getPerPageSize());
		mav.addObject("pageBar", announcementList.makePageBar(request.getContextPath() +  "/admin/announcement.lms"));
		mav.setViewName("announcement.admin");
		
		String goBackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("goBackURL",goBackURL);
		
		return mav;
	}
	
	@RequestMapping("/admin/announcementView.lms")
	public ModelAndView view(ModelAndView mav, HttpServletRequest request) {
		
		String seq = "";
		String goBackURL = "";
		String searchWord = "";
		
		// redirect 되어서 넘어온 데이터가 있는지 꺼내어 와본다.
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request); // ? 는 아무거나 라는 의미 == object
				
		if(inputFlashMap != null) { // redirect 되어서 넘어온 데이터가 있다면 이라는 의미
			
			@SuppressWarnings("unchecked") // 경고 표시를 하지 말라는 뜻이다.
			Map<String,String> redirect_map = (Map<String,String>) inputFlashMap.get("redirect_map"); // 리턴타입이 오브젝트라 캐스팅한 것.
			// "redirect_map" 값은  /view_2.action 에서  redirectAttr.addFlashAttribute("키", 밸류값); 을 할때 준 "키" 이다. 
	        // "키" 값을 주어서 redirect 되어서 넘어온 데이터를 꺼내어 온다. 
	        // "키" 값을 주어서 redirect 되어서 넘어온 데이터의 값은 Map<String, String> 이므로 Map<String, String> 으로 casting 해준다.

			// === #143. 이전글제목, 다음글제목 보기 시작 === //
	           System.out.println("~~~ 확인용 seq : " + redirect_map.get("seq"));
	           seq = redirect_map.get("seq");
	           goBackURL = redirect_map.get("goBackURL");
	           searchWord = redirect_map.get("searchWord");
	           
	           try {
	               searchWord = URLDecoder.decode(redirect_map.get("searchWord"), "UTF-8"); // 한글데이터가 포함되어 있으면 반드시 한글로 복구주어야 한다. 
	               goBackURL = URLDecoder.decode(redirect_map.get("goBackURL"), "UTF-8");   // 한글데이터가 포함되어 있으면 반드시 한글로 복구주어야 한다.
	          } catch (UnsupportedEncodingException e) {
	              e.printStackTrace();
	          }

	           System.out.println("~~~ 확인용 goBackURL : " + goBackURL);
	           System.out.println("~~~ 확인용 searchWord : " + searchWord);
	           /*
	            ~~~ 확인용 seq : 207
				~~~ 확인용 goBackURL : /list.action?searchType=name&searchWord=%EC%A0%95%ED%99%94
				~~~ 확인용 searchType : name
				~~~ 확인용 searchWord : 정화  ==> 인코드 해줬기 때문에 한글이 제대로 나옴	
	           */
            // === #143. 이전글제목, 다음글제목 보기 끝 === //
			
		}
		//////////////////////////////////////////////////////////////////////////
		else { // redirect 되어서 넘어온 데이터가 아닌 경우
			
			// == 조회하고자 하는 글번호 받아오기 ==
	           
	        // 글목록보기인 /list.action 페이지에서 특정 글제목을 클릭하여 특정글을 조회해온 경우  
	        // 또는 
	        // 글목록보기인 /list.action 페이지에서 특정 글제목을 클릭하여 특정글을 조회한 후 새로고침(F5)을 한 경우는 원본이 form 을 사용해서 POST 방식으로 넘어온 경우이므로 "양식 다시 제출 확인" 이라는 대화상자가 뜨게 되며 "계속" 이라는 버튼을 클릭하면 이전에 입력했던 데이터를 자동적으로 입력해서 POST 방식으로 진행된다. 그래서  request.getParameter("seq"); 은 null 이 아닌 번호를 입력받아온다.     
	        // 그런데 "이전글제목" 또는 "다음글제목" 을 클릭하여 특정글을 조회한 후 새로고침(F5)을 한 경우는 원본이 /view_2.action 을 통해서 redirect 되어진 경우이므로 form 을 사용한 것이 아니라서 "양식 다시 제출 확인" 이라는 alert 대화상자가 뜨지 않는다. 그래서  request.getParameter("seq"); 은 null 이 된다. 
			seq = request.getParameter("seq");
			// System.out.println("~~~~~~ 확인용 seq : " + seq);
            // ~~~~~~ 확인용 seq : 213
            // ~~~~~~ 확인용 seq : null
			
			// === #134. 특정글을 조회한 후 "검색된결과목록보기" 버튼을 클릭했을 때 돌아갈 페이지를 만들기 위함. === //
			goBackURL = request.getParameter("goBackURL");
			// System.out.println("확인용(view.action) goBackURL : " + goBackURL);
			/*
			   	이것은 잘못된 것이다 (get 방식일 때)
			 	확인용(view.action) goBackURL : /list.action?searchType=
			 	
			 	올바른 것 (POST 방식일 때)
			 	확인용(view.action) goBackURL : /list.action?searchType=subject&searchWord=%EC%A0%95%ED%99%94
			*/
			
			
			// >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 시작  <<< //
			searchWord = request.getParameter("searchWord");
			
			if(searchWord == null) {
				searchWord = "";
			}
			
			// System.out.println("확인용(view.action) searchType : " + searchType);
			// System.out.println("확인용(view.action) searchWord : " + searchWord);
			/*
			    확인용(view.action) searchType : subject
			    확인용(view.action) searchWord : jav
			*/
			// >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 끝  <<< // 
		}
		
		mav.addObject("goBackURL", goBackURL);
		
		
		try {
			Integer.parseInt(seq);
			/* 
	            "이전글제목" 또는 "다음글제목" 을 클릭하여 특정글을 조회한 후 새로고침(F5)을 한 경우는   
			            원본이 /view_2.action 을 통해서 redirect 되어진 경우이므로 form 을 사용한 것이 아니라서   
			        "양식 다시 제출 확인" 이라는 alert 대화상자가 뜨지 않는다. 
			            그래서  request.getParameter("seq"); 은 null 이 된다. 
			            즉, 글번호인 seq 가 null 이 되므로 DB 에서 데이터를 조회할 수 없게 된다.     
			            또한 seq 는 null 이므로 Integer.parseInt(seq); 을 하면  NumberFormatException 이 발생하게 된다. 
		    */
			
			HttpSession session =  request.getSession();
			Admin loginuser = (Admin)session.getAttribute("loginuser");
			
			String login_userid = null;
			if(loginuser != null) {
				login_userid = String.valueOf(loginuser.getAdmin_seq());
				// login_userid 는 로그인 되어진 사용자의 userid 이다.
			}
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("seq", seq);
			paraMap.put("login_userid", login_userid);
			
			// >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 시작  <<< //
			paraMap.put("searchWord",searchWord);
			// >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 끝  <<< //
			
			// === #68. !!! 중요 !!! 
            //     글1개를 보여주는 페이지 요청은 select 와 함께 
            //     DML문(지금은 글조회수 증가인 update문)이 포함되어져 있다.
            //     이럴경우 웹브라우저에서 페이지 새로고침(F5)을 했을때 DML문이 실행되어
            //     매번 글조회수 증가가 발생한다.
            //     그래서 우리는 웹브라우저에서 페이지 새로고침(F5)을 했을때는
            //     단순히 select만 해주고 DML문(지금은 글조회수 증가인 update문)은 
            //     실행하지 않도록 해주어야 한다. !!! === //

			// 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다.
			Announcement an = null;
			
			if("yes".equals( (String)session.getAttribute("readCountPermission") )) {
				// 글목록보기인 /list.action 페이지를 클릭한 다음에 특정글을 조회해온 경우이다.

				an = adminService.getView(paraMap);
				// 글 조회수 증가와 함께 글 1개를 조회를 해오는 것
				// System.out.println("~~ 확인용 글내용 : " + boardvo.getContent());
				
				session.removeAttribute("readCountPermission"); // 용도 폐기 
		    	// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
			}
			else { // 위에 if 까지 갔다가 readCountPermission 이것을 폐기한 후 새로고침을 통해 바로 /view.action 으로 간 경우이다.
				// 글목록에서 특정 글제목을 클릭하여 본 상태에서
                // 웹브라우저에서 새로고침(F5)을 클릭한 경우이다.
                // System.out.println("글목록에서 특정 글제목을 클릭하여 본 상태에서 웹브라우저에서 새로고침(F5)을 클릭한 경우");
				
				an = adminService.getView_no_increase_readCount(paraMap);
				// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
				
				// 또는 redirect 해주기 (예 : 버거킹 www.burgerking.co.kr 메뉴소개)
				/*
					mav.setViewName("redirect:/list.action");
					return mav;
				*/
				
				if(an == null) {
					mav.setViewName("redirect:/admin/announcement.lms");
					return mav;
				}
			}

			mav.addObject("an", an);
			
			// === #139. 이전글제목, 다음글제목 보기 === //
			mav.addObject("paraMap", paraMap);
			
			mav.setViewName("announcementView.admin");
			
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/admin/announcement.lms");
		}
		
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
