package com.sooRyeo.app.mongo.controller;


import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.mongo.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequireLogin(type = {Student.class, Process.class})
public class ChatController {

    @Autowired
    private ChatService chatService;

    @PostMapping(value = "/chat/start.lms", produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> startChat(HttpServletRequest request, HttpServletResponse response, @RequestParam Integer schedule_seq) {

        return chatService.createChatRoom(request, response, schedule_seq);
    }

    @PostMapping(value = "/chat/currentChatRoomREST.lms", produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> showChatRoom(HttpServletRequest request, HttpServletResponse response) {

        return chatService.showChatRoom(request, response);
    }


    @PostMapping(value = "/chat/deleteChatRoomREST.lms", produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> deleteChatRoom(HttpServletRequest request, HttpServletResponse response) {

        return chatService.deleteChatRoom(request, response);
    }


    @GetMapping(value = "/chat.lms")
    public ModelAndView chattingPage(HttpServletRequest request, ModelAndView mav) {

        return chatService.getChatPage(request, mav);
    }

    @GetMapping(value = "/student/chatAlertREST.lms")
    public ResponseEntity<String> getStudentUnreadMessageCount(HttpServletRequest request, HttpServletResponse response) {
        return chatService.getStudentUnreadMessageCount(request, response);
    }

    @GetMapping(value = "/professor/chatAlertREST.lms")
    public ResponseEntity<String> getProfessorUnreadMessageCount(HttpServletRequest request, HttpServletResponse response) {
        return chatService.getProfessorUnreadMessageCount(request, response);
    }



}
