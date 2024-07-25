package com.sooRyeo.app.domain;

import com.sooRyeo.app.mongo.entity.StudentAnswer;
import lombok.AllArgsConstructor;

import java.util.List;

@AllArgsConstructor
public class ExamResult {
    private List<StudentAnswer> studentAnswers;


    public double getAverageScore() {
        int scoreSum = 0;
        for(StudentAnswer studentAnswer : studentAnswers) {
            scoreSum += studentAnswer.getScore();
        }
        return (double)scoreSum / studentAnswers.size();
    }

    public int getHighestScore() {
        int highestScore = Integer.MIN_VALUE;
        for(StudentAnswer studentAnswer : studentAnswers) {
            highestScore = Math.max(studentAnswer.getScore(), highestScore);
        }
        return highestScore;
    }

    public int getLowestScore() {
        int lowestScore = Integer.MAX_VALUE;
        for(StudentAnswer studentAnswer : studentAnswers) {
            lowestScore = Math.min(studentAnswer.getScore(), lowestScore);
        }
        return lowestScore;
    }

    public List<StudentAnswer> getStudentAnswers() {
        return studentAnswers;
    }
/*
    public void getNormalDistributionData() {


    }*/

}
