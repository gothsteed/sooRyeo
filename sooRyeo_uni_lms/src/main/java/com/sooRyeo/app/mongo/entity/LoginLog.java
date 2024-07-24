package com.sooRyeo.app.mongo.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
/*
@Getter
@Setter*/
@Document(collection = "loginLog")
public class LoginLog {
	
    @Id
    private String id;
    private Integer userid;
    private String memberType;
    private LocalDateTime timestamp;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getMemberType() {
        return memberType;
    }

    public void setMemberType(String memberType) {
    	this.memberType = memberType;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }
}
