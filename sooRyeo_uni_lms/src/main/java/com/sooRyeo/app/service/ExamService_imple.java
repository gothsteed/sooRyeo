package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.ExamResult;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Schedule;
import com.sooRyeo.app.dto.ExamResultDto;
import com.sooRyeo.app.dto.ScoreDto;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.mongo.entity.StudentAnswer;
import com.sooRyeo.app.mongo.repository.StudentExamAnswerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class ExamService_imple implements ExamService {

    @Autowired
    private ScheduleDao scheduleDao;

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
    public ResponseEntity<String>  getExamResultPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

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


        return null;
    }


	@Override
	public Exam getExam() {

		Exam examView = scheduleDao.getExam();
		
		return examView;
	}
}
