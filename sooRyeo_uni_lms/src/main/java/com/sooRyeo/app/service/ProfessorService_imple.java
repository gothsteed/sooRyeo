package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.domain.Professor;
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
	
    
    @Override
	public Professor getInfo(Professor loginuser) {
		
    	Professor professor = dao.getInfo(loginuser);
    	
		return professor;
	}
    
    
    
	
	


}
