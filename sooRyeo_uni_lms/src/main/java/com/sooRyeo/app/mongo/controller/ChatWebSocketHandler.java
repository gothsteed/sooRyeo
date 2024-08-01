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

import java.io.IOException;
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


    private void sendPreviousMessage(WebSocketSession session, List<Message> previousMessages, String idKey) throws IOException {

        for (Message message : previousMessages) {
            if(!message.hasRead(idKey)) {
                message.read(idKey);
                messageRepository.save(message);
            }
            session.sendMessage(new TextMessage(jsonBuilder.toJson(message)));
        }

    }

    private Set<String> makeReadStatus(String roomId) {
        Set<String> readStatus = new HashSet<>();

        for(WebSocketSession connected : roomSessions.get(roomId)) {
            if(connected.getAttributes().get("loginuser") instanceof Student) {
                Student loginuser = ((Student) connected.getAttributes().get("loginuser"));
                readStatus.add(MemberType.STUDENT.toString() + loginuser.getStudent_id());

            }
            else if (connected.getAttributes().get("loginuser") instanceof Professor) {
                Professor loginuser = ((Professor) connected.getAttributes().get("loginuser"));
                readStatus.add(MemberType.PROFESSOR.toString() + loginuser.getProf_id());

            }
        }

        return readStatus;
    }


    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

        System.out.println(session.getAttributes().get("roomId"));
        String roomId = (String) session.getAttributes().get("roomId");

        if(!roomSessions.containsKey(roomId)) {
            roomSessions.put(roomId, new ArrayList<>());
        }
        roomSessions.get(roomId).add(session);


        List<Message> previousMessages = messageRepository.findAllByRoomId(roomId);


        Message enterMessage = new Message();

        if(session.getAttributes().get("loginuser") instanceof Student) {
            Student loginuser = ((Student) session.getAttributes().get("loginuser"));
            sendPreviousMessage(session, previousMessages, MemberType.STUDENT.toString() + loginuser.getStudent_id());

            enterMessage.setSenderId(loginuser.getStudent_id());
            enterMessage.setName(loginuser.getName());
            enterMessage.setSenderType(MemberType.STUDENT.toString());
            enterMessage.setMsgType(MessageType.ENTER.toString());
            enterMessage.setContent(loginuser.getName() + " 학생님이 입장하였습니다");
            enterMessage.setTimestamp(LocalDateTime.now());

        }
        else if (session.getAttributes().get("loginuser") instanceof Professor) {
            Professor loginuser = ((Professor) session.getAttributes().get("loginuser"));
            sendPreviousMessage(session, previousMessages, MemberType.PROFESSOR.toString() + loginuser.getProf_id());

            enterMessage.setSenderId(loginuser.getProf_id());
            enterMessage.setName(loginuser.getName());
            enterMessage.setSenderType(MemberType.PROFESSOR.toString());
            enterMessage.setMsgType(MessageType.ENTER.toString());
            enterMessage.setContent(loginuser.getName() + " 교수님이 입장하였습니다");
            enterMessage.setTimestamp(LocalDateTime.now());

        }

        Set<String> readStatus = makeReadStatus(roomId);

        enterMessage.setReadStatus(readStatus);
        enterMessage.setTimestamp(LocalDateTime.now());
        enterMessage.setRoomId(roomId);
        for(WebSocketSession connected : roomSessions.get(roomId)) {
            connected.sendMessage(new TextMessage(jsonBuilder.toJson(enterMessage)));
        }

        messageRepository.save(enterMessage);
    }


    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String roomId = (String) session.getAttributes().get("roomId");
        //MessageDto messageDto = jsonBuilder.fromJson(message.getPayload(), MessageDto.class);


        MessageDto sendMessage = jsonBuilder.fromJson(message.getPayload(), MessageDto.class);
        Set<String> readStatus = makeReadStatus(roomId);


        Message newMessage = null;
        if(session.getAttributes().get("loginuser") instanceof Student) {
            Student loginuser = ((Student) session.getAttributes().get("loginuser"));
            newMessage = new Message(
                    sendMessage.getMsgType(),
                    sendMessage.getSenderType(),
                    sendMessage.getSenderId(),
                    loginuser.getName(),
                    sendMessage.getContent(),
                    roomId,
                    LocalDateTime.now(),
                    readStatus
            );
            messageRepository.save(newMessage);
        }else if (session.getAttributes().get("loginuser") instanceof Professor) {
            Professor loginuser = ((Professor) session.getAttributes().get("loginuser"));
            newMessage = new Message(
                    sendMessage.getMsgType(),
                    sendMessage.getSenderType(),
                    sendMessage.getSenderId(),
                    loginuser.getName(),
                    sendMessage.getContent(),
                    roomId,
                    LocalDateTime.now(),
                    readStatus
            );
            messageRepository.save(newMessage);
        }


        for(WebSocketSession connected : roomSessions.get(roomId)) {
/*            if(connected.getId().equals(session.getId())) {
                continue;
            }*/
            connected.sendMessage(new TextMessage(jsonBuilder.toJson(newMessage)));
        }

    }


    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomId = (String) session.getAttributes().get("roomId");

        String content = null;
        if(session.getAttributes().get("loginuser") instanceof Student) {
            Student loginuser = ((Student) session.getAttributes().get("loginuser"));

            content = loginuser.getName() + "학생이 퇴장하였습니다";


        }else if (session.getAttributes().get("loginuser") instanceof Professor) {
            Professor loginuser = ((Professor) session.getAttributes().get("loginuser"));

            content = loginuser.getName() + "교수가 퇴장하였습니다";
        }

        Set<String> readStatus = makeReadStatus(roomId);
        Message msgEntity = messageRepository.save(new Message(MessageType.EXIT.toString(),
                null,
                null,
                null,
                content,
                roomId,
                LocalDateTime.now(),
                readStatus));

        for(WebSocketSession connected : roomSessions.get(roomId)) {
            if(connected.getId().equals(session.getId())) {
                continue;
            }
            connected.sendMessage(new TextMessage(jsonBuilder.toJson(msgEntity)));
        }

        List<WebSocketSession> sessions = roomSessions.get(roomId);
        if (sessions != null) {
            sessions.removeIf(s -> s.getId().equals(session.getId()));

            if (sessions.isEmpty()) {
                roomSessions.remove(roomId);
            }
        }

    }


}
