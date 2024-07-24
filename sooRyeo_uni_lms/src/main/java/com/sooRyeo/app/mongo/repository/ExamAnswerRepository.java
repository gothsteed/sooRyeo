package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.ExamAnswer;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExamAnswerRepository extends MongoRepository<ExamAnswer, String> {




	
	
	
}
