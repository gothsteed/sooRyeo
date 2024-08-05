package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Attendance;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.dto.LectureInsertDto;

import java.util.List;

public interface LectureDao {
    int insertLecture(LectureInsertDto lectureUploadDto);

    Lecture getLectureInfo(int lectureSeq);

    int updateLecture(LectureInsertDto lectureDto);

    int deleteLecture(int lectureSeq);

    List<Attendance> getAttendance(String fkCourseSeq, Integer studentId);

	List<Integer> getStudentOfLecture(Integer course_seq);

	String getLectureName(Integer course_seq);

    void deleteAttachFile(Integer lectureAttachedFileSeq);
}
