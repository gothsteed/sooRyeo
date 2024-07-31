package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.mongo.entity.AlertLecture;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlertLectureRepository extends MongoRepository<AlertLecture, String> {
}
