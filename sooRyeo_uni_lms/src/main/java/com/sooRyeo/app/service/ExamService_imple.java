package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.*;
import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.model.CourseDao;
import com.sooRyeo.app.model.ScheduleDao;
import com.sooRyeo.app.model.StudentDao;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.repository.ExamAnswerRepository;

import org.springframework.beans.factory.annotation.Autowired;
import com.sooRyeo.app.dto.ExamResultDto;
import com.sooRyeo.app.dto.ScoreDto;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.mongo.entity.Answer;
import com.sooRyeo.app.mongo.entity.StudentAnswer;
import com.sooRyeo.app.mongo.entity.SubmitAnswer;
import com.sooRyeo.app.mongo.repository.StudentExamAnswerRepository;


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
    private StudentDao studentDao;

    @Autowired
    private CourseDao courseDao;

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
        mav.addObject("pageBar",examPager.makePageBar(request.getContextPath() + request.getServletPath(), "course_seq="+course_seq));

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

        ExamAnswer examAnswer = examAnswerRepository.findById(examSchedule.getAnswer_mongo_id()).orElse(null);
        if(examAnswer == null) {
            return ResponseEntity.badRequest().body("존재하지 않은 시험입니다");
        }


        List<RegisteredCourse> registeredCourseList = courseDao.courseRegisterationList(examSchedule.getFk_course_seq());

        List<StudentAnswer> studentAnswers = new ArrayList<>();
        for(RegisteredCourse registeredCourse : registeredCourseList) {
            Student student = studentDao.getStudentById(registeredCourse.getFk_student_id());
            StudentAnswer studentAnswer = answerRepository.findByExamAnswersIdAndStudentId(examSchedule.getAnswer_mongo_id(), registeredCourse.getFk_student_id())
                    .orElseGet(() -> {
                        StudentAnswer empty = makeEmptyStudentAnswer(student, examAnswer, examSchedule);
                        return answerRepository.save(empty);
                    });

            studentAnswers.add(studentAnswer);
        }

        ExamResult examResult = new ExamResult(studentAnswers);

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

        return scheduleDao.insert_tbl_schedule(test_type, test_start_time, test_end_time, question_count, answer_id, course_seq, total_score, examdto);
	}

    private StudentAnswer makeEmptyStudentAnswer(Student student, ExamAnswer examAnswer, Exam examSchedule) {
        List<SubmitAnswer> submitAnswers = new ArrayList<>();
        for(int i=0; i<examSchedule.getQuestion_count(); i++) {
            submitAnswers.add(new SubmitAnswer(i + 1, " ", examAnswer.getQuestionScore(i+1)));
        }

        return new StudentAnswer(
                student.getStudent_id(),
                student.getName(),
                examSchedule.getAnswer_mongo_id(),
                submitAnswers,
                0,
                examAnswer.getQuestionScoreSum(),
                0,
                examSchedule.getQuestion_count(),
                examSchedule.getFk_course_seq()
        );
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

        StudentAnswer studentAnswer = answerRepository.findByExamAnswersIdAndStudentId(examSchedule.getAnswer_mongo_id(), student.getStudent_id())
                .orElseGet(() -> {
                    StudentAnswer emptyStudentAnswer = makeEmptyStudentAnswer(student, examAnswer, examSchedule);
                    return answerRepository.save(emptyStudentAnswer);
                });

        ScoreDto scoreDto = new ScoreDto();
        scoreDto.setScore(studentAnswer.getScore());
        scoreDto.setWrongSCount(studentAnswer.getWrongSCount());
        scoreDto.setCorrectCount(studentAnswer.getCorrectCount());

        List<String> studentAnsList = new ArrayList<>();
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
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("loginuser");

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

        StudentAnswer studentAnswer = answerRepository.findByExamAnswersIdAndStudentId(examView.getAnswer_mongo_id(), student.getStudent_id()).orElse(null);

        if(studentAnswer != null) {
            mav.addObject("message", "이미 응시한 시험입니다.");
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


    @Override
    public ModelAndView getExamUpdatePage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, String courseSeq, String scheduleSeq) {
        String  coures_name = scheduleDao.select_coures_name(courseSeq);

        // 출제된 시험 정보 select 해오기
        Map<String, String> show_exam = scheduleDao.show_exam(scheduleSeq);

        String ANSWER_MONGO_ID = show_exam.get("answer_mongo_id");

        ExamAnswer exam = examAnswerRepository.findById(ANSWER_MONGO_ID).orElse(null);

        if(exam == null) {
            mav.addObject("loc", request.getContextPath() + "/professor/exam.lms?course_seq="+courseSeq);
            mav.addObject("message", "존재하지 않는 시험입니다.");
            mav.setViewName("msg");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return mav;
        }


        mav.addObject("schedule_seq", scheduleSeq);
        mav.addObject("course_seq", courseSeq);
        mav.addObject("answer_mongo_id",ANSWER_MONGO_ID);
        mav.addObject("exam_info", exam.getAnswers());
        mav.addObject("show_exam", show_exam);
        mav.addObject("coures_name", coures_name);
        mav.setViewName("exam/professor_exam_update");

        return mav;
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
	public void insertMongoStudentExamAnswer(List<String> inputAnswers, String schedule_seq, HttpServletRequest request, int course_seq) throws NumberFormatException , NullPointerException {

		Exam examView = scheduleDao.getExam(Integer.parseInt(schedule_seq));
		
	    ExamAnswer examList = examAnswerRepository.findById(examView.getAnswer_mongo_id()).orElse(null); // ExamAnswer 객체들을 가져옴
	    // insert 할떄는 save를 사용해서 파라미터에 StudentAnswer객체를 생성해서 넣어주면 된다.
	    
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("loginuser");
	   
	    
	    int correctCount = 0;
	    int wrongCount = 0;
	    int score = 0; // 응시자가 맞춘 문제 배점의 합
	    int totalScore = 0; // 전체 문제 배점의 총합
	    
	    if (examList == null) {
	    	System.out.println("examList가 비어 있습니다.");
	    	return;
	    }
	    	
    	List<Answer> TestAnswers = examList.getAnswers();  // 각 ExamAnswer 객체의 answers 배열을 가져옴. 이 안에 answer와 score가 전부 들어있음.
    	List<SubmitAnswer> answers = new ArrayList<SubmitAnswer>();
    	
        // inputAnswers와 answers를 비교
        for (int i = 0; i < TestAnswers.size(); i++) {
            
        	Answer testAnswer = TestAnswers.get(i);
        			
            int getAnswer = testAnswer.getAnswer(); // 각 Answer 객체의 Answer를 가져옴
            int getScore = testAnswer.getScore(); // 문제의 배점을 가져오는 것
           
            totalScore += getScore; // 문제의 배점을 전부 더해서 totalScore에 저장 한 것
            
            String inputAnswer = inputAnswers.get(i); // inputAnswers에서 값 가져오기
            
            // getAnswer와 inputAnswer 비교
            try {
            	if (getAnswer == Integer.parseInt(inputAnswer)) {
            		correctCount++; // 정답일 경우 corrextCount를 1씩 증가
            		
            		score += getScore; // 정답인 경우 그 문제의 배점을 score에 쌓아두는 것
            		
            	} else {
            		wrongCount++; // 틀렸을 경우 wrongCount를 1씩 증가
            	}
			} catch (Exception e) {
				wrongCount++; // 틀렸을 경우 wrongCount를 1씩 증가
			}
            
            
            SubmitAnswer submitAnswer = new SubmitAnswer();
            submitAnswer.setAnswer(inputAnswer);
            submitAnswer.setQuestionNumber(testAnswer.getQuestionNumber());
            submitAnswer.setScore(getScore);
            answers.add(submitAnswer);
            
        } // end of for------------------------------------------------------------
        
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



	// 시험 삭제 시 몽고db delete
	@Override
	public void delete_mongDB(String mongo_id) {
		examAnswerRepository.deleteById(mongo_id);
		
	}


	// 시험 삭제 시 오라클 delete
	@Override
	public int delete_exam_schedule(String schedule_seq) {
		
		int n1 = scheduleDao.delete_tbl_exam(schedule_seq);
		
		int n2 = 0;
		
		if(n1 == 1) {
			n2 = scheduleDao.delete_exam_tbl_schedule(schedule_seq);
		}
		
		return n2;
	}


}
