package com.sooRyeo.app.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import java.util.List;

import com.sooRyeo.app.dto.CertificateGradeDTO;

public interface CertificateService {

	
	
	
	
	
	
	
	
	// 재학증명서
	ResponseEntity<byte[]> download_attendingPdf(HttpServletRequest request) throws IOException;
	
	// 졸업증명서
	ResponseEntity<byte[]> download_graduatePdf(HttpServletRequest request) throws IOException;
	
	// 등록 학기 갯수 가져오기
	List<CertificateGradeDTO> semesterdateList(String student_id);
	
	// 증명서 데이터 가져오기
	List<CertificateGradeDTO> gradeList(String student_id, String semesterdate);
	
	
	
}
