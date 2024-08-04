package com.sooRyeo.app.domain;

import lombok.Getter;

@Getter
public class LectureAttachedFile {
    private Integer lecture_attached_file_seq;
    private Integer fk_lecture_seq;
    private String original_file_name;
    private String upload_file_name;
}
