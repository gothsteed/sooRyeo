package com.sooRyeo.app.mongo.entity;


import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Document(collection = "alertLecture")
public class AlertLecture {
    @Id
    private String id;
    private Integer lectureId;
    private String lectureName;
    private Integer studentId;
    private String ProfessorName;



}
