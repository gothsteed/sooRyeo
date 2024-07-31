package com.sooRyeo.app.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;

public interface CertificateService {

	
	
	
	
	
	
	
	
	// 재학증명서
	ResponseEntity<byte[]> download_attendingPdf(HttpServletRequest request) throws IOException;
	
	// 졸업증명서
	ResponseEntity<byte[]> download_graduatePdf(HttpServletRequest request) throws IOException;
	
}
