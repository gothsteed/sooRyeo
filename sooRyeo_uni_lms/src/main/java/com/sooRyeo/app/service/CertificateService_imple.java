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
import com.itextpdf.layout.border.Border;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Div;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Tab;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.sooRyeo.app.domain.Student;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import java.util.List;

import org.springframework.stereotype.Service;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.sooRyeo.app.dto.CertificateGradeDTO;
import com.sooRyeo.app.model.CertificateDao;

@Service
public class CertificateService_imple implements CertificateService {
	
	@Autowired
	private CertificateDao certificateDao;
	

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
	
    // 성적증명서
	@Override
	public ResponseEntity<byte[]> downloadGradePDF(HttpServletRequest request) throws IOException {
		ServletContext context = request.getServletContext();
        String imgPath = context.getRealPath("/resources/images/mainlogo.png");
        
        String signPath = context.getRealPath("/resources/images/sooRyeo_signature.png");
        
        // 오늘 날짜 불러오기
        Date now = new Date(); // 현재시각
        SimpleDateFormat sdmt = new SimpleDateFormat("yyyyMMdd");
        String str_now = sdmt.format(now); // "20231018"
        
        String Year = str_now.substring(0, 4);    
        String Month = str_now.substring(4, 6);        
        String Day = str_now.substring(6);
        
        // System.out.println("확인용 Year : " + Year);
        // System.out.println("확인용 Month : " + Month);
        // System.out.println("확인용 Day : " + Day);
        
        
        // db 데이터 불러오기 시작
        HttpSession session = request.getSession(); 
        Student loginuser = (Student) session.getAttribute("loginuser");
        
        String name = loginuser.getName();
        String student_id = String.valueOf(loginuser.getStudent_id()); 
        String department_name = loginuser.getDepartment_name();
        
        List<CertificateGradeDTO> semesterDateList = certificateDao.semesterdateList(student_id); // 학생 등록 학기 가져오기
           
        // db 데이터 불러오기 끝
        
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);
        PdfFont font = PdfFontFactory.createFont("c:/windows/fonts/malgun.ttf", "Identity-H", true);
        
        // 이미지 로드
        ImageData data = ImageDataFactory.create(imgPath);
        Image image = new Image(data);
        
        ImageData signdata = ImageDataFactory.create(signPath);
        Image signimage = new Image(signdata);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float pageWidth = 500;
        // pdf.getDefaultPageSize().getWidth();
        float pageHeight = 500;
        // pdf.getDefaultPageSize().getHeight();
        image.scaleToFit(pageWidth, pageHeight);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float signWidth = 100;
        // pdf.getDefaultPageSize().getWidth();
        float signHeight = 100;
        // pdf.getDefaultPageSize().getHeight();
        signimage.scaleToFit(signWidth, signHeight);

        // 배경 이미지 이벤트 핸들러 생성 및 등록
        BackgroundImageEventHandler handler = new BackgroundImageEventHandler(image);
        pdf.addEventHandler(PdfDocumentEvent.END_PAGE, handler);

        // 문서 제목 추가
        document.add(new Paragraph("성적증명서").setFont(font).setFontSize(24).setBold().setTextAlignment(TextAlignment.CENTER));
        document.add(new Paragraph("\n"));
        
        // 테두리 추가
        addPageBorder(pdf); // 테두리 추가 메소드 호출
        
        // 테이블 생성
        float[] pointColumnWidths = {100f, 100f};
        Table table = new Table(pointColumnWidths);
        table.setHorizontalAlignment(HorizontalAlignment.CENTER);
        
        // 테이블에 데이터 추가
        table.addCell(new Cell().add(new Paragraph("이름").setFont(font)));
        table.addCell(new Cell().add(new Paragraph(name).setFont(font)));
        table.addCell(new Cell().add(new Paragraph("학번").setFont(font)));
        table.addCell(new Cell().add(new Paragraph(student_id).setFont(font)));
        table.addCell(new Cell().add(new Paragraph("학과").setFont(font)));
        table.addCell(new Cell().add(new Paragraph(department_name).setFont(font)));
        
        
        // 중첩 테이블 생성 (성적 정보)
        Table gradeTable = new Table(new float[]{150f, 150f, 50f});
        gradeTable.setHorizontalAlignment(HorizontalAlignment.CENTER);
        
        Float total_mark = 0.0f;
        
