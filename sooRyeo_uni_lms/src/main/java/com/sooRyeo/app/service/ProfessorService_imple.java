package com.sooRyeo.app.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
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
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.dto.RegisterDTO;
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
		
		String pwd = request.getParameter("pwd");		
		pwd = Sha256.encrypt(pwd);
		
		int n = 0;
		try {
			n = dao.pwdDuplicateCheck(pwd);
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
	public int professor_info_edit(MultipartHttpServletRequest mrequest, Professor professor) {
		
		int n = 0;
		
		HttpSession session = mrequest.getSession();
		Professor loginuser = (Professor)session.getAttribute("loginuser");
		
		MultipartFile attach = professor.getAttach();
        /*
        1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
        >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
                              우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
                              조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
         */
		// WAS 의 webapp 의 절대경로를 알아와야 한다. 
      
		String root = session.getServletContext().getRealPath("/");
     
		// System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
		// ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
     
		String path = root+"resources"+File.separator+"files";
		/*  File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
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
				   
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		String prof_id = Integer.toString(loginuser.getProf_id());
		String pwd = mrequest.getParameter("pwd");
		pwd = Sha256.encrypt(pwd);
		
		String address = mrequest.getParameter("address") + " " + mrequest.getParameter("detailaddress") + mrequest.getParameter("extraaddress");	// 주소
		
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
		
		String img_name = newFileName;
		// WAS(톰캣)에 저장된 파일명(2024062712074811660790417300.xlsx) 이다.
		
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("prof_id", prof_id);
		paraMap.put("pwd", pwd);
		paraMap.put("address", address);
		paraMap.put("email", email);
		paraMap.put("tel", tel);
		paraMap.put("img_name", img_name);
		
		try {
			n = dao.professor_info_edit(paraMap);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		return n;
	}
    
    
    
	
	


}
