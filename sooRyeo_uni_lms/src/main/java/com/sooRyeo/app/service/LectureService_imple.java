package com.sooRyeo.app.service;

import com.sooRyeo.app.ExceptionHandler.AuthException;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.dto.LectureInsertDto;
import com.sooRyeo.app.dto.LectureUpdateDto;
import com.sooRyeo.app.dto.LectureUploadDto;
import com.sooRyeo.app.model.CourseDao;
import com.sooRyeo.app.model.LectureDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Service
public class LectureService_imple implements LectureService{

    @Autowired
    private FileManager fileManager;

    @Autowired
    private LectureDao lectureDao;

    @Autowired
    private CourseDao courseDao;


    private boolean checkLectureAuth(HttpServletRequest request, int lecture_seq) {
        HttpSession session = request.getSession();
        Professor loginuser = (Professor) session.getAttribute("loginuser");
        Course course = courseDao.getCourse(lecture_seq);
        return loginuser.getProf_id().equals(course.getFk_professor_id());
    }


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

    @Override
    public ModelAndView getLectureEditPage(ModelAndView mav, HttpServletRequest request) {
        int lecture_seq = Integer.parseInt(request.getParameter("lecture_seq"));

        Lecture lecture = lectureDao.getLectureInfo(lecture_seq);
        if(!checkLectureAuth(request, lecture.getFk_course_seq())) {
            throw new AuthException("권한이 없습니다");
        }

        mav.addObject("lecture", lecture);
        mav.setViewName("lecture/lectureEdit");

        return mav;
    }

    @Override
    public ResponseEntity<String> editLecture(HttpServletRequest request, LectureUploadDto lectureUploadDto) throws Exception {

        Lecture lecture = lectureDao.getLectureInfo(lectureUploadDto.getLecture_seq());

        if(!checkLectureAuth(request, lecture.getFk_course_seq())) {
            throw new AuthException("권한이 없습니다");
        }
        ServletContext servletContext = request.getServletContext();
        String path = servletContext.getRealPath("/resources/lectures");

        String uploadVideoFileName = null;
        String videoOriginalFileName = null;
        if(lectureUploadDto.getVideo() != null) {
            fileManager.doFileDelete(lecture.getUploaded_video_file_name(), path);

            videoOriginalFileName = lectureUploadDto.getVideo().getOriginalFilename();
            uploadVideoFileName  =  fileManager.doFileUpload(lectureUploadDto.getVideo().getBytes(), videoOriginalFileName, path);
        }


        String uploadAttachFileName = null;
        String attachOriginalFileName = null;
        if(lectureUploadDto.getAttachment() != null) {
            fileManager.doFileDelete(lecture.getUploaded_lecture_file_name(), path);

            attachOriginalFileName = lectureUploadDto.getAttachment().getOriginalFilename();
            uploadAttachFileName  =  fileManager.doFileUpload(lectureUploadDto.getAttachment().getBytes(), attachOriginalFileName, path);
        }

        LectureUpdateDto lectureUpdateDto =  new LectureUpdateDto(
                lectureUploadDto.getLecture_seq(),
                lectureUploadDto.getTitle(),
                lectureUploadDto.getContent(),
                lectureUploadDto.getStartDateTime(),
                lectureUploadDto.getEndDateTime(),
                videoOriginalFileName,
                uploadVideoFileName,
                attachOriginalFileName,
                uploadAttachFileName);



        int result =  lectureDao.updateLecture(lectureUpdateDto);

        if(result != 1) {
            return  ResponseEntity.internalServerError().body("수정에 실패하였습니다");
        }
        return ResponseEntity.ok("강의가 수정되었습니다.");
    }

    @Override
    public ResponseEntity<String> deleteLecture(HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();
        Professor loginuser = (Professor) session.getAttribute("loginuser");

        ServletContext servletContext = request.getServletContext();
        String path = servletContext.getRealPath("/resources/lectures");

        int lecture_seq = Integer.parseInt(request.getParameter("lecture_seq"));

        Lecture lecture =  lectureDao.getLectureInfo(lecture_seq);
        if (!lecture.checkLectureAuth(courseDao, loginuser)) {
            throw new AuthException("권한이 없습니다");
        }

        if(lecture.getVideo_file_name() != null) {
            fileManager.doFileDelete(path, lecture.getUploaded_video_file_name());
        }
        if(lecture.getLecture_file_name() != null) {
            fileManager.doFileDelete(path, lecture.getUploaded_lecture_file_name());
        }

        int result = lectureDao.deleteLecture(lecture_seq);
        if(result != 1) {
            return  ResponseEntity.internalServerError().body("삭제에 실패하였습니다");
        }


        return ResponseEntity.ok("강의가 삭제되었습니다.");
    }
}
