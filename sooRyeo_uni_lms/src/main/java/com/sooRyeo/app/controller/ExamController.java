package com.sooRyeo.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.sooRyeo.app.service.ExamService;

@Controller
public class ExamController {

    @Autowired
    private ExamService examService;

    

}
