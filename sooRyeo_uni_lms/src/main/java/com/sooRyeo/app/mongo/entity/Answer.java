package com.sooRyeo.app.mongo.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;

@Getter
@Setter
public class Answer {
	@Id
    private String questionId;
    private Integer questionNumber;
    private Integer answer;
    private Integer score;

}
