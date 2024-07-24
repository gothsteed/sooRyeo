package com.sooRyeo.app.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.ExamAnswer.Answer;
import com.sooRyeo.app.service.ExamService;


@Controller
public class ExamController {

    @Autowired
    private ExamService examService;
    
    
    
	// 출제하기 버튼 클릭 시  데이터 insert
	@PostMapping("exam_write.lms")
	public ModelAndView exam_write(HttpServletRequest request, ModelAndView mav) throws Exception {
		
		// 몽고DB insert
		String[] arr_answer = request.getParameterValues("answer");
		String[] arr_score = request.getParameterValues("score");
		String[] arr_questionNumber = request.getParameterValues("questionNumber");
		
		// 오라클 insert
		String test_type = request.getParameter("test_type");
		String test_start_time = request.getParameter("test_start_time");
		String test_end_time = request.getParameter("test_end_time");
		int question_count = request.getParameterValues("answer").length; // total 문제 수
		//String test_type = request.getParameter("test_type"); // pdf 파일명
		//String test_type = request.getParameter("test_type"); // 몽고디비 id 값

		System.out.println("question_count 확인용 =>" + question_count);
		
		
		List<Answer> answer_list = new ArrayList<>();
		
		for(int i=0; i<arr_answer.length; i++) {
			
				Answer answer =  new ExamAnswer.Answer();
			
				answer.setAnswer(Integer.parseInt(arr_answer[i]));
				answer.setScore(Integer.parseInt(arr_score[i]));    
				answer.setQuestionNumber(Integer.parseInt(arr_questionNumber[i]));
				
				answer_list.add(answer);
			
		}
		
		ExamAnswer examAnswer = new ExamAnswer();
		examAnswer.setAnswers(answer_list);
	
		ExamAnswer insert_examAnswer = examService.insert_examAnswer(examAnswer);
		
		String answer_id = insert_examAnswer.getId();
		
		int n = examService.insert_exam_schedule(test_type, test_start_time, test_end_time, question_count, answer_id);
		

		return mav;

	}

    

}
