package com.sooRyeo.app.service;

import com.sooRyeo.app.dto.LectureUploadDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public interface LectureService {
    ModelAndView getUploadLecturePage(HttpServletRequest request, ModelAndView mav);

    ResponseEntity<String> uploadLecturePage(MultipartHttpServletRequest request, LectureUploadDto lectureUploadDto) throws Exception;
}
