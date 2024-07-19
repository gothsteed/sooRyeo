package com.sooRyeo.app.mongo.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document("messages")
public class Message {
    @Id
    private Integer schedule_seq;
    private String sender;
    private String content;
    private String roomId;
    private LocalDateTime timestamp;

    public Message() {
    }

    public Message(String sender, String content, String roomId, LocalDateTime timestamp) {
        this.sender = sender;
        this.content = content;
        this.roomId = roomId;
        this.timestamp = timestamp;
    }
}
