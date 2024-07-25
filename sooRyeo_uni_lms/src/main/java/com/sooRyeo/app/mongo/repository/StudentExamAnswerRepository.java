package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.StudentAnswer;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface StudentExamAnswerRepository extends MongoRepository<StudentAnswer, String> {
}
