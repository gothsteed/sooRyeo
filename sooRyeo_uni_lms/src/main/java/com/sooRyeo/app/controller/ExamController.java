package com.sooRyeo.app.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.mongo.entity.Answer;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.mongo.entity.Answer;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.service.ExamService;


@Controller
public class ExamController {

    @Autowired
    private ExamService examService;
    
	@Autowired
	private FileManager fileManager;
    
    
	// 출제하기 버튼 클릭 시  데이터 insert
	@PostMapping("exam_write.lms")
	public ModelAndView exam_write(HttpServletRequest request, ModelAndView mav, MultipartHttpServletRequest mrequest, ExamDTO examdto) throws Exception {
		
		
		// === 첨부파일 업로드 시작 === //
		MultipartFile attach = examdto.getAttach();
		String newFileName = "";
		String originalFilename = "";
		
		if( !attach.isEmpty() ) {
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			// System.out.println("확인용 webapp 의 절대경로 => " + root); 
			// ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\
								
			String path = root+"resources"+File.separator+"files";
			// System.out.println("확인용 path => " + path);
			// ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
			
			byte[] bytes = null;
			
			try {
				bytes = attach.getBytes();
				
				originalFilename = attach.getOriginalFilename();
				// System.out.println("확인용 originalFilename => " + originalFilename); 
				// ~~~ 확인용 originalFilename => 2024년도 국가기술자격 검정 시행계획(대외 공고).pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// System.out.println("확인용 newFileName " + newFileName);
				// 확인용 newFileName 20240714220735250112916872200.pdf
				
				examdto.setFile_name(newFileName);
				examdto.setOriginal_file_name(originalFilename);
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}
		// === 첨부파일 업로드 끝  === //
		
		
		// 몽고DB insert
		String[] arr_answer = request.getParameterValues("answer");
		String[] arr_score = request.getParameterValues("score");
		String[] arr_questionNumber = request.getParameterValues("questionNumber");
		
		// 오라클 insert
		String test_type = request.getParameter("test_type");
		String test_start_time = request.getParameter("test_start_time");
		String test_end_time = request.getParameter("test_end_time");
		int question_count = request.getParameterValues("answer").length; // total 문제 수
		String course_seq = request.getParameter("course_seq");
		//String test_type = request.getParameter("test_type"); // pdf 파일명
		
		List<Answer> answer_list = new ArrayList<>();
		
		int total_score = 0;
		
		for(int i=0; i<arr_answer.length; i++) {
			
			Answer answer =  new Answer();

			answer.setAnswer(Integer.parseInt(arr_answer[i]));
			answer.setScore(Integer.parseInt(arr_score[i]));
			answer.setQuestionNumber(Integer.parseInt(arr_questionNumber[i]));

			answer_list.add(answer);

			total_score +=  Integer.parseInt(arr_score[i]);
			
		}
		
		
		ExamAnswer examAnswer = new ExamAnswer();
		examAnswer.setAnswers(answer_list);
	
		ExamAnswer insert_examAnswer = examService.insert_examAnswer(examAnswer);
		
		String answer_id = insert_examAnswer.getId();
		
		int n = examService.insert_exam_schedule(test_type, test_start_time, test_end_time, question_count, answer_id, course_seq, total_score, examdto);
		
		if(n==1 && answer_id != null) {
			

			mav.addObject("message", "시험 출제가 완료되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/professor/courseDetail.lms?course_seq="+course_seq);
			mav.setViewName("msg");
		
		}
		
		return mav;

	}

    


	@RequireLogin(type = {Student.class})
	@PostMapping("/student/exam/test.lms")
	public ModelAndView test(ModelAndView mav, HttpServletRequest request) throws NumberFormatException , NullPointerException {
		int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq"));

		return examService.takeExam(mav, request, schedule_seq);
	}
	
	@RequireLogin(type = {Student.class})
	@PostMapping("/exam/SelectAnswer.lms")
	public ModelAndView selectAnswer(ModelAndView mav, HttpServletRequest request) {
		
		String schedule_seq = request.getParameter("schedule_seq");
		
		int selCount = Integer.parseInt(request.getParameter("selCount"));
		
		Exam getCourse_seq = examService.getCourse_seq(schedule_seq); // 강의 시퀀스를 불러오는 메소드
		
		int course_seq = getCourse_seq.getFk_course_seq();
		
		List<String> inputAnswers = new ArrayList<>();
		
		for(int i=1; i<selCount+1; i++) {
			
			String input = request.getParameter(String.valueOf(i));
			
			String selectAnswer = input;
			
			if (selectAnswer != null) {
				inputAnswers.add(selectAnswer);
	        }
		}
		
		examService.insertMongoStudentExamAnswer(inputAnswers, schedule_seq , request, course_seq);
		
		mav.addObject("message", "답안지 제출이 완료되었습니다.");
		mav.addObject("loc", request.getContextPath()+"/student/exam.lms?course_seq="+course_seq); // 여기서 course_seq를 어떻게 보내야할지 고민중. post 방시인디
		mav.setViewName("msg");

		return mav;
	}


	@RequireLogin(type = {Professor.class})
	@GetMapping(value = "/professor/exam.lms")
	public ModelAndView professorExam(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		return examService.getExamPage(mav, request, response);
	}

	@RequireLogin(type = {Professor.class})
	@GetMapping("/professor/exam/result.lms")
	public ModelAndView getExamResultPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException {
		//todo : error handler 추가하기
		int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq") == null? "-1" : request.getParameter("schedule_seq"));
		mav.addObject("schedule_seq", schedule_seq);
		mav.setViewName("exam/examResult");
		return mav;
	}

	@RequireLogin(type = {Professor.class, Student.class})
	@GetMapping(value="/professor/exam/resultREST.lms", produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> getExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		return examService.getExamResultData(mav, request, response);
	}

	@RequireLogin(type = {Student.class})
	@GetMapping(value = "/student/exam.lms")
	public ModelAndView studentExam(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException {
		return examService.getExamPage(mav, request, response);
	}


	@RequireLogin(type = {Student.class})
	@GetMapping("/student/exam/result.lms")
	public ModelAndView getStudentExamResult(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException {
		int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq") == null? "-1" : request.getParameter("schedule_seq"));
		mav.addObject("schedule_seq", schedule_seq);
		mav.setViewName("exam/examResult");
		return mav;
	}


	@RequireLogin(type = {Student.class})
	@GetMapping("/student/exam/resultREST.lms")
	public ResponseEntity<String> getStudentExamResultData(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		return examService.getStudentExamResultData(mav, request, response);
	}
	
	
	// 교수 시험출제 뷰단
	@RequireLogin(type = {Professor.class})
	@GetMapping(value = "/professor/professor_exam.lms")
	public ModelAndView professor_exam(ModelAndView mav, HttpServletRequest request) {
		
		String course_seq = request.getParameter("course_seq");
		
		// 시험 출제 뷰단에 과목명 보여주기
		String  coures_name = examService.select_coures_name(course_seq);
		
		mav.addObject("course_seq", course_seq);
		mav.addObject("coures_name", coures_name);
		mav.setViewName("exam/professor_exam");

		return mav;
	}
	
	
	
	// 시험 수정 뷰단
	@RequireLogin(type = {Professor.class})
	@PostMapping(value = "/professor/professor_exam_update.lms")
	public ModelAndView professor_exam_update(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

		String course_seq = request.getParameter("course_seq");
		String schedule_seq = request.getParameter("schedule_seq");

		return examService.getExamUpdatePage(request, response, mav, course_seq, schedule_seq);
	}
	
	
	
	
	// 수정하기 버튼 클릭 시  데이터 update
	@PostMapping("/exam_update.lms")
	public ModelAndView exam_update(HttpServletRequest request, ModelAndView mav, MultipartHttpServletRequest mrequest, ExamDTO examdto) throws Exception {
		
		
		MultipartFile attach = examdto.getAttach();
		
		// 시험지를 변경한다면
		if( !attach.isEmpty() ) {
			
			String orgFile = request.getParameter("file_name");
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			// System.out.println("확인용 webapp 의 절대경로 => " + root); 
			// ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\
								
			String path = root+"resources"+File.separator+"files";
			// System.out.println("확인용 path => " + path);
			// ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
			
			
			if(orgFile != null) {
				// 파일 변경을 위해 기존에 올려뒀던 파일 지우기
				fileManager.doFileDelete(orgFile, path);
			}
			
		
		String newFileName = "";
		String originalFilename = "";
		
			byte[] bytes = null;
			
			try {
				bytes = attach.getBytes();
				
				originalFilename = attach.getOriginalFilename();

				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

				examdto.setFile_name(newFileName);
				examdto.setOriginal_file_name(originalFilename);
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}

		// === 첨부파일 업로드 끝  === //
		
		
		// 몽고DB update
		String[] arr_answer = request.getParameterValues("answer");
		String[] arr_score = request.getParameterValues("score");
		String[] arr_questionNumber = request.getParameterValues("questionNumber");
		String answer_mongo_id = request.getParameter("answer_mongo_id");
		
		/*
		for(int i =0; i<arr_score.length; i++) {
			  System.out.println(arr_score[i]); 
		}
		*/
		
		// 오라클 update
		String test_type = request.getParameter("test_type");
		String test_start_time = request.getParameter("test_start_time");
		String test_end_time = request.getParameter("test_end_time");
		int question_count = request.getParameterValues("answer").length; // total 문제 수
		String schedule_seq = request.getParameter("schedule_seq");
		String course_seq = request.getParameter("course_seq");
		//String test_type = request.getParameter("test_type"); // pdf 파일명
		
		List<Answer> answer_list = new ArrayList<>();
		
		int total_score = 0;
		
		for(int i=0; i<arr_answer.length; i++) {
			
				Answer answer =  new Answer();
			
				answer.setAnswer(Integer.parseInt(arr_answer[i]));
				answer.setScore(Integer.parseInt(arr_score[i]));    
				answer.setQuestionNumber(Integer.parseInt(arr_questionNumber[i]));
				
				answer_list.add(answer);
				
				total_score +=  Integer.parseInt(arr_score[i]);
			
		}
		
		// 몽고db  update
		ExamAnswer update_examAnswer = examService.update_examAnswer(answer_list, answer_mongo_id);
		
		// 오라클 db update
		int  n = examService.update_exam_schedule(schedule_seq, test_type, test_start_time, test_end_time, question_count, total_score, examdto);
		
		if(n==1) {

			mav.addObject("message", "시험 수정이 완료되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/professor/courseDetail.lms?course_seq="+course_seq);
			mav.setViewName("msg");
		
		}
		
		return mav;

	}

	@RequireLogin(type = {Student.class})
	@GetMapping("/student/exam/wait.lms")
	public ModelAndView waitExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws NumberFormatException {
		int schedule_seq = Integer.parseInt(request.getParameter("schedule_seq"));

		return examService.getWaitExamPage(mav, request, response, schedule_seq);
	}
	
	
	// 시험 삭제하기
	@PostMapping("/exam_delete.lms")
	public ModelAndView exam_delete(HttpServletRequest request, ModelAndView mav, MultipartHttpServletRequest mrequest, ExamDTO examdto) throws Exception {
		
		String schedule_seq = request.getParameter("schedule_seq");
		String mongo_id = request.getParameter("mongo_id");
		String course_seq = request.getParameter("course_seq");
		
		String  getFile_name = examdto.getFile_name();
		
		if( !getFile_name.isEmpty() ) {
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
					
			String path = root+"resources"+File.separator+"files";
			
			// 파일 변경을 위해 기존에 올려뒀던 파일 지우기
			fileManager.doFileDelete(getFile_name, path);
			
		}
		
		// 시험 삭제 시 몽고db delete
		examService.delete_mongDB(mongo_id);
		
		// 시험 삭제 시 오라클 delete
		int n = examService.delete_exam_schedule(schedule_seq);
		
		if(n==1) {
			
			mav.addObject("message", "시험 삭제가 완료되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/professor/courseDetail.lms?course_seq="+course_seq);
			mav.setViewName("msg");	
		}
		
		return mav;
	}
	
	
	
}

