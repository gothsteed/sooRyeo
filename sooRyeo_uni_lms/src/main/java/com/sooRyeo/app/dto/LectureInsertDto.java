package com.sooRyeo.app.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class LectureInsertDto {
    private Integer lecture_seq;
    private Integer course_seq;
    private String title;
    private String content;
    private LocalDateTime startDateTime;
    private LocalDateTime endDateTime;
    private String originalVideoTitle;
    private String uploadVideoTitle;
    private List<String> uploadAttachFileNames;
    private List<String> attachOriginalFileNames;
    private Long durationMinutes;

    public LectureInsertDto(Integer course_seq, String title, String content, LocalDateTime startDateTime, LocalDateTime endDateTime, String originalVideoTitle, String uploadVideoTitle, List<String> uploadAttachFileNames, List<String> attachOriginalFileNames, Long durationMinutes) {
        this.course_seq = course_seq;
        this.title = title;
        this.content = content;
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
        this.originalVideoTitle = originalVideoTitle;
        this.uploadVideoTitle = uploadVideoTitle;
        this.uploadAttachFileNames = uploadAttachFileNames;
        this.attachOriginalFileNames = attachOriginalFileNames;
        this.durationMinutes = durationMinutes;
    }
}
