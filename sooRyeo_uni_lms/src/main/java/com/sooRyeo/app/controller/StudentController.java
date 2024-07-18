package com.sooRyeo.app.controller;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.annotation.JsonAppend.Attr;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Schedule;
import com.sooRyeo.app.domain.Student;
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
		
		String fk_course_seq = request.getParameter("course_seq");		
		
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
	public ModelAndView assignment_detail_List(ModelAndView mav, HttpServletRequest request) {
		
		String schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		
		List<Map<String, String>> assignment_detail_List = service.getassignment_detail_List(schedule_seq_assignment);
		
		mav.addObject("assignment_detail_List", assignment_detail_List);
		
		mav.setViewName("assignment_detail_List");
		
		return mav;
		
	} // end of public ModelAndView assignment_detail_List
	
	
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
	@GetMapping("/student/classPlay.lms")
	public ModelAndView classPlay(HttpServletRequest request, ModelAndView mav) {
		
		String fk_course_seq = request.getParameter("course_seq");
		
		List<Lecture> lectureList_week = service.getlectureList_week(fk_course_seq);
		
		mav.addObject("lectureList_week", lectureList_week);
		
		mav.setViewName("classPlay");
		
		return mav;
	} // end of public String class_play()-------
	
	
	
	@GetMapping("/student/classPlay_One.lms")
	public ModelAndView classPlay_One(HttpServletRequest request, ModelAndView mav) {
		
		String lecture_seq = request.getParameter("lecture_seq");
		
		Map<String, String> classOne = service.classPlay_One(lecture_seq);
		
		mav.addObject("classOne", classOne);
		
		mav.addObject("lecture_seq", lecture_seq);
		
		mav.setViewName("classPlay_One");
		
		return mav;
	}
	
	
	
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
		String fk_lecture_seq = service.select_tbl_attendance(lecture_seq, userid);

		JSONObject jsonobj = new JSONObject();
		
		if(fk_lecture_seq == null) { // 처음 동영상을 재생한 경우
			int n = service.insert_tbl_attendance(play_time, lecture_seq, userid);
			jsonobj.put("n", n);
		}
		else {// 동영상 재생 이력이 있을경우 
			
			// play_time 컬럼과 lecture_time 컬럼을 비교
			int i = service.select_play_time_lecture_time(play_time, lecture_seq, userid);
			
			// System.out.println("확인용 입니다 => " + i);
			
			if(i > 0) { // 아직 출석인정 시간이 되지 않은 경우
				
				int n1 = service.update_tbl_attendance(play_time, lecture_seq, userid);
				jsonobj.put("n1", n1);
			}
			
			else { // 동영상재생페이지에 머무른 시간 - 동영상 시간  <= 0, 즉  출석을 완료한 경우
				
				int n1 = service.update_tbl_attendance(play_time, lecture_seq, userid);
				int n2 = service.update_tbl_attendance_isAttended(lecture_seq, userid);
				
				int n3 = n1*n2;
				jsonobj.put("n3", n3);
			}
			
		}
		
		System.out.println("~~ controller 에서 jsonObj 확인 => " + jsonobj.toString());
		return jsonobj.toString();
	}
	
}
