package com.sooRyeo.app.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.ExamAnswer.Answer;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ExamService {

	
    // ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

	
    // 시험 출제 시 몽고db에 insert
	ExamAnswer insert_examAnswer(ExamAnswer examAnswer);
}
