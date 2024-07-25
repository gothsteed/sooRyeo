package com.sooRyeo.app.mongo.entity;

import lombok.Getter;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Getter
@Document("studentExamAnswer")
public class StudentAnswer {
    @Id
    private String id;
    private Integer studentId;
    private String StudentName;
    private String examAnswersId;
    private List<Answer> answers;
    private Integer score;
    private Integer totalScore;
    private int correctCount;
    private int wrongSCount;



    public static class Answer {
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
    }

}
