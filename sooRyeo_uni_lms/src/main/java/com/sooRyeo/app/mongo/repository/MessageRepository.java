package com.sooRyeo.app.mongo.repository;

import com.sooRyeo.app.mongo.entity.Message;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends MongoRepository<Message, String> {

    List<Message> findAllByRoomId(String roomId);
}
