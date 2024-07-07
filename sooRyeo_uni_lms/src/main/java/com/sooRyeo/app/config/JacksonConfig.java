package com.sooRyeo.app.config;

import com.fasterxml.jackson.databind.ObjectMapper;

public class JacksonConfig {
	
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper;
    }

}
