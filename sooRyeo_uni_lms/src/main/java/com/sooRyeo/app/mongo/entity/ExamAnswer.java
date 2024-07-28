package com.sooRyeo.app.mongo.entity;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document(collection = "examAnswers")
public class ExamAnswer {
    @Id
    private String id;
    private List<Answer> answers;
    private List<Answer> score;

    public List<Answer> getScore() {
		return score;
	}

	public void setScore(List<Answer> score) {
		this.score = score;
	}

	// Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public int getQuestionAnswer(int questionNumber) {
        return  answers.get(questionNumber - 1).getAnswer();
    }

    // Inner class for Answer
/*    public static class Answer {
        @Id
        private String questionId;
        private int questionNumber;
        private int answer;
        private int score;

        // Getters and setters
        public String getQuestionId() {
            return questionId;
        }

        public void setQuestionId(String questionId) {
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