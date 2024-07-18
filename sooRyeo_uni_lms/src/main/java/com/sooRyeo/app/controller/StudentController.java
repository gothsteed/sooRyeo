package com.sooRyeo.app.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		String fk_course_seq = request.getParameter("fk_course_seq");		
		
		List<Map<String, String>> assignment_List = service.getassignment_List(fk_course_seq, userid);
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
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		String schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		
		// 스케쥴, 과제 join
		// 수업 - 내 강의 - 과제 - 상세내용1
		Map<String, Object> assignment_detail_1 = service.getassignment_detail_1(schedule_seq_assignment);
		
		// 과제, 과제제출 join
		// 수업 - 내 강의 - 과제 - 상세내용2
		Map<String, Object> assignment_detail_2 = service.getassignment_detail_2(schedule_seq_assignment, userid);
		
		
		mav.addObject("assignment_detail_1", assignment_detail_1);
		mav.addObject("assignment_detail_2", assignment_detail_2);
		mav.addObject("schedule_seq_assignment", schedule_seq_assignment);
		
		mav.setViewName("assignment_detail_List");
		
		return mav;
		
	} // end of public ModelAndView assignment_detail_List
	
	
	
	// 수업 - 내 강의 - 과제 - 상세내용 - 파일다운(교수꺼)
	@GetMapping("/downloadfile.lms")
	public void downloadfile(HttpServletRequest request, HttpServletResponse response ) {

		String schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		
		// 웹브라우저에 출력하기 시작
		response.setContentType("text/html; charset=UTF-8");	// 한글 깨짐 방지
		
		PrintWriter out = null;
		
		try {
			
			Integer.parseInt(schedule_seq_assignment);
			
			// 스케쥴, 과제 join
			// 수업 - 내 강의 - 과제 - 상세내용1
			Map<String, Object> assignment_detail_1 = service.getassignment_detail_1(schedule_seq_assignment);
			
			
			if(assignment_detail_1 == null || (assignment_detail_1 != null && assignment_detail_1.get("attatched_file") == null)) {
				
				out = response.getWriter();
				// out은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다.'); history.back();</script>");
	            return;
			}
			else {
				// 정상적으로 다운로드를 할 경우 
				
				String fileName = (String) assignment_detail_1.get("attatched_file");
				// System.out.println("fileName : " + fileName);
				// fileName : 2024071618011133184019490100.png
				
				String orgFilename = (String) assignment_detail_1.get("orgfilename");
				// System.out.println("orgFilename : " + orgFilename);
				// orgFilename : refrigerator_lg_normal_1.png
			
				HttpSession session_root = request.getSession();
				String root = session_root.getServletContext().getRealPath("/");
				
				// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
				// ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\
				
				String path = root + "resources" + File.separator + "files";
				// System.out.println("~~~ 확인용 path => " + path);
				// ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
				
				
				// file 다운로드 하기
				boolean flag = false;
				flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				
				if(!flag) {
					
						out = response.getWriter();
						
						out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다.'); history.back();</script>");
					
					
				} // end of if(flag)
				
			} // end of if_else
			
			
		} catch(NumberFormatException | IOException e) {
			
			try {
				out = response.getWriter();
				// out은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다.'); history.back();</script>");
				
			} catch (IOException e2) {
				e2.printStackTrace();
			}
			
		}
		
	} // end of public void download
	
	
	
	// 과제제출
	@ResponseBody
	@PostMapping(value="/addComment.lms", produces="text/plain;charset=UTF-8")
	public String addComment(HttpServletRequest request, AssignmentSubmitDTO asdto) {
		
		// 과제 제출에 첨부파일이 없는 경우
		int n = 0;
		
		try {
			
			n = service.addComment(asdto);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} // end of try_catch

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
	} // end of public String addComment
	
	
	
	// 제출한 과제 조회
	@ResponseBody
	@PostMapping(value="/readComment.lms", produces="text/plain;charset=UTF-8")
	public String readComment(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		String fk_schedule_seq_assignment = request.getParameter("fk_schedule_seq_assignment");
		
		
		Map<String, Object> assignment_show = service.getreadComment(fk_schedule_seq_assignment, userid);
		

		JSONObject jsonObj = new JSONObject();       
		
		if(assignment_show != null) {
		
			// System.out.println(assignment_show.get("assignment_submit_seq"));
			
			jsonObj.put("assignment_submit_seq", assignment_show.get("assignment_submit_seq"));  
			
			jsonObj.put("fk_student_id", assignment_show.get("fk_student_id")); 
			jsonObj.put("title", assignment_show.get("title"));          
			jsonObj.put("content", assignment_show.get("content"));     
			jsonObj.put("attached_file", assignment_show.get("attatched_file")); 
			jsonObj.put("submit_datetime", assignment_show.get("submit_datetime"));
		
		}
		else {
			jsonObj.put("assignment_submit_seq", "");
		}
		
		return jsonObj.toString();
		
	} // end of public String readComment
	
	
	
	// 파일첨부가 있는 과제 제출
	@ResponseBody
	@PostMapping(value="/addComment_withAttach.lms", produces="text/plain;charset=UTF-8")
	public String addComment_withAttach(AssignmentSubmitDTO asdto, MultipartHttpServletRequest mrequest, HttpServletRequest request) {
	
		// === 첨부파일 업로드 시작 === //
		MultipartFile attach = asdto.getAttach();
		
		// System.out.println(attach);
		// MultipartFile[field="attach", filename=2024년도 국가기술자격 검정 시행계획(대외 공고).pdf, contentType=application/pdf, size=466949]
		
		String newFileName = "";
		String originalFilename = "";
		
		if( !attach.isEmpty() ) {
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			// System.out.println("확인용 webapp 의 절대경로 => " + root); 
			// ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\
								
			String path = root+"resources"+File.separator+"files";
			// System.out.println("확인용 path => " + path);
			// ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
			
			byte[] bytes = null;
			
			try {
				bytes = attach.getBytes();
				
				originalFilename = attach.getOriginalFilename();
				// System.out.println("확인용 originalFilename => " + originalFilename); 
				// ~~~ 확인용 originalFilename => 2024년도 국가기술자격 검정 시행계획(대외 공고).pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// System.out.println("확인용 newFileName " + newFileName);
				// 확인용 newFileName 20240714220735250112916872200.pdf
				
				asdto.setAttatched_file(newFileName);
				
				asdto.setOrgfilename(originalFilename);
				
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}
		// === 첨부파일 업로드 끝  === //
		
		// 과제 제출에 첨부파일이 없는 경우
		int n = 0;
		
		try {
			
			n = service.addComment(asdto);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // end of try_catch

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
		
	} // end of public String addComment_withAttach
	
	
	
	
	// 파일첨부가 있는 과제제출에서 내 파일 다운로드 받기(학생)
	@GetMapping(value="/downloadComment.lms")
	public void downloadComment(HttpServletRequest request, HttpServletResponse response) {
		
		String assignment_submit_seq = request.getParameter("assignment_submit_seq");
		// 첨부파일이 있는 글번호
		
		// System.out.println("~~~ 확인용 assignment_submit_seq : " + assignment_submit_seq);
		// ~~~ 확인용 assignment_submit_seq : 30
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = null;
		
		try {
			Integer.parseInt(assignment_submit_seq);
			
			AssignmentSubmitDTO asdto = service.getCommentOne(assignment_submit_seq);
			
			if(asdto == null || (asdto != null && asdto.getAttatched_file() == null)) {
				
				out = response.getWriter();
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다.'); history.back();</script>");
	            return;
				
				
			}
			else {
				// 정상적으로 다운로드를 할 경우
				
				String fileName = asdto.getAttatched_file();
				// System.out.println("fileName : " + fileName);
				// fileName : 20240718152912628114596746500.png
				
				String orgFilename = asdto.getOrgfilename();
				// System.out.println("orgFilename : " + orgFilename);
				// orgFilename : 01.png
				
				HttpSession session = request.getSession(); 
				String root = session.getServletContext().getRealPath("/"); 
				// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
				// ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\
				
				String path = root + "resources" + File.separator + "files";
				// System.out.println("~~~ 확인용 path => " + path);
				// ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
				
				
				// ***** file 다운로드 하기 ***** //
	            boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도 
	            flag = fileManager.doFileDownload(fileName, orgFilename, path, response); 
	            // file 다운로드 성공 시 flag 는 true,
	            // file 다운로드 실패 시 flag 는 false 를 가진다.
	            
	            if(!flag) {
					// 다운로드가 실패한 경우 메시지를 띄워준다.
					out = response.getWriter();
					// out 은 웹브라우저에 기술하는 대상체라고 생각하자.

					out.println("<script type='text/javascript'>alert('파일 다운로드가 실패되었습니다.'); history.back();</script>");
	            }
				
			}
			
		} catch (IOException e) {
			
			try {
				out = response.getWriter();
				// out은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('파일 다운로드가 불가합니다.'); history.back();</script>");
				
			} catch (IOException e2) {
				e2.printStackTrace();
			}
			
		}
		
	} // end of public void requiredLogin_download

	
	
	
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
		
		int n = service.insert__schedule_consult(prof_id, title, content, start_date, end_date, userid);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n);
		
		return jsonobj.toString();
	}

	
	// 수업 - 내 강의 - 동영상 플레이
	@RequestMapping(value = "/student/classPlay.lms", method = RequestMethod.GET)
	public ModelAndView classPlay(HttpServletRequest request, ModelAndView mav) {
		
		String fk_course_seq = request.getParameter("course_seq");
		
		List<Lecture> lectureList_week = service.getlectureList_week(fk_course_seq);
		
		mav.addObject("lectureList_week", lectureList_week);
		
		mav.setViewName("classPlay");
		
		return mav;
	} // end of public String class_play()-------
	
}
