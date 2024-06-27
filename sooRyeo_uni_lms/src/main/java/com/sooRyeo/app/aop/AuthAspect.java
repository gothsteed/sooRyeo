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
		
		Class type = requireLogin.type();
		
		HttpSession session = request.getSession();

		System.out.println(session.getAttribute("loginuser"));
	
		if(session.getAttribute("loginuser") == null) {
			throw new AuthException("로그인 하시오");
		}
		
		System.out.println("getClass().getName() : " + session.getAttribute("loginuser").getClass().getName());
		
		if(!session.getAttribute("loginuser").getClass().getName().equalsIgnoreCase(type.getName())) {
			
			throw new AuthException("권한이 없습니다");
			
		}
		
		
	}
	

}
