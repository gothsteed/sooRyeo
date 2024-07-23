package com.sooRyeo.app.config;

import com.sooRyeo.app.jsonBuilder.JsonBuilder;
import com.sooRyeo.app.mongo.controller.ChatWebSocketHandler;
import com.sooRyeo.app.mongo.handshaker.ChatroomHandshakeInterceptor;
import com.sooRyeo.app.mongo.repository.MessageRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    private final JsonBuilder jsonBuilder;
    private final MessageRepository messageRepository;

    public WebSocketConfig(JsonBuilder jsonBuilder, MessageRepository messageRepository) {
        this.jsonBuilder = jsonBuilder;
        this.messageRepository = messageRepository;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(chatWebSocketHandler(), "/chat/socket.lms")
                .addInterceptors(new ChatroomHandshakeInterceptor());
    }

    @Bean
    public ChatWebSocketHandler chatWebSocketHandler() {
        return new ChatWebSocketHandler(jsonBuilder, messageRepository);
    }


}
