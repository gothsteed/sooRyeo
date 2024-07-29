package com.sooRyeo.app.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.mongo.entity.Answer;
import com.sooRyeo.app.mongo.entity.ExamAnswer;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Exam;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ExamService {

	
    // ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

	
    // 시험 출제 시 몽고db에 insert
	ExamAnswer insert_examAnswer(ExamAnswer examAnswer);

	// 시험 출제 시 오라클db에 insert
	int insert_exam_schedule(String test_type, String test_start_time, String test_end_time, int question_count, String answer_id, String course_seq, int total_score, ExamDTO examdto);

    ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

    
	ResponseEntity<String> getExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

	// 시험 출제 뷰단에 과목명 보여주기
	String select_coures_name(String course_seq);
	
	// 출제된 시험 정보 select 해오기
	Map<String, String> show_exam(String schedule_seq);
	
	// 몽고DB에서 값 select 해오기
	List<ExamAnswer> select_answers(HttpServletRequest request, HttpServletResponse response, String ANSWER_MONGO_ID);

	List<Answer> getExam_info(String ANSWER_MONGO_ID);

	// 시험 수정 시 몽고db에 update
	ExamAnswer update_examAnswer(List<Answer> answer_list, String answer_mongo_id);

	int update_exam_schedule(String schedule_seq, String test_type, String test_start_time, String test_end_time, int question_count, int total_score, ExamDTO examdto);
	
	
	// 시험 수정 시 오라클db update

    // ResponseEntity<String> getStudentExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);
    Exam getExam(String schedule_seq);

    ResponseEntity<String> getStudentExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response);

    ModelAndView getWaitExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response, int scheduleSeq);
    // 제출한 답을 채점해서 몽고DB에 insert 해주는 메소드

    ModelAndView takeExam(ModelAndView mav, HttpServletRequest request, int schedule_seq);

    void insertMongoStudentExamAnswer(List<String> inputAnswers, String schedule_seq, HttpServletRequest request);
}
