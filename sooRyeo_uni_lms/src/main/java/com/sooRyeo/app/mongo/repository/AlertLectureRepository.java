package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.mongo.entity.AlertLecture;

import java.util.List;
import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

@Repository
public interface AlertLectureRepository extends MongoRepository<AlertLecture, String> {
	
	List<AlertLecture> findAllByStudentId(Integer student_Id);
	
	void deleteById(String id);
	Optional<AlertLecture> findById(String id);
	
}
