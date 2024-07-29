package com.sooRyeo.app.controller;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@RequireLogin(type = {Student.class})
@Controller
public class CertificateController {

    @GetMapping("/student/certificate/menu.lms")
    public ModelAndView menu(ModelAndView mav, HttpServletRequest request) {
        mav.setViewName("certificate/menu");
        return mav;
    }


}
