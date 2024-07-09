package com.sooRyeo.app.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
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
import com.sooRyeo.app.common.MyUtil;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.service.ProfessorService;
import com.sooRyeo.app.service.StudentService;


@Controller
@RequireLogin(type = Professor.class)
public class ProfessorController {
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	// @Qualifier("boardService_imple") DAO는 하나이기 때문에 Qualifier를 통해 지정할 필요가 거의 없다.
	private ProfessorService service;
	
	@Autowired
	private StudentService Studentservice;
	
	
	
	@RequestMapping(value = "/professor/dashboard.lms")
	public ModelAndView professor_dashboard(ModelAndView mav) {// 대시보드 뷰단
		
		mav.setViewName("professor_dashboard.professor");
		
		return mav;
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
	public ModelAndView professor_info_edit( ModelAndView mav, Professor professor, MultipartHttpServletRequest mrequest) {// 교수 정보 수정
		     
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
	
	
	@GetMapping(value = "/professor/courseList.lms")  
	public ModelAndView professor_course(HttpServletRequest request, ModelAndView mav, Professor professor) {// 교수 진행 강의 목록
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		int prof_id = loginuser.getProf_id();
		
		ProfessorTimeTable timeTable = service.courseList(prof_id);
		
		List<Course> courseList = timeTable.getCourseList();
		
		if(courseList == null) {// 정보가 없다면
			  mav.addObject("message", "담당한 강의가 없습니다.");
	    	  mav.addObject("loc", request.getContextPath()+"/professor/dashboard.lms");
	    	  mav.setViewName("msg");
			return mav;
		}
		
		String goBackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("goBackURL", goBackURL);
		mav.addObject("courseList", courseList);
		mav.addObject("loginuser", loginuser);
		mav.setViewName("professor_courseList.professor");
		
		return mav;
	}
	
	
	@GetMapping(value = "/professor/courseDetail.lms")  
	public ModelAndView professor_courseDetail(HttpServletRequest request, ModelAndView mav) {// 교수 진행 강의 상세
				
		String fk_course_seq = request.getParameter("course_seq");
		
		// System.out.println("확인용 fk_course_seq : " + fk_course_seq);	
		
		List<Map<String, String>> studentList = service.studentList(fk_course_seq);
		
		mav.addObject("studentList", studentList);
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.setViewName("professor_courseDetail.professor");
		
		return mav;
	}
	
	
	@GetMapping(value = "/professor/paperAssignment.lms")  
	public ModelAndView professor_paperAssignment(HttpServletRequest request, ModelAndView mav) {// 교수 과제, 시험관리 페이지
		
		String fk_course_seq = request.getParameter("course_seq");
		System.out.println("확인용 fk_course_seq : " + fk_course_seq);
		
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.setViewName("professor_paperAssignment.professor");
		
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value = "/professor/paperAssignmentJson.lms")  
	public String professor_paperAssignmentJson(HttpServletRequest request) {// 과제, 시험정보 가져오기
		
		String fk_course_seq = request.getParameter("course_seq");
		
		// System.out.println("확인용 fk_course_seq : " + fk_course_seq);
		
		List<Map<String,String>> paperAssignment = service.paperAssignment(fk_course_seq);
		// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
		
        JSONArray jsonArr = new JSONArray();
        
        for(Map<String, String> map : paperAssignment) {
           
           JSONObject jsonObj = new JSONObject();
           jsonObj.put("row_num", map.get("row_num"));
           jsonObj.put("fk_course_seq", map.get("fk_course_seq"));
           jsonObj.put("content", map.get("content"));
           jsonObj.put("attatched_file", map.get("attatched_file"));
           jsonObj.put("schedule_seq_assignment", map.get("schedule_seq_assignment"));
           jsonObj.put("schedule_seq", map.get("schedule_seq"));
           jsonObj.put("title", map.get("title"));
           jsonObj.put("start_date", map.get("start_date"));
           jsonObj.put("end_date", map.get("end_date"));
           
           jsonArr.put(jsonObj);
           
        }// end of for--------------------------------
        
        System.out.println(jsonArr.toString());
        
        return jsonArr.toString();
		
	}
	
}
