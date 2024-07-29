package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Attendance;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.dto.LectureInsertDto;
import com.sooRyeo.app.dto.LectureUpdateDto;

import java.util.List;

public interface LectureDao {
    int insertLecture(LectureInsertDto lectureUploadDto);

    Lecture getLectureInfo(int lectureSeq);

    int updateLecture(LectureUpdateDto lectureDto);

    int deleteLecture(int lectureSeq);

    List<Attendance> getAttendance(String fkCourseSeq, Integer studentId);
}
