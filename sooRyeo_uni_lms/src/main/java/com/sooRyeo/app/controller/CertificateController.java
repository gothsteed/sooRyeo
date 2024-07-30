package com.sooRyeo.app.controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfDocument;
import com.itextpdf.text.pdf.PdfGState;
import com.itextpdf.text.pdf.PdfWriter;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.CertificateService;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.ByteArrayOutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

@RequireLogin(type = {Student.class})
@Controller
public class CertificateController {

	@Autowired
	private CertificateService certificateService;

	
    @GetMapping("/student/certificate/menu.lms")
    public ModelAndView menu(ModelAndView mav, HttpServletRequest request) {
        mav.setViewName("certificate/menu");
        return mav;
    }
    
    
    @PostMapping(value="/certificate/grade.lms", produces="text/plain;charset=UTF-8")
    public ResponseEntity<byte[]> downloadPdf() throws Exception {
        
    	ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, baos);
        document.open();
        
        BaseFont baseFont = BaseFont.createFont("c:/windows/fonts/malgun.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font font = new Font(baseFont, 16);
        
        Chunk chunk = new Chunk("안녕하세요, 성정증명서 테스트입니다.", font);
        document.add(chunk);
        document.close();
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        
        String filename = "성적증명서.pdf";
        String encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(encodedFilename)
                .build());
        
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        
        return new ResponseEntity<>(baos.toByteArray(), headers, HttpStatus.OK);
        
    }
    
	/*
	 * @PostMapping("/certificate/grade.lms") public ModelAndView grade(ModelAndView
	 * mav, HttpServletRequest request) {
	 * 
	 * int n = 0;
	 * 
	 * n = certificateService.getGrade();
	 * 
	 * 
	 * 
	 * if(n==1) { mav.addObject("message", "증명서가 발급되었습니다."); mav.addObject("loc",
	 * request.getContextPath()+"/student/certificate/menu.lms"); } else {
	 * mav.addObject("message", "오류가 발생하여 증명서를 발급하지 못했습니다."); mav.addObject("loc",
	 * "javascript:history.back()"); }
	 * 
	 * mav.setViewName("msg");
	 * 
	 * return mav; }
	 */


    
    
    @PostMapping(value="/certificate/attending.lms", produces="text/plain;charset=UTF-8")
    public ResponseEntity<byte[]> download_attendingPdf() throws Exception {
        
    	ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4);
        PdfWriter writer = PdfWriter.getInstance(document, baos);
        document.open();
        
        BaseFont baseFont = BaseFont.createFont("c:/windows/fonts/malgun.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font font = new Font(baseFont, 16);
        
        // 제목
        Chunk chunk = new Chunk("재학증명서", font);
        document.add(chunk);
        
        // 이미지
        String imagePath = "c:/git/sooRyeo/sooRyeo_uni_lms/src/main/webapp/resources/images/mainlogo.png";
        Image image = Image.getInstance(imagePath);
        image.scaleToFit(500, 500);
        
        // 이미지 중앙 정렬을 위해 위치 조정
        image.setAlignment(Image.ALIGN_CENTER);
        image.setAbsolutePosition((PageSize.A4.getWidth() - image.getScaledWidth()) / 2, 
        						  (PageSize.A4.getHeight() - image.getScaledHeight()) / 2 - 50); // -50은 제목과의 간격 조정
     
        // 투명도 설정
        PdfContentByte cb = writer.getDirectContent();
        PdfGState gState = new PdfGState();
        gState.setFillOpacity(0.5f); // 투명도 설정 (0.0f ~ 1.0f 범위)
        
        cb.saveState(); // 현재 상태 저장
        cb.setGState(gState); // 그래픽 상태 설정
        cb.addImage(image); // 이미지 추가
        cb.restoreState(); // 상태 복원
       
        
        document.close();
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        
        String filename = "재학증명서.pdf";
        String encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(encodedFilename)
                .build());
        
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
   
        
        
        return new ResponseEntity<>(baos.toByteArray(), headers, HttpStatus.OK);
        
    }
    
    
    
    
    
}
