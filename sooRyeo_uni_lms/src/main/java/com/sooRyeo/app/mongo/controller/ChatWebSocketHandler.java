package com.sooRyeo.app.mongo.controller;

import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.mongo.dto.MessageDto;
import com.sooRyeo.app.mongo.entity.MemberType;
import com.sooRyeo.app.mongo.entity.Message;
import com.sooRyeo.app.mongo.entity.MessageType;
import com.sooRyeo.app.mongo.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.lang.reflect.Member;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;


public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final JsonBuilder jsonBuilder;
    private final MessageRepository messageRepository;

    @Autowired
    public ChatWebSocketHandler(JsonBuilder jsonBuilder, MessageRepository messageRepository) {
        this.jsonBuilder = jsonBuilder;
        this.messageRepository = messageRepository;
    }

    private final Map<String, List<WebSocketSession>> roomSessions = new HashMap<>();



    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

        System.out.println(session.getAttributes().get("roomId"));
        String roomId = (String) session.getAttributes().get("roomId");

        if(!roomSessions.containsKey(roomId)) {
            roomSessions.put(roomId, new ArrayList<>());
        }
        roomSessions.get(roomId).add(session);


        List<Message> previousMessages = messageRepository.findAllByRoomId(roomId);

        for (Message previousMessage : previousMessages) {
            MessageDto messageDto = new MessageDto();
            messageDto.setMessageType(previousMessage.getMsgType());
            messageDto.setContent(previousMessage.getContent());
            messageDto.setName(previousMessage.getSender());
            messageDto.setSenderId(previousMessage.getSenderId());
            messageDto.setTimestamp(previousMessage.getTimestamp().toString());
            messageDto.setSenderType(previousMessage.getSenderType());
            session.sendMessage(new TextMessage(jsonBuilder.toJson(messageDto)));
        }

        MessageDto messageDto = null;

        if(session.getAttributes().get("loginuser") instanceof Student) {
            Student loginuser = ((Student) session.getAttributes().get("loginuser"));
            messageDto = new MessageDto();
            messageDto.setMessageType(MessageType.ALERT.toString());
            messageDto.setContent(loginuser.getName() + " 학생님이 입장하였습니다");
            messageDto.setTimestamp(LocalDateTime.now().toString());

        }else if (session.getAttributes().get("loginuser") instanceof Professor) {
            Professor loginuser = ((Professor) session.getAttributes().get("loginuser"));
            messageDto = new MessageDto();
            messageDto.setMessageType(MessageType.ALERT.toString());
            messageDto.setContent(loginuser.getName() + " 교수님이 입장하였습니다");
            messageDto.setTimestamp(LocalDateTime.now().toString());

        }

        if(messageDto == null) {
            return;
        }

        for(WebSocketSession connected : roomSessions.get(roomId)) {
            connected.sendMessage(new TextMessage(jsonBuilder.toJson(messageDto)));
        }

        messageRepository.save(new Message(MessageType.ALERT.toString(),
               null,
                null,
                null,
                messageDto.getContent(),
                roomId,
                LocalDateTime.now()));
    }


    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String roomId = (String) session.getAttributes().get("roomId");
        MessageDto messageDto = jsonBuilder.fromJson(message.getPayload(), MessageDto.class);

        if(session.getAttributes().get("loginuser") instanceof Student) {
            Student loginuser = ((Student) session.getAttributes().get("loginuser"));
            messageRepository.save(new Message(messageDto.getMessageType(),
                    MemberType.STUDENT.toString(),
                    loginuser.getStudent_id(),
                    loginuser.getName(),
                    messageDto.getContent(),
                    roomId,
                    LocalDateTime.now()));

            messageDto.setSenderId(loginuser.getStudent_id());
            messageDto.setName(loginuser.getName());
            messageDto.setTimestamp(LocalDate.now().toString());
            messageDto.setSenderType("STUDENT");
        }else if (session.getAttributes().get("loginuser") instanceof Professor) {
            Professor loginuser = ((Professor) session.getAttributes().get("loginuser"));
            messageRepository.save(new Message(messageDto.getMessageType(),
                    MemberType.PROFESSOR.toString(),
                    loginuser.getProf_id(),
                    loginuser.getName(),
                    messageDto.getContent(),
                    roomId,
                    LocalDateTime.now()));

            messageDto.setSenderId(loginuser.getProf_id());
            messageDto.setName(loginuser.getName());
            messageDto.setTimestamp(LocalDate.now().toString());
            messageDto.setSenderType("PROFESSOR");
        }


        for(WebSocketSession connected : roomSessions.get(roomId)) {
            if(connected.getId().equals(session.getId())) {
                continue;
            }
            connected.sendMessage(message);
        }

    }


    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomId = (String) session.getAttributes().get("roomId");
        MessageDto messageDto = null;

        if(session.getAttributes().get("loginuser") instanceof Student) {
            Student loginuser = ((Student) session.getAttributes().get("loginuser"));
            messageDto = new MessageDto();

            messageDto.setMessageType(MessageType.ALERT.toString());
            messageDto.setContent(loginuser.getName() + "님이 퇴장하였습니다");
            messageDto.setName(loginuser.getName());


        }else if (session.getAttributes().get("loginuser") instanceof Professor) {
            Professor loginuser = ((Professor) session.getAttributes().get("loginuser"));
            messageDto = new MessageDto();
            messageDto.setMessageType(MessageType.ALERT.toString());
            messageDto.setContent(loginuser.getName() + "님이 퇴장하였습니다");
            messageDto.setName(loginuser.getName());
        }

        if(messageDto == null) {
            return;
        }

        for(WebSocketSession connected : roomSessions.get(roomId)) {
            connected.sendMessage(new TextMessage(jsonBuilder.toJson(messageDto)));
        }

        List<WebSocketSession> sessions = roomSessions.get(roomId);
        if (sessions != null) {
            sessions.removeIf(s -> s.getId().equals(session.getId()));

            if (sessions.isEmpty()) {
                roomSessions.remove(roomId);
            }
        }


        messageRepository.save(new Message(MessageType.ALERT.toString(),
                null,
                null,
                null,
                messageDto.getContent(),
                roomId,
                LocalDateTime.now()));

    }


}
