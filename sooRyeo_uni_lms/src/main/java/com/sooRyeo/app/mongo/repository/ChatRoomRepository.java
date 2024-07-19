package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.ChatRoom;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ChatRoomRepository extends MongoRepository<ChatRoom, String> {

    List<ChatRoom> findAllByProfessorId(Integer profId);
}
