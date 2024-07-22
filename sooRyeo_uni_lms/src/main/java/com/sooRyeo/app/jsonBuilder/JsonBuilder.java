package com.sooRyeo.app.jsonBuilder;

import com.fasterxml.jackson.databind.JsonMappingException;
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

	public <T> T fromJson(String json, Class<T> clazz) {
		 try {
			 return  objectMapper.readValue(json, clazz);
		 }
		 catch (JsonProcessingException e) {
			 e.printStackTrace();
			 return null;
		 }

    }

}
