package com.sooRyeo.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.common.MyUtil;
import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.service.SearchService;


@Controller
@RequireLogin(type = {Admin.class, Student.class, Professor.class})
public class SearchController {

	@Autowired
	private SearchService scService;
	
	// === #116. 검색어 입력시 자동글 완성하기 3 (Ajax로 처리) === //
	@ResponseBody
	@GetMapping(value="/student/wordSearchShow.lms", produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		int status = 0;
		
		if(session.getAttribute("loginuser") instanceof Professor ) {
			status = 2;
		}
		else if(session.getAttribute("loginuser") instanceof Student ) {
			status = 1;
		}
		else if(session.getAttribute("loginuser") instanceof Admin){
			status = 3;
		}
		else {
			status = 4;
		}
		
		String searchWord = request.getParameter("searchWord");
		
		List<String> wordList = scService.wordSearchShow(searchWord, status);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(wordList != null) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject(); // {}
				jsonObj.put("word", word);
				
				jsonArr.put(jsonObj); // [{},{},{}]
			}// end of for ----------------------------------
		}
		
		return jsonArr.toString(); 
	}
	
	
}
