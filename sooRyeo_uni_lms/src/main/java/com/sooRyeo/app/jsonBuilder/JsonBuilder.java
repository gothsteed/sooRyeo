package com.sooRyeo.app.jsonBuilder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class JsonBuilder {
	
	private final ObjectMapper objectMapper;
	
	@Autowired
	public JsonBuilder(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}
	
	public String toJson(Object object) {
		try {
			return objectMapper.writeValueAsString(object);
		}catch (JsonProcessingException e) {
			e.printStackTrace();
			return "{}";
		}
		
	}

}