        // 학기별로 성적처리하기
        if(semesterDateList != null) {
	        for(CertificateGradeDTO dto1 : semesterDateList) {
	        	
	        	String semesterdate =  dto1.getSemesterdate(); 
	        	
	        	String semeyear = semesterdate.substring(0,4);
	        	String sememonth = semesterdate.substring(5,7);
	        	String semester = "";
	        	if(sememonth.equals("07")) {
	        		semester = "2학기";
	        	}
	        	else {
	        		semester = "1학기";
	        	}
	        	
	        	// System.out.println("확인용 coursenumber : " + coursenumber);
	        	// System.out.println("확인용 coursename : " + coursename);
	        	// System.out.println("확인용 semesterdate : " + semesterdate);
	        	// System.out.println("확인용 mark : " + mark);
	        	
	            // 1행
	            gradeTable.addCell(new Cell(1,3).add(new Paragraph(semeyear+"년"+" "+semester).setFont(font)));
	            
	            // 테이블에 데이터 추가(리스트로 담을 것)
	            gradeTable.addCell(new Cell().add(new Paragraph("과목코드").setFont(font)));
	            gradeTable.addCell(new Cell().add(new Paragraph("과목명").setFont(font)));
	            gradeTable.addCell(new Cell().add(new Paragraph("학점").setFont(font)));

	            // 성적 정보 추가 (예시)
	            
	            List<CertificateGradeDTO> gradeList = certificateDao.gradeList(student_id, semesterdate); // 해당학기 수강내역
	            
	            for(CertificateGradeDTO dto : gradeList) {
	            	
	            	String coursename = dto.getCoursename();
	            	String str_coursenumber = String.valueOf(dto.getCoursenumber());
	            	
	            	Float mark = dto.getMark();
	            	if (mark == null) {
	                    mark = 0.0f;
	                }
	            	
	            	System.out.println("확인용 coursename : " + coursename);
	            	System.out.println("확인용 str_coursenumber : " + str_coursenumber);
	            	System.out.println("확인용 mark : " + mark);
	            	         	
	            	String str_mark = "";
	            	
	            	if(mark == 4.5) {
	            		str_mark = "A+";
	            	}
	            	else if(mark == 4.0) {
	            		str_mark = "A0";
	            	}
	            	else if(mark == 3.5) {
	            		str_mark = "B+";
	            	}
	            	else if(mark == 3.0) {
	            		str_mark = "B0";
	            	}
	            	else if(mark == 2.5) {
	            		str_mark = "C+";
	            	}
	            	else if(mark == 2.0) {
	            		str_mark = "C0";
	            	}
	            	else if(mark == 1.5) {
	            		str_mark = "D+";
	            	}
	            	else if(mark == 1.0) {
	            		str_mark = "D0";
	            	}
	            	else if(mark == 0.0) {
	            		str_mark = "F";
	            	}
	            	
	            	gradeTable.addCell(new Cell().add(new Paragraph(str_coursenumber).setFont(font)));
	                gradeTable.addCell(new Cell().add(new Paragraph(coursename).setFont(font)));
	                gradeTable.addCell(new Cell().add(new Paragraph(str_mark).setFont(font).setTextAlignment(TextAlignment.CENTER)));	            	
	            	
	                total_mark += mark;
	                
	            }// end of for(CertificateGradeDTO dto2 : gradeList)
	            
	            System.out.println("확인용 total_mark : "+total_mark);
	            
	            int count = gradeList.size();
	            System.out.println("확인용 count : "+count);
	            Float average = total_mark/count;
	            System.out.println("확인용 average : "+average);
	            String formattedAverage = String.format("%.2f", average);
	            gradeTable.addCell(new Cell(1,3).add(new Paragraph("평균 : "+formattedAverage).setFont(font)));
	        	  	
	        }//end for(CertificateGradeDTO dto1 : semesterDateList)
  
        }// end of if(gradeList != null)  
               
        
        // 테이블을 문서에 추가
        document.add(table);
        document.add(new Paragraph("\n"));
        document.add(gradeTable); 

        
        // 날짜와 서명 부분을 특정 위치에 추가 (setFixedPosition 사용)   
        
        // 문서 맺음말 추가
        Paragraph endParagraph = new Paragraph("위의 내용은 사실과 같음을 증명합니다.")
        		.setFont(font)
        		.setFontSize(16)
        		.setTextAlignment(TextAlignment.CENTER);
        
        Div endDiv = new Div()
                .add(endParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 200, 1000); // x, y, width를 의미한다.
        
        Paragraph dateParagraph = new Paragraph(Year + "년 " + Month + "월 " + Day + "일")
                .setFont(font)
                .setFontSize(16)
                .setTextAlignment(TextAlignment.CENTER);
        
