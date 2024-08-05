package com.sooRyeo.app.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

@Getter
@Setter
public class LectureUploadDto {
    private Integer lecture_seq;
    private Integer course_seq;
    private String title;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime startDateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime endDateTime;
    private MultipartFile video;
    private List<MultipartFile> attachment;
    private Set<Integer> removedFiles;


    public boolean isRemoved(int seq) {
        return removedFiles.contains(seq);
    }

}
