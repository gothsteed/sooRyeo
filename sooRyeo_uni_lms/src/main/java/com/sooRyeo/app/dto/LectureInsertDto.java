package com.sooRyeo.app.dto;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/*@AllArgsConstructor
@NoArgsConstructor*/
public class LectureInsertDto {

    private Integer course_seq;
    private String title;
    private String content;
    private LocalDateTime startDateTime;
    private LocalDateTime endDateTime;
    private String originalVideoTitle;
    private String uploadVideoTitle;
    private String originalAttachName;
    private String uploadAttachName;

    public LectureInsertDto() {
    }

    public LectureInsertDto(Integer course_seq, String title, String content, LocalDateTime startDateTime, LocalDateTime endDateTime, String originalVideoTitle, String uploadVideoTitle, String originalAttachName, String uploadAttachName) {
        this.course_seq = course_seq;
        this.title = title;
        this.content = content;
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
        this.originalVideoTitle = originalVideoTitle;
        this.uploadVideoTitle = uploadVideoTitle;
        this.originalAttachName = originalAttachName;
        this.uploadAttachName = uploadAttachName;
    }

    public Integer getCourse_seq() {
        return course_seq;
    }

    public void setCourse_seq(Integer course_seq) {
        this.course_seq = course_seq;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(LocalDateTime startDateTime) {
        this.startDateTime = startDateTime;
    }

    public LocalDateTime getEndDateTime() {
        return endDateTime;
    }

    public void setEndDateTime(LocalDateTime endDateTime) {
        this.endDateTime = endDateTime;
    }

    public String getOriginalVideoTitle() {
        return originalVideoTitle;
    }

    public void setOriginalVideoTitle(String originalVideoTitle) {
        this.originalVideoTitle = originalVideoTitle;
    }

    public String getUploadVideoTitle() {
        return uploadVideoTitle;
    }

    public void setUploadVideoTitle(String uploadVideoTitle) {
        this.uploadVideoTitle = uploadVideoTitle;
    }

    public String getOriginalAttachName() {
        return originalAttachName;
    }

    public void setOriginalAttachName(String originalAttachName) {
        this.originalAttachName = originalAttachName;
    }

    public String getUploadAttachName() {
        return uploadAttachName;
    }

    public void setUploadAttachName(String uploadAttachName) {
        this.uploadAttachName = uploadAttachName;
    }
}
