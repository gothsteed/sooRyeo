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
public class LectureUpdateDto {

    private Integer lecture_seq;
    private String title;
    private String content;
    private LocalDateTime startDateTime;
    private LocalDateTime endDateTime;
    private String originalVideoTitle;
    private String uploadVideoTitle;
    private List<String> uploadAttachFileNames;
    private List<String> attachOriginalFileNames;
    private Long durationMinutes;




}
