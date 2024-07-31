package com.sooRyeo.app.controller;


import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.CertificateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@RequireLogin(type = {Student.class})
@Controller
public class CertificateController {

	@Autowired
	private CertificateService certificateService;

	
    @GetMapping("/student/certificate/menu.lms")
    public ModelAndView menu(ModelAndView mav, HttpServletRequest request) throws IOException {
        mav.setViewName("certificate/menu");
        return mav;
    }
    
    
    // 성적증명서
    @PostMapping(value="/certificate/grade.lms", produces="application/pdf")
    public ResponseEntity<byte[]> downloadGradePDF(HttpServletRequest request) throws Exception {
        
    	ResponseEntity<byte[]> downloadGradePDF = certificateService.downloadGradePDF(request);
    	
    	return downloadGradePDF; 	
    }


    // 재학증명서
    @PostMapping(value="/certificate/attending.lms", produces="text/plain;charset=UTF-8")
    public ResponseEntity<byte[]> download_attendingPdf(HttpServletRequest request) throws Exception {
        
    	ResponseEntity<byte[]> download_attendingPdf = certificateService.download_attendingPdf(request);
        
		return download_attendingPdf;

    } // end of public ResponseEntity<byte[]> download_attendingPdf
    
    
    // 페이지 테두리를 추가하는 메소드
    private void addPageBorder(PdfDocument pdf) {
        PdfCanvas canvas = new PdfCanvas(pdf.getFirstPage());
        Rectangle rect = new Rectangle(36, 36, PageSize.A4.getWidth() - 72, PageSize.A4.getHeight() - 72); // 페이지 여백을 고려한 사각형
        canvas.setLineWidth(1);
        canvas.rectangle(rect);
        canvas.stroke();
    } // end of private void addPageBorder
    
    
    
    // 졸업 증명서
    @PostMapping(value="/certificate/graduate.lms", produces="text/plain;charset=UTF-8")
    public ResponseEntity<byte[]> download_graduatePdf(HttpServletRequest request) throws Exception {
    	
    	ResponseEntity<byte[]> download_graduatePdf = certificateService.download_graduatePdf(request);
    	
    	return download_graduatePdf;
    	
    } // end of public ResponseEntity<byte[]> download_attendingPdf
    
    
	
}