        Div dateDiv = new Div()
                .add(dateParagraph)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 1000) / 2, 150, 1000); // 페이지 하단 150 포인트 위
        

		/*
		 * // 텍스트와 이미지를 포함하는 테이블 생성 Table signatureTable = new Table(new float[]{1, 1});
		 * signatureTable.setWidth(UnitValue.createPercentValue(100));
		 * signatureTable.setTextAlignment(TextAlignment.CENTER);
		 * 
		 * signatureTable.addCell(new Cell().add(new
		 * Paragraph("수 려 대 학 교  총 장").setFont(font).setFontSize(24).setBold().
		 * setTextAlignment(TextAlignment.RIGHT)).setBorder(Border.NO_BORDER));
		 * signatureTable.addCell(new
		 * Cell().add(signimage).setBorder(Border.NO_BORDER));
		 * 
		 * Div signatureDiv = new Div() .add(signatureTable)
		 * .setFixedPosition((pdf.getDefaultPageSize().getWidth() - 500) / 2, 50, 500);
		 * // 페이지 하단 50 포인트 위
		 */
        
        // 서명 텍스트는 위치를 변경하지 않음
        Paragraph signatureParagraph = new Paragraph("수 려 대 학 교  총 장")
                .setFont(font)
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER);
        
        Div signatureDiv = new Div() .add(signatureParagraph)
       		 	.setFixedPosition((pdf.getDefaultPageSize().getWidth() - 500) / 2, 100, 500);
        		

        // 이미지를 특정 위치에 배치하기 위해 div 사용
        Div imageDiv = new Div()
                .add(signimage)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() / 2) + 70, 75, signWidth); // 여기서 70은 y좌표
        
        document.add(endDiv);
        document.add(dateDiv);
        document.add(signatureDiv);
        document.add(imageDiv);

        document.close();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        
        String filename = "성적 증명서.pdf";
        String encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(encodedFilename)
                .build());
        
        headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
        
        return new ResponseEntity<>(baos.toByteArray(), headers, HttpStatus.OK);
	}
    
	
	// 재학증명서
	@Override
	public ResponseEntity<byte[]> download_attendingPdf(HttpServletRequest request) throws IOException {
		
       	ServletContext context = request.getServletContext();
        String imgPath = context.getRealPath("/resources/images/mainlogo.png");
        
        String signPath = context.getRealPath("/resources/images/sooRyeo_signature.png");
        
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
        
        ImageData signdata = ImageDataFactory.create(signPath);
        Image signimage = new Image(signdata);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float pageWidth = 500;
        // pdf.getDefaultPageSize().getWidth();
        float pageHeight = 500;
        // pdf.getDefaultPageSize().getHeight();
        image.scaleToFit(pageWidth, pageHeight);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float signWidth = 100;
        // pdf.getDefaultPageSize().getWidth();
        float signHeight = 100;
        // pdf.getDefaultPageSize().getHeight();
        signimage.scaleToFit(signWidth, signHeight);
 
        
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
        
        // 서명 텍스트는 위치를 변경하지 않음
        Paragraph signatureParagraph = new Paragraph("수 려 대 학 교  총 장")
                .setFont(font)
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER);
        
        Div signatureDiv = new Div() .add(signatureParagraph)
       		 	.setFixedPosition((pdf.getDefaultPageSize().getWidth() - 500) / 2, 100, 500);
        		

        // 이미지를 특정 위치에 배치하기 위해 div 사용
        Div imageDiv = new Div()
                .add(signimage)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() / 2) + 70, 75, signWidth); // 여기서 70은 y좌표
        
        document.add(endDiv);
        document.add(dateDiv);
        document.add(signatureDiv);
        document.add(imageDiv);
        
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
        
        String signPath = context.getRealPath("/resources/images/sooRyeo_signature.png");
        
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
        
        ImageData signdata = ImageDataFactory.create(signPath);
        Image signimage = new Image(signdata);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float pageWidth = 500;
        // pdf.getDefaultPageSize().getWidth();
        float pageHeight = 500;
        // pdf.getDefaultPageSize().getHeight();
        image.scaleToFit(pageWidth, pageHeight);
        
        // 이미지 크기 조정 (페이지 크기에 맞게)
        float signWidth = 100;
        // pdf.getDefaultPageSize().getWidth();
        float signHeight = 100;
        // pdf.getDefaultPageSize().getHeight();
        signimage.scaleToFit(signWidth, signHeight);
        
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
        
        // 서명 텍스트는 위치를 변경하지 않음
        Paragraph signatureParagraph = new Paragraph("수 려 대 학 교  총 장")
                .setFont(font)
                .setFontSize(24)
                .setBold()
                .setTextAlignment(TextAlignment.CENTER);
        
        Div signatureDiv = new Div() .add(signatureParagraph)
       		 	.setFixedPosition((pdf.getDefaultPageSize().getWidth() - 500) / 2, 100, 500);
        		

        // 이미지를 특정 위치에 배치하기 위해 div 사용
        Div imageDiv = new Div()
                .add(signimage)
                .setFixedPosition((pdf.getDefaultPageSize().getWidth() / 2) + 70, 75, signWidth); // 여기서 70은 y좌표
        
        document.add(endDiv);
        document.add(dateDiv);
        document.add(signatureDiv);
        document.add(imageDiv);
        
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
