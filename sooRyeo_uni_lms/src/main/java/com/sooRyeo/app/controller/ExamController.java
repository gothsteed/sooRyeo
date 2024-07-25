package com.sooRyeo.app.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.dto.ExamDTO;
import com.sooRyeo.app.mongo.entity.ExamAnswer;
import com.sooRyeo.app.mongo.entity.ExamAnswer.Answer;
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
		
		// System.out.println(attach);
		// MultipartFile[field="attach", filename=2024년도 국가기술자격 검정 시행계획(대외 공고).pdf, contentType=application/pdf, size=466949]
		
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
				System.out.println("확인용 originalFilename => " + originalFilename); 
				// ~~~ 확인용 originalFilename => 2024년도 국가기술자격 검정 시행계획(대외 공고).pdf
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				System.out.println("확인용 newFileName " + newFileName);
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
		
		
		System.out.println("test_start_time 확인 => " + test_start_time);
		System.out.println("test_end_time 확인 => " + test_end_time);
		
		
		List<Answer> answer_list = new ArrayList<>();
		
		int total_score = 0;
		
		for(int i=0; i<arr_answer.length; i++) {
			
				Answer answer =  new ExamAnswer.Answer();
			
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

    

}
