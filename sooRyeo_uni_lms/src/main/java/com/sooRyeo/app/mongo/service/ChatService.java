package com.sooRyeo.app.mongo.service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ChatService {
    ResponseEntity<String> createChatRoom(HttpServletRequest request, HttpServletResponse response, Integer scheduleSeq);

    ResponseEntity<String> showChatRoom(HttpServletRequest request, HttpServletResponse response);

    ResponseEntity<String> deleteChatRoom(HttpServletRequest request, HttpServletResponse response);

    ModelAndView getChatPage(HttpServletRequest request, ModelAndView mav);

    ResponseEntity<String> getStudentUnreadMessageCount(HttpServletRequest request, HttpServletResponse response);

    ResponseEntity<String> getProfessorUnreadMessageCount(HttpServletRequest request, HttpServletResponse response);
}
