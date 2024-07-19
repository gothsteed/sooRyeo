package com.sooRyeo.app.mongo.service;

import org.springframework.http.ResponseEntity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ChatService {
    ResponseEntity<String> createChatRoom(HttpServletRequest request, HttpServletResponse response, Integer scheduleSeq);

    ResponseEntity<String> showChatRoom(HttpServletRequest request, HttpServletResponse response);
}
