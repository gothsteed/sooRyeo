package com.sooRyeo.app.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
import com.sooRyeo.app.domain.AssignmentSubmit;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.AssignmentSubmitDTO;
import com.sooRyeo.app.dto.StudentDTO;
import com.sooRyeo.app.service.CourseService;
import com.sooRyeo.app.service.StudentService;

@Controller
@RequireLogin(type = {Student.class})
public class StudentController {
	
	@Autowired
	private StudentService service;

	@Autowired
	private StudentService studentservice;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private CourseService courseService;
	

	@RequestMapping(value = "/student/dashboard.lms", method = RequestMethod.GET)
	public String student() {

		return "student_Main";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	@RequestMapping(value = "/student/lectureList.lms", method = RequestMethod.GET)
	public String lectureList() {
		
		return "lectureList";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
	// 수업리스트 보여주기
	@GetMapping(value="/student/classList.lms")
	public String classList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Student loginuser = (Student)session.getAttribute("loginuser");
		
		int userid = loginuser.getStudent_id();
		
		List<Map<String, String>> mapList = service.classList(userid);
		
		request.setAttribute("mapList", mapList);

		return "classList";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
	
	
	// 내정보 보기
	@RequestMapping(value="/student/myInfo.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView myInfo(ModelAndView mav, HttpServletRequest request) {
		
		StudentDTO member_student = studentservice.getViewInfo(request);
		
		// System.out.println(member_student.getStatus());
		
		mav.addObject("member_student", member_student);
		mav.setViewName("myInfo");
		// /WEB-INF/views/student/{1}.jsp
		
		return mav;
		
	} // end of public ModelAndView myInfo
	
	
	// 비밀번호 중복
	@ResponseBody
	@PostMapping(value = "/student/pwdDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String pwdDuplicateCheck(HttpServletRequest request, StudentDTO student) {	
		
		JSONObject json = studentservice.pwdDuplicateCheck(request);						
		
		return json.toString();
	}

	
	// 전화번호 중복
	@ResponseBody
	@PostMapping(value = "/student/telDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String telDuplicateCheck(HttpServletRequest request, StudentDTO student) {		
		
		JSONObject json = studentservice.telDuplicateCheck(request);						
		
		return json.toString();
	}
	
	
	// 이메일 중복
	@ResponseBody
	@PostMapping(value = "/student/emailDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String emailDuplicateCheck(HttpServletRequest request, StudentDTO student) {	
		
		JSONObject json = studentservice.emailDuplicateCheck(request);						
		
		return json.toString();
	}
	
	
	// 학생 정보 수정
	@PostMapping(value = "/student/student_info_edit.lms")
	public ModelAndView professor_info_edit( ModelAndView mav, StudentDTO student, MultipartHttpServletRequest mrequest) {
		     
		
	      int n = studentservice.student_info_edit(student, mrequest);
      
	      if(n == 1) {
	    	  mav.addObject("message", "학생정보 수정을 성공하였습니다.");
	    	  mav.addObject("loc", mrequest.getContextPath()+"/student/dashboard.lms");
	    	  mav.setViewName("msg");
	      }
	      else {
	    	  mav.addObject("message", "학생정보 수정이 실패하였습니다.");
	    	  mav.addObject("loc", mrequest.getContextPath()+ "/student/myInfo.lms");
	    	  mav.setViewName("msg");
	      }
      
	      return mav;
	}
	


	
	// 수업  - 내 강의보기
	@GetMapping(value="/student/myLecture.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView myLecture(ModelAndView mav, HttpServletRequest request) {
		 
		String fk_course_seq = request.getParameter("course_seq");
		
		List<Lecture> lectureList = service.getlectureList(fk_course_seq);
		
		List<Professor> professor_info = service.select_prof_info(fk_course_seq);
		
		// 수업 - 이번주 강의보기
		List<Lecture> lectureList_week = service.getlectureList_week(fk_course_seq);
		
		mav.addObject("professor_info", professor_info);
		
		mav.addObject("lectureList", lectureList);
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.addObject("lectureList_week", lectureList_week);
		
		mav.setViewName("myLecture");

		return mav;
		
	} // end of public String myLecture
	
	
	
	// 수업 - 내 강의 - 과제
	@GetMapping(value="/student/assignment_List.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView assignment_List(ModelAndView mav, HttpServletRequest request) {
		
		String fk_course_seq = request.getParameter("fk_course_seq");		
		
		List<Map<String, String>> assignment_List = service.getassignment_List(fk_course_seq);
		mav.addObject("assignment_List", assignment_List);
		
		mav.setViewName("assignment_List");
		
		return mav;
		
	} // end of public ModelAndView assignment_List
		

	
	
	@GetMapping("/student/courseRegister.lms")
	public ModelAndView cousrseRegister(HttpServletRequest request, ModelAndView mav) {
	
		return studentservice.getCourseRegisterPage(request, mav);
		// /WEB-INF/views/student/{1}.jsp
	}
	
	@GetMapping(value = "/student/courseJSON.lms", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> cousrseREST(HttpServletRequest request) {
		return courseService.getCourseList(request);
	}
	
	@GetMapping(value = "/student/timetableJSON.lms", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> timeTableREST(HttpServletRequest request) {
		return courseService.getLoginStudentTimeTable(request);
	}
	
	
	@PostMapping(value = "/student/registerCourseREST.lms", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> registerCourseREST(HttpServletRequest request) {
		return courseService.registerCourse(request);
	}
	
	
	@PostMapping(value = "/student/dropCourseREST.lms", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> dropCourseREST(HttpServletRequest request) {
		return courseService.dropStudentCourse(request);
	}


	
	
	// 수업 - 내 강의 - 과제 - 상세내용
	@GetMapping(value="/student/assignment_detail_List.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView assignment_detail(ModelAndView mav, HttpServletRequest request) {
		
		String schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		
		Map<String, String> assignment_detail = service.getassignment_detail(schedule_seq_assignment);
		
		mav.addObject("assignment_detail", assignment_detail);
		mav.addObject("schedule_seq_assignment",schedule_seq_assignment);
		
		mav.setViewName("assignment_detail_List");
		
		return mav;
		
	} // end of public ModelAndView assignment_detail_List
	
	
	
	// 과제제출
	@ResponseBody
	@PostMapping(value="/addComment.lms", produces="text/plain;charset=UTF-8")
	public String addComment(HttpServletRequest request) {
		
		// 과제 제출에 첨부파일이 없는 경우
		int n = 0;
		
		try {
			
			String fk_schedule_seq_assignment = request.getParameter("fk_schedule_seq_assignment");
			String fk_student_id = request.getParameter("fk_student_id");
			String title = request.getParameter("title");	
			String content = request.getParameter("content");
		
			n = service.addComment(fk_schedule_seq_assignment, fk_student_id, title, content);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} // end of try_catch

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
	} // end of public String addComment
	
	
	
	// 과제제출  - schedule_seq_assignment 가져오기
	@ResponseBody
	@PostMapping(value="/selectSeq.lms", produces="text/plain;charset=UTF-8")
	public String selectSeq(HttpServletRequest request) {
		
		String schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		
		String schedule_seq  = service.selectSeq(schedule_seq_assignment);
		
		String result = "";
		
		if(schedule_seq == null) {
			result = "0";
		}
		else {
			result = "1";
		}
		
		// System.out.println("~~~ 확인용 result : " + result);
		
		JSONObject jsonobj = new JSONObject();
		
		jsonobj.put("result", result);
		
		return jsonobj.toString();
		
	} // end of public String selectSeq
	
	
	
	// 제출한 과제 조회
	@ResponseBody
	@PostMapping(value="/readComment.lms", produces="text/plain;charset=UTF-8")
	public String readComment(HttpServletRequest request) {
		
		String fk_schedule_seq_assignment = request.getParameter("fk_schedule_seq_assignment");
		
		List<AssignmentSubmit> submitList = service.getreadComment(fk_schedule_seq_assignment);
		
		JSONArray jsonArr = new JSONArray();
		
		if(submitList != null) {
			
			for(AssignmentSubmit adto : submitList) {
				
				JSONObject jsonObj = new JSONObject();       
				
				jsonObj.put("assignment_submit_seq", adto.getAssignment_submit_seq());            
				jsonObj.put("fk_student_id", adto.getFk_student_id()); 
				jsonObj.put("title", adto.getTitle());          
				jsonObj.put("content", adto.getContent());     
				jsonObj.put("attached_file", adto.getAttatched_file()); 
				jsonObj.put("submit_datetime", adto.getSubmit_datetime());
				
				jsonArr.put(jsonObj);
				
			}// end of for-----------------------
		}
		
		return jsonArr.toString();
		
	} // end of public String readComment
	
	
	
	// 파일첨부가 있는 댓글쓰기
	@ResponseBody
	@PostMapping(value="/addComment_withAttach.lms", produces="text/plain;charset=UTF-8")
	public String addComment_withAttach(AssignmentSubmitDTO asdto, MultipartHttpServletRequest mrequest, HttpServletRequest request) {
	
		String fk_schedule_seq_assignment = mrequest.getParameter("fk_schedule_seq_assignment");
		// System.out.println("확인용 fk_schedule_seq_assignment : " + fk_schedule_seq_assignment);
		// 확인용 fk_schedule_seq_assignment : 5
		
		// === 첨부파일 업로드 시작 === //
		MultipartFile attach = asdto.getAttach();
		
		// System.out.println(attach);
		// MultipartFile[field="attach", filename=2024년도 국가기술자격 검정 시행계획(대외 공고).pdf, contentType=application/pdf, size=466949]
		
		
		if( !attach.isEmpty() ) {
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			// System.out.println("확인용 webapp 의 절대경로 => " + root); 
			// ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\
								
			String path = root+"resources"+File.separator+"files";
			// System.out.println("확인용 path => " + path);
			// ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
			
			String newFileName = "";
			byte[] bytes = null;
			
			try {
				bytes = attach.getBytes();
				
				String originalFilename = attach.getOriginalFilename();
				// System.out.println("확인용 originalFilename => " + originalFilename); 
				// ~~~ 확인용 originalFilename => 2024년도 국가기술자격 검정 시행계획(대외 공고).pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// System.out.println("확인용 newFileName " + newFileName);
				// 확인용 newFileName 20240714220735250112916872200.pdf
				
				asdto.setAttatched_file(newFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}
		// === 첨부파일 업로드 끝  === //
		
		// 과제 제출에 첨부파일이 없는 경우
		int n = 0;
		
		try {
			
			fk_schedule_seq_assignment = request.getParameter("fk_schedule_seq_assignment");
			String fk_student_id = request.getParameter("fk_student_id");
			String title = request.getParameter("title");	
			String content = request.getParameter("content");
		
			n = service.addComment(fk_schedule_seq_assignment, fk_student_id, title, content);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // end of try_catch

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
		
	} // end of public String addComment_withAttach
	
	
	
	
	/* 파일첨부가 있는 댓글쓰기에서 파일 다운로드 받기
	@GetMapping(value="/downloadComment.action")
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
		
		String fk_schedule_seq_assignment = request.getParameter("fk_schedule_seq_assignment");
		// 첨부파일이 있는 글번호
		System.out.println("~~~ 확인용 fk_schedule_seq_assignment : " + fk_schedule_seq_assignment);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			
			Integer.parseInt(fk_schedule_seq_assignment);
			AssignmentSubmitDTO asdto = service.getCommentOne(fk_schedule_seq_assignment);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	} // end of public void requiredLogin_download
	*/
	
	
	
	@ResponseBody
	@PostMapping("/student/insert_schedule_consult.lms")
	public String insert_schedule_consult(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		String prof_id = request.getParameter("prof_id");
		String title =  request.getParameter("title");
		String content = request.getParameter("content");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		
		System.out.println("아 제발" + start_date);
		
		int n = service.insert__schedule_consult(prof_id, title, content, start_date, end_date, userid);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n);
		
		return jsonobj.toString();
	}

	
	// 수업 - 내 강의 - 동영상 플레이
	@RequestMapping(value = "/student/classPlay.lms", method = RequestMethod.GET)
	public String classPlay() {
		
		
		
		return "classPlay";
	} // end of public String class_play()-------
	
}
