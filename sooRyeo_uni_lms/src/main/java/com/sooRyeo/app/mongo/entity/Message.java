package com.sooRyeo.app.mongo.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Document("messages")
public class Message {
    @Id
    private String id;
    private String msgType;
    private String senderType;
    private Integer senderId;
    private String name;
    private String content;
    private String roomId;
    private LocalDateTime timestamp;
    private Set<String> readStatus;

    public Message(String msgType, String senderType, Integer senderId, String name, String content, String roomId, LocalDateTime timestamp, Set<String> readStatus) {
        this.msgType = msgType;
        this.senderType = senderType;
        this.senderId = senderId;
        this.name = name;
        this.content = content;
        this.roomId = roomId;
        this.timestamp = timestamp;
        this.readStatus = readStatus;
    }

    public boolean hasRead(String key) {
        return readStatus.contains(key);
    }

    public void read(String key) {
        readStatus.add(key);
    }




}
