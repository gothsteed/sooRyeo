package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.ExamResult;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.LoginLog;
import com.sooRyeo.app.mongo.entity.MemberType;
import com.sooRyeo.app.mongo.repository.ExamAnswerRepository;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import com.sooRyeo.app.domain.Schedule;
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


import org.springframework.data.domain.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;

import java.util.List;
import java.util.Map;
import java.util.Optional;

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
        
        System.out.println("course_seq 확인용 => "+ course_seq);

        List<Exam> examPageList = scheduleDao.getExamList(currentPage, sizePerPage, course_seq);
        int examCount = scheduleDao.getExamCount(course_seq);

        Pager<Exam> examPager = new Pager<>(examPageList, currentPage, sizePerPage, examCount);
        mav.addObject("examList", examPager.getObjectList());
        mav.addObject("currentPage", examPager.getPageNumber());
        mav.addObject("perPageSize", examPager.getPerPageSize());
        mav.addObject("pageBar",examPager.makePageBar(request.getContextPath() + "/professor/exam.lms", "course_seq="+course_seq));

        LocalDateTime currentTime = LocalDateTime.now();
        mav.addObject("currentTime", currentTime);
        
        mav.addObject("course_seq", course_seq);
        
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



    // 시험 출제 뷰단에 과목명 보여주기
	@Override
	public String select_coures_name(String course_seq) {
		String coures_name = scheduleDao.select_coures_name(course_seq);
		return coures_name;
	}



	// 출제된 시험 정보 select 해오기
	@Override
	public Map<String, String> show_exam(String schedule_seq) {
		Map<String, String> show_exam = scheduleDao.show_exam(schedule_seq);
		return show_exam;
	}


	// 몽고db에서 시험 answers select 해오기 
	@Override
	public List<ExamAnswer> select_answers(HttpServletRequest request, HttpServletResponse response, String ANSWER_MONGO_ID) {
		List<ExamAnswer> select_answers = examAnswerRepository.findAllById("ANSWER_MONGO_ID");
		return select_answers;
	}



	@Override
	public List<Answer> getExam_info(String ANSWER_MONGO_ID) {
		
	    List<ExamAnswer> examList = examAnswerRepository.findAllById(ANSWER_MONGO_ID); // ExamAnswer 객체들을 가져옴
	    
	    List<Answer> answers = null;
	     
	    if (examList != null && !examList.isEmpty()) {
	    	
            for (ExamAnswer exam : examList) {
                answers = exam.getAnswers();  // 각 ExamAnswer 객체의 answers 배열을 가져옴
            }
            
        } else {
            System.out.println("examList가 비어 있습니다.");
        }
	    
	    return answers;
	}



	@Override
	public ExamAnswer update_examAnswer(List<Answer> answer_list, String answer_mongo_id) {
		
	    Optional<ExamAnswer> one_document = examAnswerRepository.findById(answer_mongo_id);

	    ExamAnswer  update_ExamAnswer = null;
	    
	    if(one_document != null) {
	    	
		    ExamAnswer exam_answer = one_document.get();
		    
		    exam_answer.setAnswers(answer_list);
		    
	    	update_ExamAnswer = examAnswerRepository.save(exam_answer); 	
	    }
	    
		return update_ExamAnswer;

	}



	// 시험 수정 시 오라클db update
	@Override
	public int update_exam_schedule(String schedule_seq, String test_type, String test_start_time, String test_end_time, int question_count, int total_score, ExamDTO examdto) {
		
		MultipartFile attach = examdto.getAttach();
		
		if(!attach.isEmpty()) {
			// 시험지 변경한 경우 
		
			int n = scheduleDao.update_exam_schedule_file(schedule_seq, test_type, test_start_time, test_end_time, question_count, total_score, examdto);
			return n;
			
		}
		else {
			// 시험지를 변경하지 않은 경우
			
			int n = scheduleDao.update_exam_schedule_nofile(schedule_seq, test_type, test_start_time, test_end_time, question_count, total_score);
			return n;
			
		}
		
	}
		
	@Override
	public void insertMongoStudentExamAnswer(List<Integer> inputAnswers, String schedule_seq, HttpServletRequest request, int course_seq) throws NumberFormatException , NullPointerException {

		Exam examView = scheduleDao.getExam(Integer.parseInt(schedule_seq));
		
	    ExamAnswer examList = examAnswerRepository.findById(examView.getAnswer_mongo_id()).orElse(null); // ExamAnswer 객체들을 가져옴
	    // insert 할떄는 save를 사용해서 파라미터에 StudentAnswer객체를 생성해서 넣어주면 된다.
	    
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("loginuser");
	    
	    List<Answer> answers = null;
	    
	    int correctCount = 0;
	    int wrongCount = 0;
	    int score = 0; // 응시자가 맞춘 문제 배점의 합
	    int totalScore = 0; // 전체 문제 배점의 총합
	    
	    if (examList != null) {
	        answers = examList.getAnswers();  // 각 ExamAnswer 객체의 answers 배열을 가져옴. 이 안에 answer와 score가 전부 들어있음.
	        
	        // inputAnswers와 answers를 비교
	        for (int i = 0; i < answers.size(); i++) {
	            Answer answer = answers.get(i);
	            int getAnswer = answer.getAnswer();  // 각 Answer 객체의 score를 가져옴
	            
	            answer.setAnswer(inputAnswers.get(i));
	            
	            int getScore = answer.getScore(); // 문제의 배점을 가져오는 것
	           
	            System.out.println("getScore "+getScore);
	            
	            totalScore += getScore; // 문제의 배점을 전부 더해서 totalScore에 저장 한 것
	            
	            // inputAnswers의 해당 인덱스와 비교
	            if (i < inputAnswers.size()) { // 인덱스 범위 체크
	                Integer inputAnswer = inputAnswers.get(i); // inputAnswers에서 값 가져오기
	                
	                // getAnswer와 inputAnswer 비교
	                if (getAnswer == inputAnswer) {
	                	correctCount++; // 정답일 경우 corrextCount를 1씩 증가

	                	score += getScore; // 정답인 경우 그 문제의 배점을 score에 쌓아두는 것

	                } else {
	                	wrongCount++; // 틀렸을 경우 wrongCount를 1씩 증가
	                }
	                
	            }
	        } // end of for------------------------------------------------------------
	        
	        System.out.println("correctCount " + correctCount);
	        System.out.println("score " + score);
	        System.out.println("wrongCount " + wrongCount);
	        System.out.println("totalScore " + totalScore);
	        
	        StudentAnswer sa = new StudentAnswer();
	        
	        sa.setStudentId(student.getStudent_id());
	        sa.setStudentName(student.getName());
	        sa.setScore(score); // 응시자가 맞춘 문제 배점의 합
	        sa.setTotalScore(totalScore); // 전체 문제 배점의 총합
	        sa.setCorrectCount(correctCount);
	        sa.setWrongSCount(wrongCount);
	        sa.setExamAnswersId(examView.getAnswer_mongo_id());
	        sa.setAnswers(answers);
	        sa.setCourseSeq(course_seq);
	        
	        answerRepository.save(sa);
	        
	        
	    } else {
	        System.out.println("examList가 비어 있습니다.");
	    }

		
	}



	@Override
	public Exam getCourse_seq(String schedule_seq) {
		
		Exam examView = scheduleDao.getExam(Integer.parseInt(schedule_seq));
		
		return examView;
	}



	@Override
	public List<StudentAnswer> ExamResultList(int fk_course_seq) {
		
		Integer courseSeq = fk_course_seq;
		
		List<StudentAnswer> answerList = answerRepository.findAllByCourseSeq(courseSeq);
		
		
		int testCount = 0;
		
		if (answerList != null && !answerList.isEmpty()) {
	    	
            for (StudentAnswer answer : answerList) {
                int score = answer.getScore();
                int totalscore = answer.getTotalScore();
                
            	System.out.println("확인용 score : " + score);
            	System.out.println("확인용 totalscore : " + totalscore);
                
                testCount++;
                
                System.out.println("확인용 testCount : " + testCount);
            }
            
        } else {
            System.out.println("answerList가 비어 있습니다.");
        }
		
		return answerList;
	}



}
