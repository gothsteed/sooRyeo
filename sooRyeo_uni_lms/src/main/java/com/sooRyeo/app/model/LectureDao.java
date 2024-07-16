package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.dto.LectureInsertDto;
import com.sooRyeo.app.dto.LectureUpdateDto;
import com.sooRyeo.app.dto.LectureUploadDto;

public interface LectureDao {
    int insertLecture(LectureInsertDto lectureUploadDto);

    Lecture getLectureInfo(int lectureSeq);

    int updateLecture(LectureUpdateDto lectureDto);
}
