package com.sooRyeo.app.service;

import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.dto.LectureInsertDto;
import com.sooRyeo.app.dto.LectureUploadDto;
import com.sooRyeo.app.model.LectureDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Service
public class LectureService_imple implements LectureService{

    @Autowired
    private FileManager fileManager;

    @Autowired
    private LectureDao lectureDao;


    @Override
    public ModelAndView getUploadLecturePage(HttpServletRequest request, ModelAndView mav) {

        //todo : 예외처리
        int course_seq = Integer.parseInt(request.getParameter("course_seq"));
        mav.addObject("course_seq", course_seq);
        mav.setViewName("lecture/lectureUpload");

        return mav;
    }

    @Override
    public ResponseEntity<String> uploadLecturePage(MultipartHttpServletRequest request, LectureUploadDto lectureUploadDto) throws Exception {

        ServletContext servletContext = request.getServletContext();
        String path = servletContext.getRealPath("/resources/lectures");
        String videoOriginalFileName =  lectureUploadDto.getVideo().getOriginalFilename();
        String uploadedVideoName =  fileManager.doFileUpload(lectureUploadDto.getVideo().getBytes(), videoOriginalFileName, path);


        String uploadAttachFileName = null;
        String attachOriginalFileName = null;
        if(lectureUploadDto.getAttachment() != null) {
            attachOriginalFileName = lectureUploadDto.getAttachment().getOriginalFilename();
            uploadAttachFileName  =  fileManager.doFileUpload(lectureUploadDto.getAttachment().getBytes(), attachOriginalFileName, path);
        }

        LectureInsertDto dto = new LectureInsertDto(lectureUploadDto.getCourse_seq(), lectureUploadDto.getTitle(),
                lectureUploadDto.getContent(), lectureUploadDto.getStartDateTime(), lectureUploadDto.getEndDateTime(),
                videoOriginalFileName, uploadedVideoName, attachOriginalFileName, uploadAttachFileName);


        int result = lectureDao.insertLecture(dto);

        if(result != 1) {
            return ResponseEntity.internalServerError().body("강의등록에 실패하였습니다");
        }


        return ResponseEntity.ok("강의가 등록되었습니다.");
    }
}
