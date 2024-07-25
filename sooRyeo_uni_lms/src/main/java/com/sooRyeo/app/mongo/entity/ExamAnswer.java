package com.sooRyeo.app.mongo.entity;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document(collection = "examAnswers")
public class ExamAnswer {
    @Id
    private ObjectId id;
    private List<Answer> answers;

    // Getters and setters
    public ObjectId getId() {
        return id;
    }

    public void setId(ObjectId id) {
        this.id = id;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    // Inner class for Answer
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