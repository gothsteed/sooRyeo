package com.sooRyeo.app.mongo.handshaker;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.URI;
import java.util.Map;

public class ChatroomHandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    private HttpSession getSession(ServerHttpRequest request) {
        //return ((HttpServletRequest) request).getSession();
        return (HttpSession) (((ServletServerHttpRequest) request).getServletRequest().getSession());
    }

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {

        super.beforeHandshake(request, response, wsHandler, attributes);

        HttpSession session = getSession(request);
        if(session == null) {
            return true;
        }

        attributes.put("loginuser", session.getAttribute("loginuser"));
        URI uri = request.getURI();
        String query = uri.getQuery();

        if(query == null) {
            return true;
        }

        String[] params = query.split("&");
        for(String param : params) {
            String[] data = param.split("=");
            if(data.length == 2) {
                attributes.put(data[0], data[1]);
            }
        }

        return true;
    }


}
