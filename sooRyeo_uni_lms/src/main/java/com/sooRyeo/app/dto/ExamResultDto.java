package com.sooRyeo.app.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.commons.math3.distribution.NormalDistribution;
import org.checkerframework.checker.units.qual.A;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExamResultDto {
    private List<ScoreDto> studuentScoreList;
   // private NormalDistGraphDto distribution;
    private double averageScore;
    private int highestScore;
    private int lowestScore;


}
