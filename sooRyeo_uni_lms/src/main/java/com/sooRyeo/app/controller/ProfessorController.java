package com.sooRyeo.app.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sooRyeo.app.domain.*;
import com.sooRyeo.app.dto.LectureUploadDto;
import com.sooRyeo.app.mongo.entity.StudentAnswer;
import com.sooRyeo.app.service.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.common.MyUtil;
import com.sooRyeo.app.dto.AssignScheInsertDTO;


@Controller
@RequireLogin(type = {Professor.class})
public class ProfessorController {
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	// @Qualifier("boardService_imple") DAO는 하나이기 때문에 Qualifier를 통해 지정할 필요가 거의 없다.
	private ProfessorService professorService;
	
	@Autowired
	private StudentService studentService;

	@Autowired
	private LectureService lectureService;

	@Autowired
	private ScheduleService scheduleService;

	@Autowired
	private ExamService examService;

	@Autowired
	private FileManager fileManager;
	
	
	@RequestMapping(value = "/professor/dashboard.lms", method = RequestMethod.GET)
	public ModelAndView professor(ModelAndView mav, HttpServletRequest request) {// 대시보드 뷰단
		
		int currentPage = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		
		String goBackURL = MyUtil.getCurrentURL(request);
		
		// 학사공지사항을 전부 불러오는 메소드
		Pager<Announcement> announcementList =  professorService.getAnnouncement(currentPage);

		mav.addObject("prof_id", ((Professor) request.getSession().getAttribute("loginuser")).getProf_id());
		mav.addObject("announcementList", announcementList.getObjectList());
		mav.addObject("currentPage", announcementList.getPageNumber());
		mav.addObject("perPageSize", announcementList.getPerPageSize());
		mav.addObject("goBackURL","/board/announcement.lms");
		
		mav.setViewName("professor_dashboard");
		
		return mav;
	}
	
	
	@RequestMapping(value = "/professor/request.lms", method = RequestMethod.GET)
	public String professor_request() {// 교수 강의신청 뷰단

		return "professor_request";
	}
	
	
	@GetMapping("/professor/info.lms")
	public ModelAndView professor_info(HttpServletRequest request, ModelAndView mav, Professor professor) {// 교수 내 정보 뷰단
			
		professor = professorService.getInfo(request);
		
		// System.out.println("확인용 professor name : " + professor.getName());
		
		if(professor == null) {
			mav.setViewName("redirect:/professor/dashboard");
			return mav;
		}
		
		mav.addObject("professor", professor);
		mav.setViewName("professor_info");
		
		return mav;	
	}
	
	
	@ResponseBody
	@PostMapping(value = "/professor/pwdDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String pwdDuplicateCheck(HttpServletRequest request, Professor professor) {// 교수 비밀번호 중복확인		
		
		JSONObject json = professorService.pwdDuplicateCheck(request);
		
		return json.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value = "/professor/telDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String telDuplicateCheck(HttpServletRequest request, Professor professor) {// 교수 전화번호 중복확인		
		
		JSONObject json = professorService.telDuplicateCheck(request);
		
		return json.toString();
	}
	
	
	@ResponseBody
	@PostMapping(value = "/professor/emailDuplicateCheck.lms", produces="text/plain;charset=UTF-8")
	public String emailDuplicateCheck(HttpServletRequest request, Professor professor) {// 교수 전화번호 중복확인		
		
		JSONObject json = professorService.emailDuplicateCheck(request);
		
		return json.toString();
	}
	
	
	@PostMapping(value = "/professor/professor_info_edit.lms")
	public ModelAndView professor_info_edit( ModelAndView mav, Professor professor, MultipartHttpServletRequest mrequest) {// 교수 정보 수정
		     
	      int n = professorService.professor_info_edit(professor, mrequest);
	      
	      if(n == 1) {
	    	  mav.addObject("message", "교수정보 수정을 성공하였습니다.");
	    	  mav.addObject("loc", mrequest.getContextPath()+"/professor/dashboard");
	    	  mav.setViewName("msg");
	      }
	      else {
	    	  mav.addObject("message", "교수정보 수정이 실패하였습니다.");
	    	  mav.addObject("loc", mrequest.getContextPath()+ "/professor/info");
	    	  mav.setViewName("msg");
	      }
      
	      return mav;
	}
	
	
	@GetMapping(value = "/professor/courseList.lms")  
	public ModelAndView professor_course(HttpServletRequest request, ModelAndView mav, Professor professor) {// 교수 진행 강의 목록
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		int prof_id = loginuser.getProf_id();
		
		ProfessorTimeTable timeTable = professorService.courseList(prof_id);
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
		mav.setViewName("professor_courseList");
		
		return mav;
	}
	
	
	@GetMapping(value = "/professor/courseDetail.lms")  
	public ModelAndView professor_courseDetail(HttpServletRequest request, ModelAndView mav) {// 교수 진행 강의 상세
				
		String fk_course_seq = request.getParameter("course_seq");
		
		// System.out.println("확인용 fk_course_seq : " + fk_course_seq);	
		
		// List<Map<String, String>> studentList = service.studentList(fk_course_seq);
		
		int currentPage = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		
		Pager<Map<String, String>> studentList = professorService.studentList(fk_course_seq, currentPage);
		List<Lecture> lectureList = studentService.getlectureList(fk_course_seq);

		mav.addObject("fk_course_seq", fk_course_seq);
		
		mav.addObject("studentList", studentList.getObjectList());
		mav.addObject("currentPage", studentList.getPageNumber());
		mav.addObject("perPageSize", studentList.getPerPageSize());
		mav.addObject("pageBar", studentList.makePageBar(request.getContextPath() + "/professor/courseDetail.lms", "course_seq="+fk_course_seq));
		mav.addObject("lectureList", lectureList);

		mav.setViewName("professor_courseDetail");
		
		return mav;
	}
	
	
	@GetMapping(value = "/professor/assignment.lms")  
	public ModelAndView professor_paperAssignment(HttpServletRequest request, ModelAndView mav) {// 교수 과제관리 페이지
		
		String fk_course_seq = request.getParameter("course_seq");
		// System.out.println("확인용2 fk_course_seq : " + fk_course_seq);
		
		String goBackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("goBackURL", goBackURL);
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.setViewName("professor_assignment");
		
		return mav;
	}
	
	
	@ResponseBody
	@GetMapping(value = "/professor/assignmentJson.lms", produces = "text/plain;charset=UTF-8")  
	public String professor_paperAssignmentJson(HttpServletRequest request) {// 과제 테이블에 띄우기
		
		String fk_course_seq = request.getParameter("course_seq");
		
		SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd");
		
		// System.out.println("확인용 fk_course_seq : " + fk_course_seq);
		
		List<Map<String,String>> paperAssignment = professorService.paperAssignment(fk_course_seq);
		// 과제 목록 리스트로 담아오기
		
        JSONArray jsonArr = new JSONArray();
        
        for(Map<String, String> map : paperAssignment) {
           
           JSONObject jsonObj = new JSONObject();
           jsonObj.put("row_num", map.get("row_num"));
           jsonObj.put("fk_course_seq", map.get("fk_course_seq"));
           jsonObj.put("content", map.get("content"));
           jsonObj.put("attatched_file", map.get("attatched_file"));
           jsonObj.put("orgfilename", map.get("orgfilename"));
           jsonObj.put("schedule_seq_assignment", map.get("schedule_seq_assignment"));
           jsonObj.put("schedule_seq", map.get("schedule_seq"));
           jsonObj.put("title", map.get("title"));
           jsonObj.put("start_date", sdfmt.format(map.get("start_date")));
           jsonObj.put("end_date", sdfmt.format(map.get("end_date")));
           
           jsonArr.put(jsonObj);
           
        }// end of for--------------------------------
        
        // System.out.println(jsonArr.toString());
        
        return jsonArr.toString();
		
	}
	
	
	@GetMapping("/professor/assign_enroll.lms")
	public ModelAndView professor_assign_enroll(ModelAndView mav, HttpServletRequest request){// 과제 등록하기
		
		String fk_course_seq = request.getParameter("course_seq");
		String goBackURL = request.getParameter("goBackURL");
		
		//System.out.println("확인용 goBackURL : " + goBackURL);
		//System.out.println("확인용 fk_course_seq : " + fk_course_seq);
		
		mav.addObject("goBackURL", goBackURL);
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.setViewName("professor_assign_enroll");
		return mav;
	}
	
	
	@PostMapping("/professor/assign_enroll_end.lms")
	public ModelAndView professor_assign_enroll_end(ModelAndView mav, AssignScheInsertDTO dto, MultipartHttpServletRequest mrequest) {// 스케쥴, 과제 테이블 인풋 후 목록리다이렉트
		
		String fk_course_seq = mrequest.getParameter("fk_course_seq");
		//System.out.println("확인용 fk_course_seq : " + fk_course_seq);
	    
		dto.setTitle(mrequest.getParameter("title"));    
	    //System.out.println("확인용 제목 : " + dto.getTitle());
	    
	    dto.setStartDate(mrequest.getParameter("startdate"));
	    dto.setEndDate(mrequest.getParameter("enddate"));
	    dto.setContent(mrequest.getParameter("content"));

	    MultipartFile attach = dto.getAttach();

	    if (attach != null && !attach.isEmpty()) {
	        HttpSession session = mrequest.getSession();
	        String root = session.getServletContext().getRealPath("/");
	        String path = root + "resources" + File.separator + "files";

	        String newFileName = "";
	        byte[] bytes = null;
		     // 첨부 파일의 내용물을 담은 것
	        try {
	            bytes = attach.getBytes();
	            String originalFilename = attach.getOriginalFilename();
	            newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
	            
	            System.out.println("확인용 newFileName " + newFileName);
	            
	            dto.setAttatched_file(newFileName); // 업로드된 파일 이름 설정
	            dto.setOrgfilename(originalFilename); // 원래 파일 이름 설정
	            
	        } catch (Exception e) {
	        	dto.setAttatched_file(newFileName); // 첨부파일이 없을 경우 ""	        	
	        }
	    }

	    int n = professorService.insert_tbl_schedule(dto, fk_course_seq);

	    if (n != 1) {
	        mav.addObject("message", "과제 등록을 실패하였습니다.");
	        mav.addObject("loc", "javascript:history.back()");
	        mav.setViewName("msg");
	    } else {
	        mav.addObject("message", "과제 등록을 성공했습니다.");
	        mav.addObject("loc", mrequest.getContextPath() + "/professor/assignment.lms?course_seq=" + fk_course_seq);
	        mav.setViewName("msg");
	    }

	    return mav;
	}
	
	
	@PostMapping("/professor/assignmentDetail.lms")
	public ModelAndView professor_assign_view(ModelAndView mav, HttpServletRequest request) {// 교수 과제상세 페이지
		
		String fk_course_seq = "";
		String goBackURL = "";
		String schedule_seq_assignment = "";
		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		// redirect 되어서 넘어온 데이터가 있는지 꺼내어 와본다.		
		
		if(inputFlashMap != null) { // redirect 되어서 넘어온 데이터가 있다면
			
			@SuppressWarnings("unchecked")
			Map<String, String> redirect_map = (Map<String, String>)inputFlashMap.get("redirect_map");			
			// "키" 값을 주어서 redirect 되어서 넘어온 데이터를 꺼내어 온다. 
			// "키" 값을 주어서 redirect 되어서 넘어온 데이터의 값은 Map<String, String> 이므로 Map<String, String> 으로 casting 해준다.
  
            // System.out.println("~~~ 확인용 seq : " + redirect_map.get("seq"));
			fk_course_seq = redirect_map.get("fk_course_seq");
			goBackURL = redirect_map.get("goBackURL"); 
		}
		///////////////////////////////////////////////////////////////////////
		else { // redirect 되어서 넘어온 데이터가 없다면
			// == 조회하고자 하는 과제번호 받아오기 ==
	           	
			fk_course_seq = request.getParameter("course_seq");
			
			// #134. 특정글을 조회한 후 "검색된결과목록보기" 버튼을 클릭했을 때 돌아갈 페이지를 만들기 위함.  
			goBackURL = request.getParameter("goBackURL");
			// System.out.println("~~~ 확인용(view.action) goBackURL : " + goBackURL);
			/* 
			 	잘못된 방식(get 방식 일 경우 & 앞에서 데이터값이 끊기기 때문이다.)
			 	~~~ 확인용(view.action) goBackURL : /list.action?searchType=subject
			  	올바른 방식(post 방식 일 경우)
			  	~~~ 확인용(view.action) goBackURL : /list.action?searchType=subject&searchWord=%EC%A0%95%ED%99%94&currentShowPageNo=3
			 */
			
			// >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. <<< 시작  // 
			schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		}
		
		mav.addObject("goBackURL", goBackURL); // 과제 관리목록쪽 url
		
		try {
			
			HttpSession session = request.getSession();
			Professor loginuser = (Professor)session.getAttribute("loginuser");
			
			String login_userid = null;
			if(loginuser != null) {
				login_userid = String.valueOf(loginuser.getProf_id());
				// login_userid 는 로그인 되어진 사용자의 userid
			}
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_course_seq", fk_course_seq);
			paraMap.put("login_userid", login_userid);
			paraMap.put("schedule_seq_assignment", schedule_seq_assignment);
			
			System.out.println("확인용 fk_course_seq :" + fk_course_seq);
			System.out.println("schedule_seq_assignment :" + schedule_seq_assignment);
			
			AssignJoinSchedule assign_view = professorService.assign_view(paraMap);
			
			String content = assign_view.getAssignment().getContent();
			System.out.println("확인용 content : " + content);
			
			mav.addObject("assign_view", assign_view);
			mav.setViewName("professor_assignDetail");
			
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/professor/assignment.lms");
		}
				
		return mav; 
	}
	
	
	@PostMapping("/professor/assignmentDelete.lms")
	public ModelAndView professor_assignmentDelete(ModelAndView mav, MultipartHttpServletRequest mrequest) {// 스케쥴, 과제 테이블 인풋 후 목록리다이렉트
		
		String schedule_seq_assignment = mrequest.getParameter("schedule_seq_assignment");			 
		String goBackURL = mrequest.getParameter("goBackURL");
		
		System.out.println("확인용 schedule_seq_assignment :" + schedule_seq_assignment);
		System.out.println("확인용 goBackURL :" + goBackURL);
		
	    int n = professorService.assignmentDelete(schedule_seq_assignment, mrequest);
		
	    if (n != 1) {
	        mav.addObject("message", "과제를 삭제할 수 없습니다.");
	        mav.addObject("loc", "javascript:history.back()");
	        mav.setViewName("msg");
	    } else {
	        mav.addObject("message", "과제가 삭제되었습니다.");
	        mav.addObject("loc", mrequest.getContextPath() + goBackURL);
	        mav.setViewName("msg");
	    }

	    return mav;
	}
	
