package com.sooRyeo.app.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ScoreDto {
    private Integer studentId;
    private String studentName;
    private int correctCount;
    private int wrongSCount;
    private int score;

}
