package com.sooRyeo.app.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;


import com.sooRyeo.app.domain.TimeTable;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.model.CourseDao;

@Service
public class CourseService_imple implements CourseService {
	
	@Autowired
	private CourseDao courseDao;
	
	@Autowired
	private JsonBuilder jsonBuilder;

	@Override
	public String getProfTimetable(HttpServletRequest request, ModelAndView mav) {
		
		int prof_id = Integer.parseInt(request.getParameter("prof_id"));
		System.out.println("prof_id:  " + prof_id );
		
		TimeTable profTimeTable = courseDao.getProfTimeTable(prof_id);
		
		return jsonBuilder.toJson(profTimeTable);
	}
	

}