	@PostMapping("/professor/assignmentEdit.lms")
	public ModelAndView professor_assignmentEdit(ModelAndView mav, MultipartHttpServletRequest mrequest) {// 과제 수정
		
		String schedule_seq_assignment = mrequest.getParameter("schedule_seq_assignment");			 
		String goBackURL = mrequest.getParameter("goBackURL"); 
		
		String message = "";
		
		try {		
			// 수정해야 할 글 1개 내용 가져오기		
			AssignJoinSchedule assign_edit = professorService.assignmentEdit(schedule_seq_assignment);
			// 글 조회수 증가는 없고 단순히 글 1개만 조회해 오는 것
						
			if(assign_edit == null) {
				message= "글 수정이 불가합니다.";
			}
			else {
				
				
				mav.addObject("assign_edit", assign_edit);
				mav.addObject("goBackURL", goBackURL);
				mav.setViewName("professor_assignmentEdit");
					
				return mav;					
	
			}
			
		} catch (Exception e) {	
			message="글 수정이 불가합니다.";
		}
		
		String loc = "javascript:history.back()";
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	@PostMapping("/professor/fileDelete_end.lms")
	public ModelAndView professor_fileDelete_end(ModelAndView mav, MultipartHttpServletRequest mrequest) {// 파일 삭제 끝
		
		String schedule_seq_assignment = mrequest.getParameter("schedule_seq_assignment");
		String attatched_file = mrequest.getParameter("attatched_file");
		String goBackURL = mrequest.getParameter("goBackURL");
		
		// System.out.println("확인용 attatched_file : " + attatched_file);
		
		int n = professorService.fileDelete(mrequest, attatched_file, schedule_seq_assignment);
		
		if(n != 1) {
	        mav.addObject("message", "파일을 삭제할 수 없습니다.");
	        mav.addObject("loc", "javascript:history.back()");
	        mav.setViewName("msg");
			
		} else {
	        mav.addObject("message", "파일이 삭제되었습니다.");
	        mav.addObject("loc", mrequest.getContextPath() + goBackURL);
	        mav.setViewName("msg");
	    }
		
		return mav;
	}


	@PostMapping("/professor/courseUpload.lms")
	public ModelAndView courseUploadPage(ModelAndView mav, HttpServletRequest request) {

		return lectureService.getUploadLecturePage(request, mav);
	}

	@PostMapping("/professor/courseUploadREST.lms")
	public ResponseEntity<String> courseUpload(MultipartHttpServletRequest request, @ModelAttribute LectureUploadDto lectureUploadDto) throws Exception {
		
		return lectureService.uploadLecturePage(request, lectureUploadDto);
	}

	@GetMapping("/professor/editLecture.lms")
	public ModelAndView lectureEditPage(ModelAndView mav, HttpServletRequest request) {
		return lectureService.getLectureEditPage(mav, request);
	}
	@PostMapping("/professor/updateLectureREST.lms")
	public ResponseEntity<String> editLecturePage(HttpServletRequest request, @ModelAttribute LectureUploadDto lectureUploadDto) throws Exception {
		return  lectureService.editLecture(request, lectureUploadDto);
	}


	@PostMapping("/professor/deleteLectureREST.lms")
	public ResponseEntity<String> deleteLecturePage(HttpServletRequest request) throws Exception {
		return  lectureService.deleteLecture(request);
	}



	
	@PostMapping("/professor/assignmentEdit_end.lms")
	public ModelAndView professor_assignmentEdit_End(ModelAndView mav, MultipartHttpServletRequest mrequest) {// 과제 수정 끝
		
		int n = 0;
		
		HttpSession session = mrequest.getSession();
		
		AssignScheInsertDTO file_check = new AssignScheInsertDTO(); 
		
		String schedule_seq_assignment = mrequest.getParameter("schedule_seq_assignment");
		
		//System.out.println("확인용 schedule_seq_assignment 11 : " + schedule_seq_assignment);
		
		// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작 === //
		file_check = professorService.file_check(schedule_seq_assignment);
		
		
		
		if (file_check != null) {
			String attatched_file = file_check.getAttatched_file();
			System.out.println("확인용 attatched_file11 : " + attatched_file);
	        	            
            // 첨부파일이 저장되어 있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
            // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다. 
            // WAS 의 webapp 의 절대경로를 알아와야 한다.  
            String root = session.getServletContext().getRealPath("/");
            
            // System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
            // ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
            
            String path = root+"resources"+File.separator+"files";
            /* 	File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
            	운영체제가 Windows 이라면 File.separator 는  "\" 이고,
            	운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
            */
            // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
            // System.out.println("~~~ 확인용 path => " + path);
            // ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files
            
            
            System.out.println("삭제하려는 파일 경로: " + path);
            System.out.println("삭제하려는 파일 이름: " + attatched_file);
            
            
            if (attatched_file != null && !"".equals(attatched_file)) {
                try {
                    fileManager.doFileDelete(attatched_file, path);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
	                   
	    } // end of if (professor != null) 
		
		// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝 === //
		
		String goBackURL = mrequest.getParameter("goBackURL");	
	    
		AssignScheInsertDTO dto = new AssignScheInsertDTO();
		
		dto.setTitle(mrequest.getParameter("title"));    
	    //System.out.println("확인용 제목 : " + dto.getTitle());
	    
	    dto.setStartDate(mrequest.getParameter("startdate"));
	    dto.setEndDate(mrequest.getParameter("enddate"));
	    dto.setContent(mrequest.getParameter("content"));
	    dto.setSchedule_seq_assignment(Integer.parseInt(schedule_seq_assignment));
	    
	    MultipartFile attach = mrequest.getFile("attach");
	    dto.setAttach(attach);
	    
	    if (attach != null && !attach.isEmpty()) {
	        String root = session.getServletContext().getRealPath("/");
	        String path = root + "resources" + File.separator + "files";

	        String newFileName = "";
	        byte[] bytes = null;
		     // 첨부 파일의 내용물을 담은 것
	        try {
	            bytes = attach.getBytes();
	            String originalFilename = attach.getOriginalFilename();
	            newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
	            
	            //System.out.println("확인용 newFileName " + newFileName);
	            
	            dto.setAttatched_file(newFileName); // 업로드된 파일 이름 설정
	            dto.setOrgfilename(originalFilename); // 원래 파일 이름 설정
	        } catch (Exception e) {
	        	dto.setAttatched_file(newFileName); // 첨부파일이 없을 경우 ""	        	
	        }
	    }

	    n = professorService.assignmentEdit_End(dto);
		
		if(n != 1) {
	        mav.addObject("message", "과제를 수정할 수 없습니다.");
	        mav.addObject("loc", "javascript:history.back()");
	        mav.setViewName("msg");
			
		} else {
	        mav.addObject("message", "과제가 수정되었습니다.");
	        mav.addObject("loc", mrequest.getContextPath() + goBackURL);
	        mav.setViewName("msg");
	    }		
		
		return mav;
	}
	
	
	@ResponseBody
	@PostMapping("/professor/assignment_checkJSON.lms")
	public String professor_assignment_checkJSON(HttpServletRequest request) {// 제출과제 확인 제이슨
		
		String schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		
		// System.out.println("확인용 fk_course_seq : " + fk_course_seq);
		
		List<Map<String,String>> assignmentCheckJSON = professorService.assignmentCheckJSON(schedule_seq_assignment);
		// 과제 제출된 것 리스트로 받아오기
		
        JSONArray jsonArr = new JSONArray();
        
        for(Map<String, String> map : assignmentCheckJSON) {
           
           JSONObject jsonObj = new JSONObject();
           jsonObj.put("row_num", map.get("row_num"));
           jsonObj.put("fk_schedule_seq_assignment", map.get("fk_schedule_seq_assignment"));
           jsonObj.put("assignment_submit_seq", map.get("assignment_submit_seq"));
           jsonObj.put("name", map.get("name"));
           jsonObj.put("attatched_file", map.get("attatched_file"));
           jsonObj.put("end_date", map.get("end_date"));
           jsonObj.put("submit_datetime", map.get("submit_datetime"));
           jsonObj.put("score", map.get("score"));
           jsonArr.put(jsonObj);
           
        }// end of for--------------------------------
        
        // System.out.println(jsonArr.toString());
        
        return jsonArr.toString();
		
	}
	
	
	@PostMapping("/professor/scoreUpdate.lms")
	public ModelAndView professor_scoreUpdate(ModelAndView mav, HttpServletRequest request) {// 과제 점수 등록
		
		String goBackURL = request.getParameter("goBackURL");
		String score = request.getParameter("score");
		String assignment_submit_seq = request.getParameter("assignment_submit_seq");
		
		Map<String, String> paraMap = new HashMap<>(); 
		
		System.out.println("확인용 goBackURL : " + goBackURL);
		System.out.println("확인용 score : " + score);
		System.out.println("확인용 assignment_submit_seq : " + assignment_submit_seq);
		
		paraMap.put("assignment_submit_seq", assignment_submit_seq);
		paraMap.put("score", score);
		
		int n = professorService.scoreUpdate(paraMap);
		
		
		if(n != 1) {
	        mav.addObject("message", "점수를 입력할 수 없습니다.");
	        mav.addObject("loc", "javascript:history.back()");
	        mav.setViewName("msg");
			
		} else {
			mav.addObject("message", "점수가 입력되었습니다.");
	        mav.addObject("loc", request.getContextPath() + goBackURL);
	        mav.setViewName("msg");
	    }
		
		return mav;
	}
	
	
	@GetMapping("/download.lms")
	public void professor_download(HttpServletRequest request, HttpServletResponse response) {// 첨부파일 다운로드
			
		String schedule_seq_assignment = request.getParameter("schedule_seq_assignment");
		
		// System.out.println("확인용  schedule_seq_assignment : " + schedule_seq_assignment);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체로 가정
		
		try {
	
			Assignment assignment = professorService.searchFile(schedule_seq_assignment);
			
			if(assignment == null || assignment != null && assignment.getAttatched_file() == null) {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체로 가정
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
	             return;
			}
			
			else {// 정상적으로 다운로드를 할 경우
				String fileName = assignment.getAttatched_file();
				// 2024062809210487735185511000.jpg -- WAS(톰캣)에 저장된 파일명
				
				String orgFilename = assignment.getOrgfilename();

				HttpSession session = request.getSession(); 
				String root = session.getServletContext().getRealPath("/");

				String path = root+"resources"+File.separator+"files";

	            boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도 

	            flag = fileManager.doFileDownload(fileName, orgFilename, path, response);

	            if(!flag) {
	               // 다운로드가 실패한 경우 메시지를 띄워준다. 
	               out = response.getWriter();
	                // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	                
	                out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");
	            }

			}

		} catch (NumberFormatException | IOException e) {
			
			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체로 가정
				
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
				
			} catch (IOException e2) {
				e2.printStackTrace();
			}
			
		}	
		
	}// end of public void professor_download(HttpServletRequest request, HttpServletResponse response) 
		


	@GetMapping("/professor/consult.lms")
	public ModelAndView getConsultPage(HttpServletRequest request, ModelAndView mav) {
		return scheduleService.getProfessorConsultPage(request, mav);
	}
	
	
	@ResponseBody
	@PostMapping("/professor/courseListJson.lms")
	public String courseListJson(HttpServletRequest request) {// 학기별 개강과목 json
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		int prof_id = loginuser.getProf_id();
		
		String semester = request.getParameter("semester");
		//System.out.println("확인용 semester : " + semester);
		// 202103
		
		ProfessorTimeTable timeTable = professorService.courseListJson(semester, prof_id);
		// 해당학기 수업 리스트
		List<Course> courseListJson = timeTable.getCourseList();
		
		
		JSONArray jsonArr = new JSONArray();
        
        for(Course course : courseListJson) {
           
           JSONObject jsonObj = new JSONObject();
           jsonObj.put("prof_id", course.getProfessor().getProf_id());
           jsonObj.put("prof_name", course.getProfessor().getName());
           jsonObj.put("course_seq", course.getCourse_seq());
           jsonObj.put("semester_date", course.getSemester_date());
           jsonObj.put("curriculum_seq", course.getCurriculum().getCurriculum_seq());
           jsonObj.put("fk_department_seq", course.getCurriculum().getFk_department_seq());
           jsonObj.put("name", course.getCurriculum().getName());
           jsonObj.put("credit", course.getCurriculum().getCredit());
           jsonObj.put("required", course.getCurriculum().getRequired());
           jsonObj.put("timeList", course.getTimeList());
           
           
           jsonArr.put(jsonObj);
           
        }// end of for--------------------------------
        
        // System.out.println(jsonArr.toString());
        
        return jsonArr.toString();
				
	}
	
	
	@GetMapping("/professor/insertGradeform.lms")
	public ModelAndView professor_insertGrade(HttpServletRequest request, ModelAndView mav, Professor professor) {// 교수 점수 입력용 페이지
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		int prof_id = loginuser.getProf_id();
		
		ProfessorTimeTable timeTable = professorService.courseList(prof_id);
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
		mav.setViewName("professor_insertGradeform");
		
		return mav;
	}
	
	@GetMapping("/professor/insertGradeList.lms")
	public ModelAndView professor_insertGradeList(HttpServletRequest request, ModelAndView mav) {// 교수 점수 입력용 페이지 상세
		
		String fk_course_seq = request.getParameter("course_seq");
		
		// System.out.println("확인용 fk_course_seq : " + fk_course_seq);	
		
		// List<Map<String, String>> studentList = service.studentList(fk_course_seq);
		
		int currentPage = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		
		Pager<Map<String, String>> studentList = professorService.studentList(fk_course_seq, currentPage);

		mav.addObject("fk_course_seq", fk_course_seq);
		
		mav.addObject("studentList", studentList.getObjectList());
		mav.addObject("currentPage", studentList.getPageNumber());
		mav.addObject("perPageSize", studentList.getPerPageSize());
		mav.addObject("pageBar", studentList.makePageBar(request.getContextPath() + "/professor/insertGradeList.lms", "course_seq="+fk_course_seq));

		mav.setViewName("professor_insertGradeList");
		
		return mav;
	}
	
	@GetMapping("/professor/insertGradeDetail.lms")
	public ModelAndView professor_insertGradeDetail(HttpServletRequest request, ModelAndView mav) {// 학생 점수 뷰단
		
		String goBackURL = MyUtil.getCurrentURL(request);
		int student_id = Integer.parseInt(request.getParameter("student_id"));
		int fk_course_seq = Integer.parseInt(request.getParameter("course_seq"));
		String name = request.getParameter("name");
		
		String Student_pic = professorService.Student_pic(student_id);
		
		System.out.println("확인용 student_id : " + student_id);
		System.out.println("확인용 fk_course_seq : " + fk_course_seq);
		System.out.println("확인용 name : " + name);
		
		mav.addObject("student_id", student_id);
		mav.addObject("fk_course_seq", fk_course_seq);	
		mav.addObject("name", name);
		mav.addObject("Student_pic", Student_pic);
		mav.addObject("goBackURL", goBackURL);
		mav.setViewName("professor_insertGradeDetail");
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping(value="/professor/score_checkJSON.lms", produces="text/plain;charset=UTF-8")
	public String professor_score_checkJSON(HttpServletRequest request , HttpServletResponse response, ModelAndView mav) throws JsonMappingException, JsonProcessingException {// 학생 점수 가져오기
			  
		
		int student_id = Integer.parseInt(request.getParameter("student_id")); // 학번
		int fk_course_seq = Integer.parseInt(request.getParameter("fk_course_seq")); // 강좌번호
		String name = request.getParameter("name"); // 학생 이름
		
		System.out.println("확인용 json student_id : " + student_id);
		System.out.println("확인용 json fk_course_seq : " + fk_course_seq);
		System.out.println("확인용 json name : " + name);
		
		Map<String, Object> checkMap = new HashMap<>();
		
		// 학생 기본 정보와 과제 데이터 가져오기
		checkMap = professorService.score_checkJSON(student_id, fk_course_seq);

		
		double DassignmentScore = (double)checkMap.get("assignmentScore"); // 과제 백분율	
		int regi_course_seq = (int)checkMap.get("regi_course_seq"); // 학생 등록 강좌 번호
		
		String assignmentScore = String.format("%.2f", DassignmentScore);  
		System.out.println("확인용 json 넣기전 assignmentScore : " + assignmentScore);
		
		Object mark = null; // 학점
		
		try {	
			mark = (double)checkMap.get("mark");
		} catch (Exception e) {
			
		}
		
		// 몽고 디비에서 시험점수 가져오기
		double DtotalExamScore = 0;
		
		// 총 시험 갯수 가져오기
		int examCount = professorService.examCount(fk_course_seq);
		
		String totalExamScore = ""; 
		 
		
		List<StudentAnswer> ExamResultList = examService.ExamResultList(fk_course_seq);
		
		if (ExamResultList != null && !ExamResultList.isEmpty()) {
	    	
            for (StudentAnswer answer : ExamResultList) {
                int score = answer.getScore();
                int totalscore = answer.getTotalScore();
                
            	System.out.println("확인용 score : " + score);
            	System.out.println("확인용 totalscore : " + totalscore);
            	
            	DtotalExamScore += ((double)score/totalscore)*100/examCount;
            	
            }
            
        } else {
            System.out.println("ExamResultList가 비어 있습니다.");
        }
		
		totalExamScore = String.format("%.2f", DtotalExamScore); 
		System.out.println("확인용 totalExamScore : " + totalExamScore);
		
		/////////////////////////////////////////////////////////////
		
		// 학생 출석율 가져오기
		double DattendanceRate = 0;
		String attendanceRate = "0";
		try {		
			DattendanceRate = professorService.attendanceRate(student_id, fk_course_seq);
			attendanceRate = String.format("%.2f", DattendanceRate);
		} catch (Exception e) {
			
		}
		
		// System.out.println("확인용 출석율 : " + attendanceRate);
		
		Double DtotalScore = DassignmentScore + DtotalExamScore + DattendanceRate;
		
		String totalScore = String.format("%.2f", DtotalScore); 
		System.out.println("확인용 토탈 : " + totalScore);
		
		
		
		
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("student_id", student_id);
        jsonObj.put("name", name);
        jsonObj.put("assignmentScore", assignmentScore);
        jsonObj.put("totalExamScore", totalExamScore);
        jsonObj.put("regi_course_seq", regi_course_seq);
        jsonObj.put("attendanceRate", attendanceRate);
        jsonObj.put("totalScore", totalScore);
        jsonObj.put("mark", mark);
        
        
        System.out.println(jsonObj.toString());
        
        return jsonObj.toString();
	}
	
	@PostMapping(value="/professor/insertGradeEnd.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView insertGradeEnd(HttpServletRequest request, ModelAndView mav) {// 학생 점수 입력 끝
		
		String goBackURL = request.getParameter("goBackURL");
		System.out.println("확인용 goBackURL : " + goBackURL);
		
		int student_id = Integer.parseInt(request.getParameter("student_id"));  
		int regi_course_seq = Integer.parseInt(request.getParameter("regi_course_seq"));
		double mark = Double.parseDouble(request.getParameter("mark")); 
		
		System.out.println("확인용 student_id : " + student_id);
		System.out.println("확인용 regi_course_seq : " + regi_course_seq);
		System.out.println("확인용 mark : " + mark);
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("student_id", student_id);
		paraMap.put("regi_course_seq", regi_course_seq);
		paraMap.put("mark", mark);
		
		
		int n = professorService.insertGradeEnd(paraMap);
	    
	    if(n == 1) {
	  	  mav.addObject("message", "학점이 입력되었습니다.");
	  	  mav.addObject("loc", request.getContextPath()+goBackURL);
	  	  mav.setViewName("msg");
	    }
	    else {
	  	  mav.addObject("message", "학점 입력을 실패했습니다.");
	  	  mav.addObject("loc", "javascript:history.back()");
	  	  mav.setViewName("msg");
	    }
	
	    return mav;
	}
	
	@PostMapping(value="/professor/editGradeEnd.lms", produces="text/plain;charset=UTF-8")
	public ModelAndView editGradeEnd(ModelAndView mav, HttpServletRequest request) {// 학생 점수 수정 끝
		
		String goBackURL = request.getParameter("goBackURL");
		System.out.println("확인용 goBackURL : " + goBackURL);
		 
		int regi_course_seq = Integer.parseInt(request.getParameter("regi_course_seq"));
		double mark = Double.parseDouble(request.getParameter("mark")); 
		
		System.out.println("확인용 regi_course_seq : " + regi_course_seq);
		System.out.println("확인용 mark : " + mark);
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("regi_course_seq", regi_course_seq);
		paraMap.put("mark", mark);
		
		
		int n = professorService.editGradeEnd(paraMap);
	    
	    if(n == 1) {
	  	  mav.addObject("message", "학점이 수정되었습니다.");
	  	  mav.addObject("loc", request.getContextPath()+goBackURL);
	  	  mav.setViewName("msg");
	    }
	    else {
	  	  mav.addObject("message", "학점 수정을 실패했습니다.");
	  	  mav.addObject("loc", "javascript:history.back()");
	  	  mav.setViewName("msg");
	    }
	
	    return mav;
	}
	
	
	// 수업 - 내 강의 - 동영상 플레이
	@GetMapping("/professor/classPlay.lms")
	public ModelAndView classPlay(HttpServletRequest request, ModelAndView mav) {
		
		String fk_course_seq = request.getParameter("course_seq");
		
		System.out.println("확인용 fk_course_seq : " + fk_course_seq);
		
		List<Lecture> lectureList_week = professorService.getlectureList_week(fk_course_seq);
		
		mav.addObject("lectureList_week", lectureList_week);
		
		mav.setViewName("classPlay");
		
		return mav;
	} // end of public String class_play()-------
	
	
	
	
	
	
}
