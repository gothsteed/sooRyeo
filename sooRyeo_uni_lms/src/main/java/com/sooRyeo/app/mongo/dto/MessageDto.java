package com.sooRyeo.app.mongo.dto;

public class MessageDto {
    private String messageType;
    private String content;
    private String name;
    private Integer senderId;
    private String SenderType;
    private String timestamp;

    public String getMessageType() {
        return messageType;
    }

    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSenderId() {
        return senderId;
    }

    public void setSenderId(Integer senderId) {
        this.senderId = senderId;
    }

    public String getSenderType() {
        return SenderType;
    }

    public void setSenderType(String senderType) {
        SenderType = senderType;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
