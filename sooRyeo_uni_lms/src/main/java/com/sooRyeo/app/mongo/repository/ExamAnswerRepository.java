package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.ExamAnswer;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExamAnswerRepository extends MongoRepository<ExamAnswer, String> {

	List<ExamAnswer> findAllById(String answer_mongo_id);
}
