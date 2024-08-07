package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Attendance;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.LectureAttachedFile;
import com.sooRyeo.app.dto.LectureInsertDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class LectureDao_imple implements LectureDao {
    @Autowired
    @Qualifier("sqlsession") // 이름이 같은것을 주입
    private SqlSessionTemplate sqlSession;

    private void insertAttachedFile(LectureInsertDto lectureInsertDto) {
        int lectureSeq = lectureInsertDto.getLecture_seq();
        for(int i=0; i<lectureInsertDto.getAttachOriginalFileNames().size(); i++){
            Map<String, Object> attachmentParams = new HashMap<>();
            attachmentParams.put("lecture_seq", lectureSeq);
            attachmentParams.put("originalFileName", lectureInsertDto.getAttachOriginalFileNames().get(i));
            attachmentParams.put("uploadFileName", lectureInsertDto.getUploadAttachFileNames().get(i));

            sqlSession.insert("lecture.insertAttachFile", attachmentParams);
        }

    }

    @Override
    public int insertLecture(LectureInsertDto lectureUploadDto) {
        lectureUploadDto.setLecture_seq(sqlSession.selectOne("lecture.selectNextLectureSeq"));
        sqlSession.insert("lecture.insertLecture", lectureUploadDto);
        insertAttachedFile(lectureUploadDto);

        return  1;
    }

    @Override
    public Lecture getLectureInfo(int lectureSeq) {
        return  sqlSession.selectOne("lecture.getLectureInfo", lectureSeq);
    }

    @Override
    public int updateLecture(LectureInsertDto lectureDto) {
        sqlSession.update("lecture.updateLecture", lectureDto);
        insertAttachedFile(lectureDto);
        return 1;
    }

    @Override
    public int deleteLecture(int lectureSeq) {
        return sqlSession.delete("lecture.deleteLecture", lectureSeq);
    }

    @Override
    public List<Attendance> getAttendance(String fkCourseSeq, Integer studentId) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("fkCourseSeq", fkCourseSeq);
        paramMap.put("studentId", studentId);
        return sqlSession.selectList("attendance.getAttendance", paramMap);
    }

	@Override
	public List<Integer> getStudentOfLecture(Integer course_seq) {
		return sqlSession.selectList("lecture.getStudentOfLecture", course_seq);
	}

	@Override
	public String getLectureName(Integer course_seq) {
		return sqlSession.selectOne("lecture.getLectureName", course_seq);
	}

    @Override
    public void deleteAttachFile(Integer lectureAttachedFileSeq) {
        sqlSession.delete("lecture.deleteAttachFile", lectureAttachedFileSeq);
    }

    @Override
    public LectureAttachedFile getAttachedFile(int fileSeq) {
        return sqlSession.selectOne("lecture.getAttachedFile", fileSeq);
    }


}
