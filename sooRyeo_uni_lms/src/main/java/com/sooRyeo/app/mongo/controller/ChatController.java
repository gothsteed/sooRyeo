package com.sooRyeo.app.mongo.controller;


import com.sooRyeo.app.mongo.service.ChatService;
import org.apache.poi.ss.formula.functions.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
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
        mav.setViewName("");
        return mav;
    }

}
