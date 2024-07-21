package com.sooRyeo.app.mongo.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document("messages")
public class Message {
    @Id
    private String id;
    private String msgType;
    private String senderType;
    private Integer senderId;
    private String sender;
    private String content;
    private String roomId;
    private LocalDateTime timestamp;

    public Message() {
    }

    public Message(String msgType, String senderType, Integer senderId, String sender, String content, String roomId, LocalDateTime timestamp) {
        this.msgType = msgType;
        this.senderType = senderType;
        this.senderId = senderId;
        this.sender = sender;
        this.content = content;
        this.roomId = roomId;
        this.timestamp = timestamp;
    }


    public String getId() {
        return id;
    }

    public String getMsgType() {
        return msgType;
    }

    public String getSenderType() {
        return senderType;
    }

    public Integer getSenderId() {
        return senderId;
    }

    public String getSender() {
        return sender;
    }

    public String getContent() {
        return content;
    }

    public String getRoomId() {
        return roomId;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }
}
