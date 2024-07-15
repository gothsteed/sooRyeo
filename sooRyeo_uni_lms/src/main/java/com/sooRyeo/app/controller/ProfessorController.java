package com.sooRyeo.app.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.common.MyUtil;
import com.sooRyeo.app.domain.AssignJoinSchedule;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.dto.AssignScheInsertDTO;
import com.sooRyeo.app.service.ProfessorService;
import com.sooRyeo.app.service.StudentService;


@Controller
@RequireLogin(type = {Professor.class})
public class ProfessorController {
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	// @Qualifier("boardService_imple") DAO는 하나이기 때문에 Qualifier를 통해 지정할 필요가 거의 없다.
	private ProfessorService service;
	
	@Autowired
	private StudentService Studentservice;

	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value = "/professor/dashboard.lms", method = RequestMethod.GET)
	public String professor() {// 대시보드 뷰단

		return "professor_dashboard";
	}
	
	
	@RequestMapping(value = "/professor/request.lms", method = RequestMethod.GET)
	public String professor_request() {// 교수 강의신청 뷰단

		return "professor_request";
	}
	
	
	@GetMapping("/professor/info.lms")
	public ModelAndView professor_info(HttpServletRequest request, ModelAndView mav, Professor professor) {// 교수 내 정보 뷰단
			
		professor = service.getInfo(request);
		
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
		mav.setViewName("professor_courseList");
		
		return mav;
	}
	
	
	@GetMapping(value = "/professor/courseDetail.lms")  
	public ModelAndView professor_courseDetail(HttpServletRequest request, ModelAndView mav) {// 교수 진행 강의 상세
				
		String fk_course_seq = request.getParameter("course_seq");
		
		// System.out.println("확인용 fk_course_seq : " + fk_course_seq);	
		
		List<Map<String, String>> studentList = service.studentList(fk_course_seq);
		
		mav.addObject("studentList", studentList);
		mav.addObject("fk_course_seq", fk_course_seq);
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
		
		List<Map<String,String>> paperAssignment = service.paperAssignment(fk_course_seq);
		// 과제 목록 리스트로 담아오기
		
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
	        } catch (Exception e) {
	        	dto.setAttatched_file(newFileName); // 첨부파일이 없을 경우 ""	        	
	        }
	    }

	    int n = service.insert_tbl_schedule(dto, fk_course_seq);

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
		
		mav.addObject("goBackURL", goBackURL);
		
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
			
			AssignJoinSchedule assign_view = service.assign_view(paraMap);
			
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
		
	    int n = service.assignmentDelete(schedule_seq_assignment, mrequest);
		
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
			AssignJoinSchedule assign_edit = service.assignmentEdit(schedule_seq_assignment);
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
	public ModelAndView professor_fileDelete_end(ModelAndView mav, MultipartHttpServletRequest mrequest) {
		
		String schedule_seq_assignment = mrequest.getParameter("schedule_seq_assignment");
		String attatched_file = mrequest.getParameter("attatched_file");
		String goBackURL = mrequest.getParameter("goBackURL");
		
		// System.out.println("확인용 attatched_file : " + attatched_file);
		
		int n = service.fileDelete(mrequest, attatched_file, schedule_seq_assignment);
		
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
	
	
	@PostMapping("/professor/assignmentEdit_end.lms")
	public ModelAndView professor_assignmentEdit_End(ModelAndView mav, MultipartHttpServletRequest mrequest) {
		
		int n = 0;
		
		HttpSession session = mrequest.getSession();
		
		AssignScheInsertDTO file_check = new AssignScheInsertDTO(); 
		
		String schedule_seq_assignment = mrequest.getParameter("schedule_seq_assignment");
		
		//System.out.println("확인용 schedule_seq_assignment 11 : " + schedule_seq_assignment);
		
		// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작 === //
		file_check = service.file_check(schedule_seq_assignment);
		
		
		
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
	        } catch (Exception e) {
	        	dto.setAttatched_file(newFileName); // 첨부파일이 없을 경우 ""	        	
	        }
	    }

	    n = service.assignmentEdit_End(dto);
		
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
	
	
	
}
