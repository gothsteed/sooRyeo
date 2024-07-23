package com.sooRyeo.app.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.service.ExamService;


@Controller
public class ExamController {

    @Autowired
    private ExamService examService;
    
    
    
	// 출제하기 버튼 클릭 시  데이터 insert
	@PostMapping("exam_write.lms")
	public ModelAndView exam_write(HttpServletRequest request, ModelAndView mav) throws Exception {
		
		
		String[]  arr_answer = request.getParameterValues("answer");
		String[]  arr_score = request.getParameterValues("score");
		String[]  arr_questionNumber = request.getParameterValues("questionNumber");
		
		int count = 0;
		
		for(int i=0; i<arr_answer.length; i++) {
			
			int n  = examService.insert_examAnswer(arr_answer[i], arr_score[i], arr_questionNumber[i]);
			
			if(n==1) {
				count ++;
			}
			
		}
		
		if(count == arr_answer.length) {
			
			String msg = "시험 출제 완료";
			String location ="javascript:history.back();"; 
			
		}
		
		
		
		return mav;

	}

    

}
