package com.sooRyeo.app.mongo.entity;


import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "alertLecture")
public class AlertLecture {
    @Id
    private String id;
    private Integer lectureId;
    private String lectureName;
    private Integer StudentId;



}
