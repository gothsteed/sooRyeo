package com.sooRyeo.app.mongo.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Document("studentExamAnswer")
public class StudentAnswer {
    @Id
    private String id;
    private Integer studentId;
    private String studentName;
    private String examAnswersId;
    private List<SubmitAnswer> answers;
    private Integer score;
    private Integer totalScore;
    private int correctCount;
    private int wrongSCount;
    private Integer courseSeq;

    public StudentAnswer(Integer studentId, String studentName, String examAnswersId, List<SubmitAnswer> answers, Integer score, Integer totalScore, int correctCount, int wrongSCount, Integer courseSeq) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.examAnswersId = examAnswersId;
        this.answers = answers;
        this.score = score;
        this.totalScore = totalScore;
        this.correctCount = correctCount;
        this.wrongSCount = wrongSCount;
        this.courseSeq = courseSeq;
    }

    public String getQuestionAnswer(int questionNumber) {
        return answers.get(questionNumber-1).getAnswer();
    }


 /*   public static class Answer {
        @Id
        private ObjectId questionId;
        private int questionNumber;
        private int answer;
        private int score;


        // Getters and setters
        public ObjectId getQuestionId() {
            return questionId;
        }

        public void setQuestionId(ObjectId questionId) {
            this.questionId = questionId;
        }

        public int getQuestionNumber() {
            return questionNumber;
        }

        public void setQuestionNumber(int questionNumber) {
            this.questionNumber = questionNumber;
        }

        public int getAnswer() {
            return answer;
        }

        public void setAnswer(int answer) {
            this.answer = answer;
        }

        public int getScore() {
            return score;
        }

        public void setScore(int score) {
            this.score = score;
        }
    }*/

}
