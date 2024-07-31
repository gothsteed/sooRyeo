package com.sooRyeo.app.service;

import java.util.List;

import com.sooRyeo.app.dto.CertificateGradeDTO;

public interface CertificateService {
	
	// 등록 학기 갯수 가져오기
	List<CertificateGradeDTO> semesterdateList(String student_id);
	
	// 증명서 데이터 가져오기
	List<CertificateGradeDTO> gradeList(String student_id, String semesterdate);
	
	
	
}
