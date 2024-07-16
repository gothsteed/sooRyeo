package com.sooRyeo.app.model;

import com.sooRyeo.app.dto.LectureInsertDto;
import com.sooRyeo.app.dto.LectureUploadDto;

public interface LectureDao {
    int insertLecture(LectureInsertDto lectureUploadDto);
}
