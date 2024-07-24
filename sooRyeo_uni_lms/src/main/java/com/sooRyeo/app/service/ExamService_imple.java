package com.sooRyeo.app.service;

import com.sooRyeo.app.domain.Exam;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.model.ScheduleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Service
public class ExamService_imple implements ExamService {

    @Autowired
    private ScheduleDao scheduleDao;


    @Override
    public ModelAndView getExamPage(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
        int currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int course_seq = Integer.parseInt(request.getParameter("course_seq"));
        int sizePerPage = 10;

        List<Exam> examPageList = scheduleDao.getExamList(currentPage, sizePerPage, course_seq);
        int examCount = scheduleDao.getExamCount(course_seq);

        Pager<Exam> examPager = new Pager<>(examPageList, currentPage, sizePerPage, examCount);



        return null;
    }


	@Override
	public Exam getExam() {

		Exam examView = scheduleDao.getExam();
		
		return examView;
	}
}
