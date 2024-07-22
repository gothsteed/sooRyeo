package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.ChatRoom;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChatRoomRepository extends MongoRepository<ChatRoom, String> {

    List<ChatRoom> findAllByProfessorId(Integer profId);

    List<ChatRoom> findAllByStudentId(Integer studentId);
}
