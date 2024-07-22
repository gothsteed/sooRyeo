package com.sooRyeo.app.mongo.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document(collection = "chatRooms")
public class ChatRoom {
    @Id
    private String id;
    private Integer studentId;
    private String studentName;
    private Integer professorId;
    private String professorName;
    private String name;
    private String content;

    public ChatRoom() {
    }

    public ChatRoom(Integer studentId, String studentName, Integer professorId, String professorName, String name, String content) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.professorId = professorId;
        this.professorName = professorName;
        this.name = name;
        this.content = content;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public Integer getProfessorId() {
        return professorId;
    }

    public void setProfessorId(Integer professorId) {
        this.professorId = professorId;
    }

    public String getProfessorName() {
        return professorName;
    }

    public void setProfessorName(String professorName) {
        this.professorName = professorName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
