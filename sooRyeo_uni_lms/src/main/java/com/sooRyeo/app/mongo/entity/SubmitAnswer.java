package com.sooRyeo.app.mongo.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;

@Getter
@Setter
@NoArgsConstructor
public class SubmitAnswer {
	@Id
    private String questionId;
    private Integer questionNumber;
    private String answer;
    private Integer score;

    public SubmitAnswer(Integer questionNumber, String answer, Integer score) {
        this.questionNumber = questionNumber;
        this.answer = answer;
        this.score = score;
    }
}
