package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.ExamResult;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.ExamResultDto;
import com.sooRyeo.app.dto.ScoreDto;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.mongo.entity.StudentAnswer;
import com.sooRyeo.app.mongo.repository.StudentExamAnswerRepository;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.ExamAnswer.Answer;
import com.sooRyeo.app.mongo.repository.ExamAnswerRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;

import java.util.List;
import java.util.Map;

@Service
public class ExamService_imple implements ExamService {

    @Autowired
    private JsonBuilder jsonBuilder;

    @Autowired
    private ScheduleDao scheduleDao;
    
    @Autowired
    private ExamAnswerRepository examAnswerRepository;

    @Autowired
    private StudentExamAnswerRepository answerRepository;


    @Override
    public ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
        int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int course_seq = Integer.parseInt(request.getParameter("course_seq"));
        int sizePerPage = 10;

        List<Exam> examPageList = scheduleDao.getExamList(currentPage, sizePerPage, course_seq);
        int examCount = scheduleDao.getExamCount(course_seq);

        Pager<Exam> examPager = new Pager<>(examPageList, currentPage, sizePerPage, examCount);
        mav.addObject("examList", examPager.getObjectList());
        mav.addObject("currentPage", examPager.getPageNumber());
        mav.addObject("perPageSize", examPager.getPerPageSize());
        mav.addObject("pageBar",examPager.makePageBar(request.getContextPath() + "/professor/exam.lms", "course_seq="+course_seq));

        LocalDateTime currentTime = LocalDateTime.now();
        mav.addObject("currentTime", currentTime);
        mav.setViewName("exam/examList");

        return mav;
    }



    @Override
    public ResponseEntity<String>  getExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

        int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq") == null? "-1" : request.getParameter("schedule_seq"));

        Exam examSchedule = scheduleDao.getExamSchedule(schedule_seq);

        if(examSchedule == null) {
            return ResponseEntity.badRequest().body("존재하지 않은 시험입니다");
        }

        if(examSchedule.isBetween(LocalDateTime.now())) {
            return ResponseEntity.badRequest().body("아직 시험이 종료되지 않았습니다");
        }

        ExamResult examResult = new ExamResult(answerRepository.findAllByExamAnswersId(examSchedule.getAnswer_mongo_id()));

        ExamResultDto examResultDto = new ExamResultDto();

        List<ScoreDto> scoreDtos = new ArrayList<>();
        for(StudentAnswer studentAnswer : examResult.getStudentAnswers()) {
            ScoreDto scoreDto = new ScoreDto();
            scoreDto.setScore(studentAnswer.getScore());
            scoreDto.setStudentName(studentAnswer.getStudentName());
            scoreDto.setStudentId(studentAnswer.getStudentId());
            scoreDto.setCorrectCount(studentAnswer.getCorrectCount());
            scoreDto.setWrongSCount(studentAnswer.getWrongSCount());
            scoreDtos.add(scoreDto);
        }

        examResultDto.setStuduentScoreList(scoreDtos);
        examResultDto.setHighestScore(examResult.getHighestScore());
        examResultDto.setAverageScore(examResult.getAverageScore());
        examResultDto.setLowestScore(examResult.getLowestScore());


        return ResponseEntity.ok().body(jsonBuilder.toJson(examResultDto));
    }

    @Override
    public ResponseEntity<String> getStudentExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
        int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq") == null? "-1" : request.getParameter("schedule_seq"));

        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("loginuser");

        Exam examSchedule = scheduleDao.getExamSchedule(schedule_seq);

        if(examSchedule == null) {
            return ResponseEntity.badRequest().body("존재하지 않은 시험입니다");
        }

        if(examSchedule.isBetween(LocalDateTime.now())) {
            return ResponseEntity.badRequest().body("아직 시험이 종료되지 않았습니다");
        }

        ExamAnswer examAnswer = examAnswerRepository.findById(examSchedule.getAnswer_mongo_id()).orElse(null);
        if(examAnswer == null) {
            return ResponseEntity.badRequest().body("존재하지 않은 시험입니다");
        }

        StudentAnswer studentAnswer = answerRepository.findByExamAnswersIdAndStudentId(examSchedule.getAnswer_mongo_id(), student.getStudent_id()).orElse(null);
        if(studentAnswer == null) {
            return ResponseEntity.badRequest().body("응시하지 않은 시험입니다");
        }

        ScoreDto scoreDto = new ScoreDto();
        scoreDto.setScore(studentAnswer.getScore());
        scoreDto.setWrongSCount(studentAnswer.getWrongSCount());
        scoreDto.setCorrectCount(studentAnswer.getCorrectCount());

        List<Integer> studentAnsList = new ArrayList<>();
        List<Integer> ExamAnsList = new ArrayList<>();

        for(int i=0; i<examAnswer.getAnswers().size(); i++) {
            studentAnsList.add(studentAnswer.getQuestionAnswer(i + 1));
            ExamAnsList.add(examAnswer.getQuestionAnswer(i + 1));

        }

        scoreDto.setTestAnswers(ExamAnsList);
        scoreDto.setStudentAnswers(studentAnsList);

        return  ResponseEntity.ok().body(jsonBuilder.toJson(scoreDto));
    }

    @Override
    public ModelAndView getWaitExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response, int scheduleSeq) {
        mav.addObject("schedule_seq", scheduleSeq);
        mav.setViewName("exam/wait");
        return mav;
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
