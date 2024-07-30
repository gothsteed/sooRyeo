package com.sooRyeo.app.controller; 

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import com.sooRyeo.app.service.ScheduleService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


import com.sooRyeo.app.aop.NoView;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.domain.AssignmentSubmit;
import com.sooRyeo.app.domain.Attendance;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.common.MyUtil;
import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.domain.StudentTimeTable;
import com.sooRyeo.app.domain.TodayLecture;
import com.sooRyeo.app.dto.AssignmentSubmitDTO;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.dto.StudentDTO;
import com.sooRyeo.app.service.CourseService;
import com.sooRyeo.app.service.StudentService;

@Controller
@RequireLogin(type = {Student.class})
public class StudentController {

	@Autowired
	private StudentService studentservice;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private CourseService courseService;

	@Autowired
	private ScheduleService scheduleService;
	

	@RequestMapping(value = "/student/dashboard.lms", method = RequestMethod.GET)
	public ModelAndView student(ModelAndView mav, HttpServletRequest request) {

		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int student_id = loginuser.getStudent_id();
		
		// 오늘의 수업만을 불러오는 메소드
		List<TodayLecture> today_lec = studentservice.getToday_lec(student_id);
		
		int currentPage = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		
		String goBackURL = MyUtil.getCurrentURL(request);
		
		// 학사공지사항을 전부 불러오는 메소드
		Pager<Announcement> announcementList =  studentservice.getAnnouncement(currentPage);
		
		
		// 하이차트 - 학생이 듣고있는 수업명 가져오는 메소드
		List<Curriculum> Curriculum_nameList = studentservice.Curriculum_nameList(student_id);
		mav.addObject("Curriculum_nameList", Curriculum_nameList);
		
		
		
		mav.addObject("announcementList", announcementList.getObjectList());
		mav.addObject("currentPage", announcementList.getPageNumber());
		mav.addObject("perPageSize", announcementList.getPerPageSize());
		mav.addObject("goBackURL","/board/announcement.lms");
		mav.addObject("today_lec",today_lec);
		mav.setViewName("student_Main");
		
		return mav;
	}
	
