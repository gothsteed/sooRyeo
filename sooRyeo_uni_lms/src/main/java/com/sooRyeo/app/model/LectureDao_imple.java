package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.dto.LectureInsertDto;
import com.sooRyeo.app.dto.LectureUpdateDto;
import com.sooRyeo.app.dto.LectureUploadDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class LectureDao_imple implements LectureDao {
    @Autowired
    @Qualifier("sqlsession") // 이름이 같은것을 주입
    private SqlSessionTemplate sqlSession;


    @Override
    public int insertLecture(LectureInsertDto lectureUploadDto) {
        return  sqlSession.insert("lecture.insertLecture", lectureUploadDto);
    }

    @Override
    public Lecture getLectureInfo(int lectureSeq) {
        return  sqlSession.selectOne("lecture.getLectureInfo", lectureSeq);
    }

    @Override
    public int updateLecture(LectureUpdateDto lectureDto) {
        return sqlSession.update("lecture.updateLecture", lectureDto);
    }

    @Override
    public int deleteLecture(int lectureSeq) {
        return sqlSession.delete("lecture.deleteLecture", lectureSeq);
    }
}
