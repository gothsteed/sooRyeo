package com.sooRyeo.app.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.sooRyeo.app.ExceptionHandler.AlreadyLoggedInException;
import com.sooRyeo.app.ExceptionHandler.AuthException;
import com.sooRyeo.app.ExceptionHandler.LoginException;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;

@Aspect
@Component
public class AuthAspect {
	
	
	@Before("@within(requireLogin) || @annotation(requireLogin)")
	public void checkAuth(JoinPoint joinPoint, RequireLogin requireLogin) throws Throwable {
		

		if(requireLogin == null) {
			
			requireLogin = joinPoint.getTarget().getClass().getAnnotation(RequireLogin.class);
			
			
			if(requireLogin == null) return;
		}
		
		
		
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		
		HttpServletRequest request = attributes.getRequest();
		
		Class[] types = requireLogin.type();
		
		HttpSession session = request.getSession();

		System.out.println(session.getAttribute("loginuser"));
	
		if(session.getAttribute("loginuser") == null) {
			throw new LoginException("로그인 하시오");
		}
		
		System.out.println("getClass().getName() : " + session.getAttribute("loginuser").getClass().getName());
		
		
		for(Class type : types) {
			if (session.getAttribute("loginuser").getClass().getName().equalsIgnoreCase(type.getName())) {
				return;
			}
			throw new AuthException("권한이 없습니다");
		}

	
		
		
		
	}
	
	
	@Before(" (@within(isAlreadyLogin) || @annotation(isAlreadyLogin)) && !execution(* com.sooRyeo.app.HomeController.logout(..)) ")
	public void checkAlreadyLogin(JoinPoint joinPoint, IsAlreadyLogin isAlreadyLogin) {
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") != null) {
			throw new AlreadyLoggedInException("이미 로그인 하셨습니다");
		}
		
		
	}
	
	

}
