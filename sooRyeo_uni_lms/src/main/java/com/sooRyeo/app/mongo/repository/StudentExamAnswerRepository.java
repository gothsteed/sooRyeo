package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.StudentAnswer;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentExamAnswerRepository extends MongoRepository<StudentAnswer, String> {
    List<StudentAnswer> findAllByExamAnswersId(String answerMongoId);
}
