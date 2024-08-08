package com.sooRyeo.app.controller;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequireLogin(type = {Professor.class, Admin.class})
public class TimeTableRestController {

    @Autowired
    private CourseService courseService;

    @ResponseBody
    @RequestMapping(value = "/admin/profTimetableJSON.lms", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
    public String getProfTimetableJSON(HttpServletRequest request, ModelAndView mav) {

        return courseService.getProfTimetable(request, mav);
    }

    @GetMapping(value = "/student/timetableJSON.lms", produces="text/plain;charset=UTF-8")
    public ResponseEntity<String> timeTableREST(HttpServletRequest request) {
        return courseService.getLoginStudentTimeTable(request);
    }


}
