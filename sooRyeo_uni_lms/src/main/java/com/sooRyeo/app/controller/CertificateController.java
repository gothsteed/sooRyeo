package com.sooRyeo.app.controller;

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
import com.itextpdf.layout.element.Tab;
import com.itextpdf.layout.element.TabStop;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TabAlignment;
import com.itextpdf.layout.property.TextAlignment;
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
import javax.servlet.http.HttpSession;

import java.io.ByteArrayOutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
        
        // 오늘 날짜 불러오기
        Date now = new Date(); // 현재시각
        SimpleDateFormat sdmt = new SimpleDateFormat("yyyyMMdd");
        String str_now = sdmt.format(now); // "20231018"
        
        String Year = str_now.substring(0, 4);    
        String Month = str_now.substring(4, 6);        
        String Day = str_now.substring(6);
        
        System.out.println("확인용 Year : " + Year);
        System.out.println("확인용 Month : " + Month);
        System.out.println("확인용 Day : " + Day);
        
        
        // db 데이터 불러오기 시작
        HttpSession session = request.getSession(); 
        Student loginuser = (Student) session.getAttribute("loginuser");
        
        String name = loginuser.getName();
        String student_id = String.valueOf(loginuser.getStudent_id());
        
        String department_name = loginuser.getDepartment_name();
        
        
        
        // db 데이터 불러오기 끝
        
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);
        PdfFont font = PdfFontFactory.createFont("c:/windows/fonts/malgun.ttf", "Identity-H", true);
        
        // 이미지 로드
        ImageData data = ImageDataFactory.create(imgPath);
        Image image = new Image(data);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float pageWidth = 500;
        // pdf.getDefaultPageSize().getWidth();
        float pageHeight = 500;
        // pdf.getDefaultPageSize().getHeight();
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
        table.addCell(new Cell().add(new Paragraph(name).setFont(font)));
        table.addCell(new Cell().add(new Paragraph("학번").setFont(font)));
        table.addCell(new Cell().add(new Paragraph(student_id).setFont(font)));
        table.addCell(new Cell().add(new Paragraph("학과").setFont(font)));
        table.addCell(new Cell().add(new Paragraph(department_name).setFont(font)));

        // 중첩 테이블 생성 (성적 정보)
        Table gradeTable = new Table(new float[]{50f, 100f, 50f});
        gradeTable.addCell(new Cell().add(new Paragraph("과목코드").setFont(font)));
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
        
        // 문서 맺음말 추가
        document.add(new Paragraph("위의 내용은 사실과 같음을 증명합니다.").setFont(font).setFontSize(16).setTextAlignment(TextAlignment.CENTER));
        
        // 탭 설정       
        Paragraph paragraph = new Paragraph();
        paragraph.setFont(font).setFontSize(16);
        paragraph.setTextAlignment(TextAlignment.CENTER);
        
        paragraph.add(Year+"년")
                .add(" ")
                .add(Month+"월")
                .add(" ")
                .add(Day+"일");     
        document.add(paragraph);
        document.add(new Paragraph("\n")); // 간격 추가
        document.add(new Paragraph("수 려 대 학 교  총 장").setFont(font).setFontSize(24).setBold().setTextAlignment(TextAlignment.CENTER));

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
    
	
}
