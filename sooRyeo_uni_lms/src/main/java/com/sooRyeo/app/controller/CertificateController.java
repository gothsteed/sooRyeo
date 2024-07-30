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
import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.events.Event;
import com.itextpdf.kernel.events.IEventHandler;
import com.itextpdf.kernel.events.PdfDocumentEvent;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.layout.Canvas;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.service.CertificateService;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;


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

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.net.URLEncoder;

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
    
    
    @PostMapping(value="/certificate/grade.lms", produces="application/pdf")
    public ResponseEntity<byte[]> downloadGradePDF(HttpServletRequest request) throws Exception {
        ServletContext context = request.getServletContext();
        String imgPath = context.getRealPath("/resources/images/mainlogo.png");
        
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);
        PdfFont font = PdfFontFactory.createFont("c:/windows/fonts/malgun.ttf", "Identity-H", true);
        
        // 이미지 로드
        ImageData data = ImageDataFactory.create(imgPath);
        Image image = new Image(data);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float pageWidth = pdf.getDefaultPageSize().getWidth();
        float pageHeight = pdf.getDefaultPageSize().getHeight();
        image.scaleToFit(pageWidth, pageHeight);

        // 배경 이미지 이벤트 핸들러 생성 및 등록
        BackgroundImageEventHandler handler = new BackgroundImageEventHandler(image);
        pdf.addEventHandler(PdfDocumentEvent.END_PAGE, handler);

        // 문서 제목 추가
        document.add(new Paragraph("성적증명서").setFont(font).setFontSize(24).setBold());

        // 테이블 생성
        float[] pointColumnWidths = {150f, 150f};
        Table table = new Table(pointColumnWidths);
        
        // 테이블에 데이터 추가
        table.addCell(new Cell().add(new Paragraph("이름").setFont(font)));
        table.addCell(new Cell().add(new Paragraph("홍길동").setFont(font)));
        table.addCell(new Cell().add(new Paragraph("학번").setFont(font)));
        table.addCell(new Cell().add(new Paragraph("20230001").setFont(font)));
        table.addCell(new Cell().add(new Paragraph("학과").setFont(font)));
        table.addCell(new Cell().add(new Paragraph("컴퓨터공학과").setFont(font)));

        // 중첩 테이블 생성 (성적 정보)
        Table gradeTable = new Table(new float[]{50f, 100f, 50f});
        gradeTable.addCell(new Cell().add(new Paragraph("과목").setFont(font)));
        gradeTable.addCell(new Cell().add(new Paragraph("과목명").setFont(font)));
        gradeTable.addCell(new Cell().add(new Paragraph("학점").setFont(font)));

        // 성적 정보 추가 (예시)
        gradeTable.addCell(new Cell().add(new Paragraph("CS101").setFont(font)));
        gradeTable.addCell(new Cell().add(new Paragraph("프로그래밍 기초").setFont(font)));
        gradeTable.addCell(new Cell().add(new Paragraph("A+").setFont(font)));

        gradeTable.addCell(new Cell().add(new Paragraph("CS102").setFont(font)));
        gradeTable.addCell(new Cell().add(new Paragraph("자료구조").setFont(font)));
        gradeTable.addCell(new Cell().add(new Paragraph("A").setFont(font)));

        // 테이블을 문서에 추가
        document.add(table);
        document.add(new Paragraph("\n")); // 간격 추가
        document.add(gradeTable);

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

    // 배경 이미지를 처리하는 이벤트 핸들러 클래스
    private static class BackgroundImageEventHandler implements IEventHandler {
        private Image image;

        public BackgroundImageEventHandler(Image image) {
            this.image = image;
        }

        @Override
        public void handleEvent(Event event) {
            PdfDocumentEvent docEvent = (PdfDocumentEvent) event;
            PdfDocument pdfDoc = docEvent.getDocument();
            PdfPage page = docEvent.getPage();
            PdfCanvas pdfCanvas = new PdfCanvas(page.newContentStreamBefore(), page.getResources(), pdfDoc);
            Rectangle pageSize = page.getPageSize();
            Canvas canvas = new Canvas(pdfCanvas, pdfDoc, pageSize);       
            
            canvas
                .add(image.setFixedPosition(
                    (pageSize.getWidth() - image.getImageScaledWidth()) / 2,
                    (pageSize.getHeight() - image.getImageScaledHeight()) / 2)
                .setOpacity(0.1f)); // 투명도 설정 (0.1f는 10% 불투명도)
            canvas.close();
        }
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
