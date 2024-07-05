package com.sooRyeo.app.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.common.Sha256;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Time;
import com.sooRyeo.app.model.ProfessorDao;


@Service
public class ProfessorService_imple implements ProfessorService {
	
	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private ProfessorDao dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
    @Autowired
    private AES256 aES256;
    // Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aES256 에 주입시켜준다. 
    // 그러므로 aES256 는 null 이 아니다.
    // com.spring.app.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.
    
	@Autowired
	private FileManager fileManager;
    
    
    @Override
	public Professor getInfo(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
    	
    	Professor professor = dao.getInfo(loginuser);
    	
    	professor.setDecodedEmail(aES256);
    	professor.setDecodeTel(aES256);
    	
    	
    	
		return professor;
	}

    
	@Override
	public JSONObject pwdDuplicateCheck(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		String prof_id = Integer.toString(loginuser.getProf_id());
		
		String pwd = request.getParameter("pwd");		
		pwd = Sha256.encrypt(pwd);
		
		Map<String, String> paraMap = new HashMap<>(); 
		
		paraMap.put("prof_id", prof_id);
		paraMap.put("pwd", pwd);
		
		
		int n = 0;
		try {
			n = dao.pwdDuplicateCheck(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n); // {"n":1}
		
		return jsonObj;
	}


	@Override
	public JSONObject telDuplicateCheck(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		String prof_id = Integer.toString(loginuser.getProf_id());
		
		String tel = request.getParameter("tel");
		try {
			tel = aES256.encrypt(tel);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		// System.out.println("확인용 prof_id : " + prof_id);
		// System.out.println("확인용 tel : " + tel);
		
		Map<String, String> paraMap = new HashMap<>(); 
		
		paraMap.put("prof_id", prof_id);
		paraMap.put("tel", tel);
		
		
		int n = 0;
		try {
			n = dao.telDuplicateCheck(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n); // {"n":1}
		
		return jsonObj;
	}


	@Override
	public JSONObject emailDuplicateCheck(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		String prof_id = Integer.toString(loginuser.getProf_id());
		
		String email = request.getParameter("email");
		try {
			email = aES256.encrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		// System.out.println("확인용 prof_id : " + prof_id);
		// System.out.println("확인용 tel : " + tel);
		
		Map<String, String> paraMap = new HashMap<>(); 
		
		paraMap.put("prof_id", prof_id);
		paraMap.put("email", email);
		
		
		int n = 0;
		try {
			n = dao.emailDuplicateCheck(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n); // {"n":1}
		
		return jsonObj;
	}


	@Override
	public int professor_info_edit(Professor professor,  MultipartHttpServletRequest mrequest) {
		
		int n1 = 1;
		int n2 = 0;
			
		HttpSession session = mrequest.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		
		String prof_id = Integer.toString(loginuser.getProf_id());
		String pwd = mrequest.getParameter("pwd");
		pwd = Sha256.encrypt(pwd);
		
		String address = mrequest.getParameter("address") + " " + mrequest.getParameter("detailAddress") + mrequest.getParameter("extraAddress");	// 주소
		
		String email = mrequest.getParameter("email");
		
		try {
			email = aES256.encrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		String tel = mrequest.getParameter("tel");
		
		try {
			tel = aES256.encrypt(tel);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		//System.out.println("확인용 prof_id : " + prof_id);
		//System.out.println("확인용 pwd : " + pwd);
		//System.out.println("확인용 address : " + address);
		//System.out.println("확인용 email : " + email);
		//System.out.println("확인용 tel : " + tel);
		
		Map<String, String> editMap = new HashMap<>();
		
		editMap.put("prof_id", prof_id);
		editMap.put("pwd", pwd);
		editMap.put("address", address);
		editMap.put("email", email);
		editMap.put("tel", tel);
		
		Professor img_name_check = dao.select_file_name(editMap);
		
		if (img_name_check != null) {
	        String fileName = img_name_check.getImg_name();
	        //System.out.println("확인용 fileName : " + fileName);
	        
	        if (fileName != null && !"".equals(fileName)) {
	            
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
	            
	            editMap.put("path", path); // 삭제해야할 파일이 저장된 경로
	            editMap.put("fileName", fileName); // 삭제해야할 파일이 저장된 경로
	            
	            n1 = dao.delFilename(editMap.get("prof_id"));
	            //System.out.println("n1: " + n1);
	            
	            if (n1 == 1) {
	                path = editMap.get("path");
	                fileName = editMap.get("fileName");
	                
	                if (fileName != null && !"".equals(fileName)) {
	                    try {
	                        fileManager.doFileDelete(fileName, path);
	                    } catch (Exception e) {
	                        e.printStackTrace();
	                    }
	                }
	                
	            } // end of if(n1 == 1)
	            
	        } // end of if(fileName != null && !"".equals(fileName))
	    } // end of if (professor != null) 
		
		// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝 === //
		/////////////////////////////////////////////////////////////////////////////////

		String img_name = "";
		MultipartFile attach = professor.getAttach();
		
		if(!attach.isEmpty()) {
		
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
				img_name = newFileName;
				   // WAS(톰캣)에 저장된 파일명(2024062712074811660790417300.xlsx) 이다.	
				   
			} catch (Exception e) {
				e.printStackTrace();
			}			
	    };// end of if(!attach.isEmpty()) 	
		
	    //System.out.println("확인용 img_name : " + img_name);

	    editMap.put("img_name", img_name);

		
		try {
			n2 = dao.professor_info_edit(editMap);
			//System.out.println("n2: " + n2);
		} catch (Throwable e) {
			e.printStackTrace();
		}		
		
		if(n1*n2 == 1) {// 잘 수정되었다면 세션에 정보를 덧씌우기하기 위한 용도
			
			loginuser.updateinfo(editMap); // professor 도메인 데이터 수정
			
		}

		return n1*n2;
	}

	
	@Override
	public List<Professor> professor_course(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		
		String prof_id = Integer.toString(loginuser.getProf_id());
		
		List<Professor> professorList = dao.professor_course(prof_id);
		
		for (Professor professor : professorList) {
		    System.out.println("Professor ID: " + professor.getProf_id());
		    // 추가 속성들을 출력
		    Course course = professor.getCourse();
		    if (course != null) {
		        System.out.println("Course ID: " + course.getCourse_seq());
		        System.out.println("Course Capacity: " + course.getCapacity());
		        System.out.println("Semester Date: " + course.getSemester_date());
		    }
		    Curriculum curriculum = professor.getCurriculum();
		    if (curriculum != null) {
		        System.out.println("Curriculum ID: " + curriculum.getCurriculum_seq());
		        System.out.println("Department Seq: " + curriculum.getFk_department_seq());
		        System.out.println("Grade: " + curriculum.getGrade());
		        System.out.println("Name: " + curriculum.getName());
		        System.out.println("Credit: " + curriculum.getCredit());
		        System.out.println("Required: " + curriculum.getRequired());
		        System.out.println("Exist: " + curriculum.getExist());
		    }
		    Time time = professor.getTime();
		    if (time != null) {
		        System.out.println("Day_of_week: " + time.getDay_of_week());
		        System.out.println("Start_period: " + time.getStart_period());
		        System.out.println("End_period: " + time.getEnd_period());   
		    }
		    
		}
		
		
		return professorList;
	}
    
    
    
	
	


}
