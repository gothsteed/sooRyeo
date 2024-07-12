package com.sooRyeo.app.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tiles.evaluator.AbstractAttributeEvaluator;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;

@Component
@Aspect
public class TilesAspect {
	
	private boolean isJsonObject(String viewName) {
		try {
			new JSONObject(viewName);
			return true;
		} catch (JSONException e) {
			return false;
		}
	}
	
	
	private boolean isJsonArray(String viewName) {
		try {
			new JSONArray(viewName);
			return true;
		} catch (JSONException e) {
			return false;
		}
	}

	
	@Around("(@within(requireLogin) || @annotation(requireLogin)) && !@annotation(org.springframework.web.bind.annotation.ResponseBody)")
	public Object tilesAspect(ProceedingJoinPoint joinPoint,  RequireLogin requireLogin) throws Throwable {
		Object result = joinPoint.proceed();
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();
		HttpSession session = request.getSession();
		Object loginuser = session.getAttribute("loginuser");

		String tile = "";
		if (loginuser instanceof Student) {
			tile = ".student";
		} else if (loginuser instanceof Professor) {
			tile = ".professor";
		} else if (loginuser instanceof Admin) {
			tile = ".admin";
		}
		
		

		if (result instanceof ModelAndView) {

			ModelAndView mav = (ModelAndView) result;
			String viewName = mav.getViewName();
			
			if(viewName.contains("redirect:")) {
				return mav;
			}

			mav.setViewName(viewName + tile);

			return mav;

		}

		else if (result instanceof String) {
			String viewName = (String) result;
			
			if(viewName.contains("redirect:")) {
				return viewName;
			}
			
			
			if(isJsonObject(viewName)) {
				return viewName;
			}
			
			else if(isJsonArray(viewName)) {
				return viewName;
			}
			
			
			return viewName + tile;
		}
		
		
		return result;
	}

}
