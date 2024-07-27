package com.sooRyeo.app.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.dto.ExamDTO;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ExamService {
    ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

    // 시험을 select 하는 메소드
    Exam getExam(String schedule_seq);
    
    ResponseEntity<String> getExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

    ResponseEntity<String> getStudentExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

    ModelAndView getWaitExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response, int scheduleSeq);
    // 제출한 답을 채점해서 몽고DB에 insert 해주는 메소드
	void insertMongoStudentExamAnswer(List<String> inputAnswers, String schedule_seq);
}
