package com.sooRyeo.app.dto;

import java.util.List;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.mongo.entity.ExamAnswer.Answer;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExamDTO {

	private Exam exam;
	private List<Answer> answers;
	private String answer_mongo_id;

	
	
}
