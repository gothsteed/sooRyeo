package com.sooRyeo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.dto.CertificateGradeDTO;
import com.sooRyeo.app.model.CertificateDao;

@Service
public class CertificateService_imple implements CertificateService {
	
	@Autowired
	private CertificateDao certificateDao;
	

	@Override
	public List<CertificateGradeDTO> semesterdateList(String student_id) {
		
		List<CertificateGradeDTO> semesterdateList = certificateDao.semesterdateList(student_id); 
		
		return semesterdateList;
	}
	
	
	@Override
	public List<CertificateGradeDTO> gradeList(String student_id, String semesterdate) {
		
		List<CertificateGradeDTO> gradeList =  certificateDao.gradeList(student_id, semesterdate);
		
		return gradeList;
	}



	
}
