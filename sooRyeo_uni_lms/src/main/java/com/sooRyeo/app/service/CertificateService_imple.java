package com.sooRyeo.app.service;

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
import com.itextpdf.layout.element.Div;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Tab;
import com.itextpdf.layout.element.TabStop;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.TabAlignment;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.UnitValue;
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
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import java.awt.Font;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@Service
public class CertificateService_imple implements CertificateService {

	
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
            
        } // end of public void handleEvent
        
    } // end of private static class BackgroundImageEventHandler implements IEventHandler 
	
	
	// 재학증명서
	@Override
	public ResponseEntity<byte[]> download_attendingPdf(HttpServletRequest request) throws IOException {
		
       	ServletContext context = request.getServletContext();
        String imgPath = context.getRealPath("/resources/images/mainlogo.png");
       
        // 오늘 날짜 불러오기
        Date now = new Date(); // 현재시각
        SimpleDateFormat sdmt = new SimpleDateFormat("yyyyMMdd");
        String str_now = sdmt.format(now); // "20231018"
        
        String Year = str_now.substring(0, 4);    
        String Month = str_now.substring(4, 6);        
        String Day = str_now.substring(6);
        
        
        
        // db 데이터 불러오기 시작 (필요 데이터 : 이름, 학번, 생년월일, 학과, 학년)
        HttpSession session = request.getSession(); 
        Student loginuser = (Student) session.getAttribute("loginuser");
        
        String name = loginuser.getName();
        String student_id = String.valueOf(loginuser.getStudent_id());
        String birthday = loginuser.getBirthday();
        String department_name = loginuser.getDepartment_name();
        String grade = String.valueOf(loginuser.getGrade()+"학년");
        // db 데이터 불러오기 끝
        
        
        
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);
        PdfFont font = PdfFontFactory.createFont("c:/windows/fonts/malgun.ttf", "Identity-H", true);
        
        // 이미지 로드
        ImageData data = ImageDataFactory.create(imgPath);
        Image image = new Image(data);
        
        // 이미지 크기 조정
        image.scaleToFit(500, 500);
        
        // 배경 이미지 이벤트 핸들러 생성 및 등록
        BackgroundImageEventHandler handler = new BackgroundImageEventHandler(image);
        pdf.addEventHandler(PdfDocumentEvent.END_PAGE, handler);

        // 문서 제목 추가 (중앙 정렬)
        Paragraph title = new Paragraph("재학 증명서")
                .setFont(font)
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER);
       
        document.add(new Paragraph("\n"));
        document.add(title);
        
        
        // 테두리 추가
        addPageBorder(pdf); // 테두리 추가 메소드 호출
        
        document.add(new Paragraph("\n\n\n\n\n\n")); // 상단 여백을 위한 빈 문단 추가
        
        
        // 내용 추가
        document.add(new Paragraph("이름 : " + name)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정

        document.add(new Paragraph("학번 : " + student_id)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정
        
        document.add(new Paragraph("생년월일 : " + birthday)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정

        document.add(new Paragraph("학과 : " + department_name)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정

        
        document.add(new Paragraph("학년 : " + grade)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정
        
        
        // 문서 맺음말 추가
        Paragraph endParagraph = new Paragraph("위의 내용은 사실과 같음을 증명합니다.")
        		.setFont(font)
        		.setFontSize(16)
        		.setTextAlignment(TextAlignment.CENTER);
        
        Div endDiv = new Div()
                .add(endParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 300, 1000); // x, y, width를 의미한다.
        
        Paragraph dateParagraph = new Paragraph(Year + "년 " + Month + "월 " + Day + "일")
                .setFont(font)
                .setFontSize(16)
                .setTextAlignment(TextAlignment.CENTER);
        
        Div dateDiv = new Div()
                .add(dateParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 150, 1000); // 페이지 하단 150 포인트 위
        
        Paragraph signatureParagraph = new Paragraph("수 려 대 학 교  총 장")
                .setFont(font)
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER);
        
        Div signatureDiv = new Div()
                .add(signatureParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 50, 1000); // 페이지 하단 50 포인트 위
        
        document.add(endDiv);
        document.add(dateDiv);
        document.add(signatureDiv);
        
        document.close();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        
        String filename = "재학 증명서.pdf";
        String encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(encodedFilename)
                .build());
        
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        
        return new ResponseEntity<>(baos.toByteArray(), headers, HttpStatus.OK);

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
	@Override
	public ResponseEntity<byte[]> download_graduatePdf(HttpServletRequest request) throws IOException {
		
       	ServletContext context = request.getServletContext();
        String imgPath = context.getRealPath("/resources/images/mainlogo.png");
        
        // 오늘 날짜 불러오기
        Date now = new Date(); // 현재시각
        SimpleDateFormat sdmt = new SimpleDateFormat("yyyyMMdd");
        String str_now = sdmt.format(now); // "20231018"
        
        String Year = str_now.substring(0, 4);    
        String Month = str_now.substring(4, 6);        
        String Day = str_now.substring(6);
        
        
        // db 데이터 불러오기 시작 (필요 데이터 : 이름, 학번, 생년월일, 학과, 졸업년도)
        HttpSession session = request.getSession(); 
        Student loginuser = (Student) session.getAttribute("loginuser");
        
        String name = loginuser.getName();
        String student_id = String.valueOf(loginuser.getStudent_id());
        String birthday = loginuser.getBirthday();
        String department_name = loginuser.getDepartment_name();
        String finish_date = String.valueOf(loginuser.getFinish_date());
        // 졸업년도 null 체크 후 출력
        String finishDateOutput = (finish_date == null || finish_date.equals("0")) ? "미졸업" : finish_date;
        // db 데이터 불러오기 

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);
        PdfFont font = PdfFontFactory.createFont("c:/windows/fonts/malgun.ttf", "Identity-H", true);
        
        // 이미지 로드
        ImageData data = ImageDataFactory.create(imgPath);
        Image image = new Image(data);
        
        // 이미지 크기 조정
        image.scaleToFit(500, 500);
        
        // 배경 이미지 이벤트 핸들러 생성 및 등록
        BackgroundImageEventHandler handler = new BackgroundImageEventHandler(image);
        pdf.addEventHandler(PdfDocumentEvent.END_PAGE, handler);

        // 문서 제목 추가 (중앙 정렬)
        Paragraph title = new Paragraph("졸업 증명서")
                .setFont(font)
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER);
       
        document.add(new Paragraph("\n"));
        document.add(title);
        
        
        // 테두리 추가
        addPageBorder(pdf); // 테두리 추가 메소드 호출
        
        document.add(new Paragraph("\n\n\n\n\n\n")); // 상단 여백을 위한 빈 문단 추가
        
        
        // 내용 추가
        document.add(new Paragraph("이름 : " + name)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정

        document.add(new Paragraph("학번 : " + student_id)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정

        document.add(new Paragraph("생년월일 : " + birthday)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정
        
        document.add(new Paragraph("학과 : " + department_name)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정
        
        document.add(new Paragraph("졸업년도 : " + finishDateOutput)
                .setFont(font)
                .setTextAlignment(TextAlignment.CENTER)
                .setMultipliedLeading(1.5f));  // 줄 간격 조정
        
        
        
        // 문서 맺음말 추가
        Paragraph endParagraph = new Paragraph("위의 내용은 사실과 같음을 증명합니다.")
        		.setFont(font)
        		.setFontSize(16)
        		.setTextAlignment(TextAlignment.CENTER);
        
        Div endDiv = new Div()
                .add(endParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 300, 1000); // x, y, width를 의미한다.
        
        Paragraph dateParagraph = new Paragraph(Year + "년 " + Month + "월 " + Day + "일")
                .setFont(font)
                .setFontSize(16)
                .setTextAlignment(TextAlignment.CENTER);
        
        Div dateDiv = new Div()
                .add(dateParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 150, 1000); // 페이지 하단 150 포인트 위
        
        Paragraph signatureParagraph = new Paragraph("수 려 대 학 교  총 장")
                .setFont(font)
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER);
        
        Div signatureDiv = new Div()
                .add(signatureParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 50, 1000); // 페이지 하단 50 포인트 위
        
        document.add(endDiv);
        document.add(dateDiv);
        document.add(signatureDiv);
        
        document.close();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        
        String filename = "졸업 증명서.pdf";
        String encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(encodedFilename)
                .build());
        
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        
        return new ResponseEntity<>(baos.toByteArray(), headers, HttpStatus.OK);

		
	} // end of public ResponseEntity<byte[]> download_graduatePdf

}