	@RequestMapping(value = "/student/lectureList.lms", method = RequestMethod.GET)
	public String lectureList() {
		
		return "lectureList";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
	// 수업리스트 보여주기
	@GetMapping(value="/student/classList.lms")
	public ModelAndView classList(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		
		Student loginuser = (Student)session.getAttribute("loginuser");
		
		int userid = loginuser.getStudent_id();
		
		StudentTimeTable timeTable = studentservice.classList(userid);
		
		List<Course> mapList = timeTable.getCourseList();
	


		mav.addObject("mapList", mapList);
		mav.setViewName("classList");
		
		return mav;
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
	
	
	// 내정보 보기
	@RequestMapping(value="/student/myInfo.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView myInfo(ModelAndView mav, HttpServletRequest request) {
		
		StudentDTO member_student = studentservice.getViewInfo(request);
		
		// System.out.println(member_student.getStatus());
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int student_id = loginuser.getStudent_id();
		
		// 현재 학적변경을 신청한 상태인지 알아오는 메소드
		String application_status = studentservice.getApplication_status(student_id);
		if(application_status == null) {
			application_status = "0";
		}
		
		mav.addObject("application_status", application_status);
		mav.addObject("member_student", member_student);
		mav.setViewName("myInfo");
		
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
		
/*
		List<Lecture> lectureList = studentservice.getlectureList(fk_course_seq);
		
		List<Professor> professor_info = studentservice.select_prof_info(fk_course_seq);
		
		// 수업 - 이번주 강의보기
		List<Lecture> lectureList_week = studentservice.getlectureList_week(fk_course_seq);
		
		mav.addObject("professor_info", professor_info);
		
		mav.addObject("lectureList", lectureList);
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.addObject("lectureList_week", lectureList_week);
		
		mav.setViewName("myLecture");
*/

		//return mav;

		return studentservice.getCourseLecturePage(request, mav, fk_course_seq);
		
	} // end of public String myLecture
	
	
	
	// 수업 - 내 강의 - 과제
	@GetMapping(value="/student/assignment_List.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView assignment_List(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		String fk_course_seq = request.getParameter("fk_course_seq");		
		
		List<Map<String, String>> assignment_List = studentservice.getassignment_List(fk_course_seq, userid);
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
		Map<String, Object> assignment_detail_1 = studentservice.getassignment_detail_1(schedule_seq_assignment);
		
		// 과제, 과제제출 join
		// 수업 - 내 강의 - 과제 - 상세내용2
		Map<String, Object> assignment_detail_2 = studentservice.getassignment_detail_2(schedule_seq_assignment, userid);
		
		
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
			Map<String, Object> assignment_detail_1 = studentservice.getassignment_detail_1(schedule_seq_assignment);
			
			
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
			
			n = studentservice.addComment(asdto);
			
			
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
		
		
		Map<String, Object> assignment_show = studentservice.getreadComment(fk_schedule_seq_assignment, userid);
		

		JSONObject jsonObj = new JSONObject();       
		
		if(assignment_show != null) {
		
			// System.out.println(assignment_show.get("assignment_submit_seq"));
			
			jsonObj.put("assignment_submit_seq", assignment_show.get("assignment_submit_seq"));  
			
			jsonObj.put("fk_student_id", assignment_show.get("fk_student_id")); 
			jsonObj.put("title", assignment_show.get("title"));          
			jsonObj.put("content", assignment_show.get("content"));     
			jsonObj.put("attached_file", assignment_show.get("attatched_file"));

			Date date = ((Date) assignment_show.get("submit_datetime"));
			LocalDateTime localDateTime = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();


			jsonObj.put("submit_datetime", localDateTime);
		
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
			
			n = studentservice.addComment(asdto);
			
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
			
			AssignmentSubmitDTO asdto = studentservice.getCommentOne(assignment_submit_seq);
			
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
		
		int n = studentservice.insert__schedule_consult(prof_id, title, content, start_date, end_date, userid);
		
		JSONObject jsonobj  = new JSONObject();
		jsonobj.put("result", n);
		
		return jsonobj.toString();
	}

	
	// 수업 - 내 강의 - 동영상 플레이
	@GetMapping("/student/classPlay.lms")
	public ModelAndView classPlay(HttpServletRequest request, ModelAndView mav) {
		
		String fk_course_seq = request.getParameter("course_seq");
		
		List<Lecture> lectureList_week = studentservice.getlectureList_week(fk_course_seq);
		
		mav.addObject("lectureList_week", lectureList_week);
		
		mav.setViewName("classPlay");
		
		return mav;
	} // end of public String class_play()-------
	
	
	
	@GetMapping("/student/classPlay_One.lms")
	public ModelAndView classPlay_One(HttpServletRequest request, ModelAndView mav) {
		
		String lecture_seq = request.getParameter("lecture_seq");
		
		Map<String, String> classOne = studentservice.classPlay_One(lecture_seq);
		
		mav.addObject("classOne", classOne);
		
		mav.addObject("lecture_seq", lecture_seq);
		
		mav.setViewName("classPlay_One");

		return mav;
	}	


	// 메인 - 사이드바 - 성적 - 통계
	@GetMapping("/student/Statistics.lms")
	public ModelAndView student_chart(HttpServletRequest request, ModelAndView mav) {
		
		int department_seq = Integer.parseInt(request.getParameter("department_seq"));
		System.out.println("확인용 department_seq : " + department_seq);
		
		mav.addObject("department_seq", department_seq);
		mav.setViewName("chart/student_chart");
       return mav;
	}
	
	
	// === #239. 차트그리기(Ajax) 학생 수강과목 가져와서 학점 계산하기 ==== //
	@ResponseBody
	@GetMapping(value="/student/chart/credit.lms", produces="text/plain;charset=UTF-8")  
	public String student_chart_credit(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		Student loginuser = (Student)session.getAttribute("loginuser");
		
		int student_id = loginuser.getStudent_id();
		
		int department_seq = Integer.parseInt(request.getParameter("department_seq"));
		
		return studentservice.student_chart_credit(student_id, department_seq);
	}
	
	
	
	// 메인 - 사이드바  - 수업  - 출석현황
	@GetMapping(value="/student/attendance.lms" , produces="text/plain;charset=UTF-8")
	public String attendance(HttpServletRequest request,
							 @RequestParam(defaultValue = "") String name) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		// 전체 출석현황 보기
		List<Map<String, Object>> attendanceList = studentservice.attendanceList(userid, name);

		// 검색-수업명 가져오기
		List<Curriculum> lectureList = studentservice.lectureList();
		
		request.setAttribute("attendanceList", attendanceList);
		request.setAttribute("lectureList", lectureList);
		
		return "attendance";
		
	} // end of public String attendance
	
	
	// 졸업 신청
	@GetMapping(value = "/student/application_graduation.lms")
	public ModelAndView application_graduation( ModelAndView mav, StudentDTO student, HttpServletRequest request) {
		     
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int student_id = loginuser.getStudent_id();
		int grade = loginuser.getGrade();
		
		String application_status = studentservice.getApplication_status(student_id);
		if(application_status != null) {
			mav.addObject("message", "이미 승인 대기중인 신청이 있습니다.");
      	    mav.addObject("loc", request.getContextPath()+ "/student/myInfo.lms");
      	    mav.setViewName("msg");
      	    
      	    return mav;
		}
		
		// 이수한 학점이 몇점인지 알아오는 메소드
	    int credit_point = studentservice.credit_point(student_id);
	    
        if(credit_point >= 10 && grade == 4) {
          // 학적변경테이블(tbl_student_status_change)에 졸업신청을 insert 하는 메소드 
          int status_num = 3;
        	
          int n = studentservice.application_status_change(student_id, status_num);
          if(n == 1) {
        	  mav.addObject("message", "졸업 신청되었습니다.");
        	  mav.addObject("loc", request.getContextPath()+"/student/myInfo.lms");
        	  mav.setViewName("msg");
          }
        }
        else {
      	  mav.addObject("message", "졸업 요건이 충족되지 않았습니다.");
      	  mav.addObject("loc", request.getContextPath()+ "/student/myInfo.lms");
      	  mav.setViewName("msg");
        }
        
        return mav;
	}
	
	// 검색하기 클릭 시
	@ResponseBody
	@GetMapping(value="/student/attendanceListJSON.lms", produces="text/plain;charset=UTF-8")
	public String attendanceListJSON(HttpServletRequest request,
									 @RequestParam(defaultValue = "") String name) {
	
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		List<Map<String, Object>> attendanceList = studentservice.attendanceList(userid, name);
		
		request.setAttribute("attendanceList", attendanceList);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, Object> map : attendanceList) {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("fk_student_id", map.get("fk_student_id"));
			jsonObj.put("name", map.get("name"));
			jsonObj.put("lecture_title", map.get("lecture_title"));
			jsonObj.put("attended_date", map.get("attended_date"));
			
			jsonArr.put(jsonObj);
		} // end of for
		
		// System.out.println(jsonArr.toString());
		
		return jsonArr.toString();
		
	} // end of public String attendanceListJSON
	
	
	
	// 복학 신청
	@GetMapping(value = "/student/application_status.lms")
	public ModelAndView application_status(  HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int student_id = loginuser.getStudent_id();
		
		String application_status = studentservice.getApplication_status(student_id);
		if(application_status != null) {
			mav.addObject("message", "이미 승인 대기중인 신청이 있습니다.");
      	    mav.addObject("loc", request.getContextPath()+ "/student/myInfo.lms");
      	    mav.setViewName("msg");
      	    
      	    return mav;
		}
		
		int status_num = Integer.parseInt(request.getParameter("num"));
		
		// 학적변경테이블(tbl_student_status_change)에 학적변경신청을 insert 하는 메소드 
		int n = studentservice.application_status_change(student_id, status_num);
		
		if(n == 1) {
			if(status_num == 1) {
				mav.addObject("message", "복학 신청되었습니다.");
			}
			if(status_num == 2) {
				mav.addObject("message", "휴학 신청되었습니다.");
			}
			if(status_num == 4) {
				mav.addObject("message", "자퇴 신청되었습니다.");
			}
			mav.addObject("loc", request.getContextPath()+"/student/myInfo.lms");
			mav.setViewName("msg");
		}
		else {
			if(status_num == 1) {
				mav.addObject("message", "복학 신청이 실패되었습니다.");
			}
			if(status_num == 2) {
				mav.addObject("message", "휴학 신청이 실패되었습니다.");
			}
			if(status_num == 4) {
				mav.addObject("message", "자퇴 신청이 실패되었습니다.");
			}
			mav.addObject("loc", request.getContextPath()+ "/student/myInfo.lms");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/student/chatting.lms", method = RequestMethod.GET)
	public String chatting() {

		return "chatting";
		// /WEB-INF/views/student/{1}.jsp
	}
	
	
	
	// 학생 대쉬보드 - 수강중인 과목 출석률 
	@ResponseBody
	@GetMapping(value="/student/myAttendance_byCategoryJSON.lms", produces="text/plain;charset=UTF-8")
	public String myAttendance_byCategoryJSON(HttpServletRequest request, HttpServletResponse response,
											  @RequestParam(defaultValue = "") String name) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int student_id = loginuser.getStudent_id();
		
		
		// 하이차트 - 출석률
		Map<String, Object> myAttendance_byCategoryJSON = studentservice.myAttendance_byCategoryJSON(student_id, name);
		
		
		JSONObject jsonObj = new JSONObject();
		
		if(myAttendance_byCategoryJSON != null) {
			
			jsonObj.put("name", myAttendance_byCategoryJSON.get("name"));
			jsonObj.put("attendance_rate", myAttendance_byCategoryJSON.get("attendance_rate"));
			
		}
		
		return jsonObj.toString();
		
	} // end of public String myAttendance_byCategoryJSON

	
	
	
	// 학생 - 성적 취득현황
	@GetMapping(value = "/student/Acquisition_status.lms", produces="text/plain;charset=UTF-8")
	public String Acquisition_status(HttpServletRequest request) {

		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int student_id = loginuser.getStudent_id();
		
		List<Map<String, Object>> Acquisition_status = studentservice.Acquisition_status(student_id);
		
		request.setAttribute("Acquisition_status", Acquisition_status);
		
		return "Acquisition_status";
		
	} // end of public String Acquisition_status
	
	
	
	// 학생 - 성적 취득현황 JSON
	@ResponseBody
	@PostMapping(value = "/student/Acquisition_status_JSON.lms", produces="text/plain;charset=UTF-8")
	public String Acquisition_status_JSON(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int student_id = loginuser.getStudent_id();
		
		String semester = request.getParameter("semester");
		
		// System.out.println("확인용 semester : " + semester);
		// 확인용 semester : 2024-07
		
		List<Map<String, Object>> Acquisition_status_JSON = null;
		
		try {

			Acquisition_status_JSON = studentservice.Acquisition_status_JSON(semester, student_id);
			
		} catch (Exception e) {
			
			JSONArray jsonArr = new JSONArray();
			return jsonArr.toString();
			
		}
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, Object> map : Acquisition_status_JSON) {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("student_id", map.get("student_id"));
			jsonObj.put("name", map.get("name"));
			jsonObj.put("semester_date", map.get("semester_date"));
			jsonObj.put("score", map.get("score"));
			jsonObj.put("mark", map.get("mark"));
			
			jsonArr.put(jsonObj);
			
		} // end of for
		
		// System.out.println(jsonArr.toString());
		// [{"score":"100","name":"국어학개론","semester_date":"2024년 2학기","mark":"3.5"}] 여기까지함
		
		return jsonArr.toString();
		
	} // end of public String Acquisition_status_JSON
	
	
	
	
	
	
	
	
	
	
	// 영상재생화면에 내가 머물렀던 시간을 이용해 출석체크 하기
	@ResponseBody
	@PostMapping("/student/classPlay_time.lms")
	public String classPlay_time(HttpServletRequest request) {
		
		String play_time = request.getParameter("play_time");
		String lecture_seq = request.getParameter("lecture_seq");

		HttpSession session = request.getSession();
		Student loginuser = (Student)session.getAttribute("loginuser");
		int userid = loginuser.getStudent_id();
		
		// 출석 테이블에 내가 수강한 수업이 insert 되어진 값이 있는지 알아오기 위함
		String fk_lecture_seq = studentservice.select_tbl_attendance(lecture_seq, userid);

		JSONObject jsonobj = new JSONObject();
		
		if(fk_lecture_seq == null) { // 처음 동영상을 재생한 경우
			
			int n = studentservice.insert_tbl_attendance(play_time, lecture_seq, userid);
			jsonobj.put("n", n);
		}
		else { // 동영상 재생 이력이 있을경우 
			
			// play_time 컬럼과 lecture_time 컬럼을 비교
			int i = studentservice.select_play_time_lecture_time(play_time, lecture_seq, userid);
			
			System.out.println("확인용 입니다 => " + i);
			
			if(i > 0) { // 아직 출석인정 시간이 되지 않은 경우
				
				int n1 = studentservice.update_tbl_attendance(play_time, lecture_seq, userid);
				jsonobj.put("n1", n1);
			}
			
			else { // 동영상재생페이지에 머무른 시간 - 동영상 시간  <= 0, 즉  출석을 완료한 경우
				
				int n1 = studentservice.update_tbl_attendance(play_time, lecture_seq, userid);
				int n2 = studentservice.update_tbl_attendance_isAttended(lecture_seq, userid);
				
				int n3 = n1*n2;
				jsonobj.put("n3", n3);
			}
		}
		
		// System.out.println("~~ controller 에서 jsonObj 확인 => " + jsonobj.toString());
		return jsonobj.toString();
	}

	
	@GetMapping("/student/test.lms")
	public String test() {
		
		return "test";
		
	} // end of public String attendance
	
	
	

	@GetMapping("/student/consult.lms")
	public ModelAndView getConsultPage(HttpServletRequest request, ModelAndView mav) {
		return scheduleService.getStudentConsultPage(request, mav);
	}

}
