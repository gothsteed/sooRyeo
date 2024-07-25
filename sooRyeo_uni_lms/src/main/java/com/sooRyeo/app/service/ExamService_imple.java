package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.ExamAnswer.Answer;
import com.sooRyeo.app.mongo.entity.LoginLog;
import com.sooRyeo.app.mongo.entity.MemberType;
import com.sooRyeo.app.mongo.repository.ExamAnswerRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Service
public class ExamService_imple implements ExamService {

    @Autowired
    private ScheduleDao scheduleDao;
    
    @Autowired
    private ExamAnswerRepository examAnswerRepository;



/*
    @Override
    public ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
        int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int course_seq = Integer.parseInt(request.getParameter("course_seq"));
        int sizePerPage = 10;

        List<Exam> examPageList = scheduleDao.getExamList(currentPage, sizePerPage, course_seq);
        int examCount = scheduleDao.getExamCount(course_seq);

        Pager<Exam> examPager = new Pager<>(examPageList, currentPage, sizePerPage, examCount);



        return null;
    }

	
	*/
    
	@Override
	public ExamAnswer insert_examAnswer(ExamAnswer examAnswer) {
		
		ExamAnswer insert_ExamAnswer = examAnswerRepository.save(examAnswer);
		return insert_ExamAnswer;
		
	}



	@Override
	public int insert_exam_schedule(String test_type, String test_start_time, String test_end_time, int question_count, String answer_id, String course_seq, int total_score, ExamDTO examdto) {

		int n =scheduleDao.insert_tbl_schedule(test_type, test_start_time, test_end_time, question_count, answer_id, course_seq, total_score, examdto);
		
		return n;
	}
    
    



	@Override
	public Exam getExam() {

		Exam examView = scheduleDao.getExam();
		
		return examView;
	}
}
