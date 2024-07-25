package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.LoginLog;
import com.sooRyeo.app.mongo.entity.ExamAnswer.Answer;
import com.sooRyeo.app.mongo.repository.ExamAnswerRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ExamService_imple implements ExamService {

    @Autowired
    private ScheduleDao scheduleDao;
    
    @Autowired
    private ExamAnswerRepository examAnswerRepository;


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


	@Override
	public Exam getExam() {

	    Exam examView = scheduleDao.getExam();  // 스케줄 DAO로부터 Exam 객체를 가져옴
	    
	    List<ExamAnswer> examList = examAnswerRepository.findAllById(examView.getAnswer_mongo_id()); // ExamAnswer 객체들을 가져옴
	    
	    if (examList != null && !examList.isEmpty()) {
            for (ExamAnswer exam : examList) {
            	
                List<Answer> answers = exam.getAnswers();  // 각 ExamAnswer 객체의 answers 배열을 가져옴
                
                for (Answer answer : answers) {
                	
                    int getAnswer = answer.getAnswer();  // 각 Answer 객체의 score를 가져옴
                    
                    System.out.println("확인용 getAnswer: " + getAnswer);
                }
            }
        } else {
            System.out.println("examList가 비어 있습니다.");
        }
	    
	    return examView;  // 가져온 Exam 객체를 반환
	}
}
