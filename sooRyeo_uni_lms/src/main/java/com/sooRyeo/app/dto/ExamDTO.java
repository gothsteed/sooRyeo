package com.sooRyeo.app.dto;


import org.springframework.web.multipart.MultipartFile;

public class ExamDTO {
   
	private Integer fk_schedule_seq;
    private Integer fk_course_seq;
    private String answer_mongo_id;
    private Integer question_count;
    private Integer total_score;
    private String file_name;
    private String original_file_name;
    
	private MultipartFile attach;
    
    

	
	
    public Integer getFk_schedule_seq() {
		return fk_schedule_seq;
	}

	public void setFk_schedule_seq(Integer fk_schedule_seq) {
		this.fk_schedule_seq = fk_schedule_seq;
	}

	public Integer getFk_course_seq() {
		return fk_course_seq;
	}

	public void setFk_course_seq(Integer fk_course_seq) {
		this.fk_course_seq = fk_course_seq;
	}

	public String getAnswer_mongo_id() {
		return answer_mongo_id;
	}

	public void setAnswer_mongo_id(String answer_mongo_id) {
		this.answer_mongo_id = answer_mongo_id;
	}

	public Integer getQuestion_count() {
		return question_count;
	}

	public void setQuestion_count(Integer question_count) {
		this.question_count = question_count;
	}

	public Integer getTotal_score() {
		return total_score;
	}

	public void setTotal_score(Integer total_score) {
		this.total_score = total_score;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getOriginal_file_name() {
		return original_file_name;
	}

	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}

	public MultipartFile getAttach() {
        return attach;
    }

    public void setAttach(MultipartFile attach) {
        this.attach = attach;
    }
    
	
	
	
    
}

import java.util.List;

import com.sooRyeo.app.domain.Exam;

import com.sooRyeo.app.mongo.entity.Answer;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExamDTO {

	private Exam exam;
	private List<Answer> answers;
	private String answer_mongo_id;

	
	
}
