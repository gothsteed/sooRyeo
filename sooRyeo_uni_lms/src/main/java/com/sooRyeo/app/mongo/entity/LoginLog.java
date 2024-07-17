package com.sooRyeo.app.mongo.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Getter
@Setter
@Document(collection = "loginLog")
public class LoginLog {
    @Id
    private String id;
    private Integer userid;
    private String MemberType;
    private LocalDateTime timestamp;
}
