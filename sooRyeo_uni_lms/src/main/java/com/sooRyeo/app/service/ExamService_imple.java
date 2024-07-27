package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.ExamResult;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.ExamResultDto;
import com.sooRyeo.app.dto.ScoreDto;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.mongo.entity.Answer;
import com.sooRyeo.app.mongo.entity.StudentAnswer;
import com.sooRyeo.app.mongo.repository.StudentExamAnswerRepository;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
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
    public ModelAndView takeExam(ModelAndView mav, HttpServletRequest request, int schedule_seq) {

        Exam examView = scheduleDao.getExamSchedule(schedule_seq);

        if(examView.isBefore(LocalDateTime.now())) {
            mav.addObject("message", "아직 시험이 시작되지 않았습니다.");
            mav.addObject("loc", request.getContextPath() + "/student/exam/wait.lms?schedule_seq=" + schedule_seq);
            mav.setViewName("msg");
            return mav;
        }

        if(examView.isAfter(LocalDateTime.now())) {
            mav.addObject("message", "이미 종료된 시험입니다.");
            mav.addObject("loc", request.getContextPath() + "/student/exam/wait.lms?schedule_seq=" + schedule_seq);
            mav.setViewName("msg");
            return mav;
        }

            mav.addObject("schedule_seq", schedule_seq);
        mav.addObject("examView", examView);
        mav.setViewName("test");


        return mav;
    }



    @Override
	public Exam getExam(String schedule_seq) throws NumberFormatException , NullPointerException {

        return scheduleDao.getExam(Integer.parseInt(schedule_seq));  // 가져온 Exam 객체를 반환
	}



	@Override
	public void insertMongoStudentExamAnswer(List<String> inputAnswers, String schedule_seq) throws NumberFormatException , NullPointerException {

		Exam examView = scheduleDao.getExam(Integer.parseInt(schedule_seq));
		
	    ExamAnswer examList = examAnswerRepository.findById(examView.getAnswer_mongo_id()).orElse(null); // ExamAnswer 객체들을 가져옴
	    // insert 할떄는 save를 사용해서 파라미터에 StudentAnswer객체를 생성해서 넣어주면 된다.
	    
	    List<Answer> answers = null;
	    List<Answer> scores = null;
	    
	    int correctCount = 0;
	    int wrongCount = 0;
	    int totalscore = 0;
	    
	    if (examList != null) {
	        answers = examList.getAnswers();  // 각 ExamAnswer 객체의 answers 배열을 가져옴
	        scores = examList.getScore();
	        
	        // inputAnswers와 answers를 비교
	        for (int i = 0; i < answers.size(); i++) {
	            Answer answer = answers.get(i);
	            int getAnswer = answer.getAnswer();  // 각 Answer 객체의 score를 가져옴
	            
	            Answer score = scores.get(i);
	            int getScore = score.getScore();
	            
	            // inputAnswers의 해당 인덱스와 비교
	            if (i < inputAnswers.size()) { // 인덱스 범위 체크
	                String inputAnswer = inputAnswers.get(i); // inputAnswers에서 값 가져오기
	                
	                // getAnswer와 inputAnswer 비교
	                if (String.valueOf(getAnswer).equals(inputAnswer)) {
	                	correctCount++;
	                	//totalscore = totalscore +
	                } else {
	                	wrongCount++;
	                }
	            }
	        } // end of for------------------------------------------------------------
	        
	        StudentAnswer sa = new StudentAnswer();
	        
	        
	        //examAnswerRepository.save().orElse(null);
	        
	        
	    } else {
	        System.out.println("examList가 비어 있습니다.");
	    }

		
	}



}
