package com.sooRyeo.app.mongo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MessageDto {
    private String msgType;
    private String content;
    private Integer senderId;
    private String SenderType;


}
