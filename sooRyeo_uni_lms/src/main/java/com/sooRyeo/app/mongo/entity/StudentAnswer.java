package com.sooRyeo.app.mongo.entity;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document("studentExamAnswer")
public class StudentAnswer {
    @Id
    private String id;
    private String studentId;
    private String examAnswersId;
    private List<Answer> answers;




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


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getExamAnswersId() {
        return examAnswersId;
    }

    public void setExamAnswersId(String examAnswersId) {
        this.examAnswersId = examAnswersId;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }
}
