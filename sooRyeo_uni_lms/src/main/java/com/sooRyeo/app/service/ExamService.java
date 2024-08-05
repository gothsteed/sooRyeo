package com.sooRyeo.app.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.mongo.entity.Answer;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.StudentAnswer;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Exam;

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

    void insertMongoStudentExamAnswer(List<String> inputAnswers, String schedule_seq, HttpServletRequest request, int course_seq);

    // 강의 시퀀스를 불러오는 메소드
	Exam getCourse_seq(String schedule_seq);
	
	// 교수가 학생 점수 가져오는 메소드
	List<StudentAnswer> ExamResultList(int fk_course_seq);

	// 시험 삭제 시 몽고db delete
	void delete_mongDB(String mongo_id);

	// 시험 삭제 시 오라클 delete
	int delete_exam_schedule(String schedule_seq);

	ModelAndView getExamUpdatePage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, String courseSeq, String scheduleSeq);
}
