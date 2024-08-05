package com.sooRyeo.app.controller;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.mongo.entity.AlertLecture;
import com.sooRyeo.app.service.LectureService;
import com.sooRyeo.app.service.ProfessorService;
import com.sooRyeo.app.service.StudentService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@RequireLogin(type = {Student.class, Professor.class})
@Controller
public class LectureController {

    @Autowired
    private ProfessorService professorService;

    @Autowired
    private FileManager fileManager;

    @Autowired
    private StudentService studentService;

    @Autowired
    private LectureService lectureService;

    @GetMapping("/professor/classPlay.lms")
    public ModelAndView classPlay(HttpServletRequest request, ModelAndView mav) {

        String lecture_seq = request.getParameter("lecture_seq");

        System.out.println("확인용 lecture_seq : " + lecture_seq);

        Lecture lecture = professorService.getlecture(lecture_seq);

        mav.addObject("lecture", lecture);

        mav.setViewName("classPlay");

        return mav;
    }


    @GetMapping(value="/lecture/pdf_download.lms", produces="text/plain;charset=UTF-8")
    public void pdf_download(HttpServletRequest request, HttpServletResponse response) {// 첨부파일 다운로드
        lectureService.downloadLectureAttachment(request, response);
    }

    @ResponseBody
    @GetMapping(value="/student/alertLecture.lms", produces="text/plain;charset=UTF-8")
    public String alertLecture(HttpServletRequest request) {
        List<AlertLecture> alertLecture = studentService.getAlertLecture(request);

        JSONArray jsonArr = new JSONArray(); // []

        if(alertLecture != null) {
            for(AlertLecture alertLectureData : alertLecture) {
                JSONObject jsonObj = new JSONObject(); // {}
                jsonObj.put("Lname", alertLectureData.getLectureName());
                jsonObj.put("Pname", alertLectureData.getProfessorName());
                jsonObj.put("LId", alertLectureData.getLectureId());
                jsonObj.put("Id", alertLectureData.getId());

                jsonArr.put(jsonObj); // [{},{},{}]
            }// end of for ----------------------------------
        }
        return jsonArr.toString();
    }


    @ResponseBody
    @GetMapping(value="/student/alertLectureDel.lms", produces="text/plain;charset=UTF-8")
    public String alertLectureDel(HttpServletRequest request) {

        String id = (String)request.getParameter("id");

        AlertLecture alertLecture = studentService.deleteAlertLecture(id);

        JSONObject jsonObj = new JSONObject(); // {}
        jsonObj.put("alertLecture", alertLecture);

        return jsonObj.toString();
    }



}
