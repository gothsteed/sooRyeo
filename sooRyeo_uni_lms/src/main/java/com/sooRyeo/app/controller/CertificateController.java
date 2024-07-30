package com.sooRyeo.app.controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
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
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
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

    @PostMapping(value="/student/certificate/enrollment.lms", produces="application/pdf")
    public ResponseEntity<byte[]> downloadEnrollmentCertificate(HttpServletRequest request) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4);
        PdfWriter writer = PdfWriter.getInstance(document, baos);

        document.open();

        // Add border
        PdfContentByte canvas = writer.getDirectContent();
        Rectangle rect = new Rectangle(36, 36, PageSize.A4.getWidth() - 36, PageSize.A4.getHeight() - 36);
        rect.setBorder(Rectangle.BOX);
        rect.setBorderWidth(2);
        canvas.rectangle(rect);

        // Title
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 30, Font.BOLD);
        Paragraph title = new Paragraph("Certificate of Enrollment", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(50);
        document.add(title);

        // Content
        Font contentFont = new Font(Font.FontFamily.HELVETICA, 14);
        Paragraph content = new Paragraph(
                "This is to certify that\n\n" +
                        "[Student Name]\n\n" +
                        "is officially enrolled as a student at\n\n" +
                        "[Institution Name]\n\n" +
                        "for the academic year [Year] - [Year]",
                contentFont
        );
        content.setAlignment(Element.ALIGN_CENTER);
        document.add(content);

        // Signatures
        PdfPTable signatureTable = new PdfPTable(3);
        signatureTable.setWidthPercentage(100);
        signatureTable.addCell(createSignatureCell(""));
        signatureTable.addCell(createSignatureCell(""));
        signatureTable.addCell(createSignatureCell("Registrar"));

        // Position the signature table at the bottom
        signatureTable.setTotalWidth(document.getPageSize().getWidth() - document.leftMargin() - document.rightMargin());
        signatureTable.writeSelectedRows(0, -1, document.leftMargin(), document.bottomMargin() + 50, writer.getDirectContent());

        String resourcePath = request.getServletContext().getRealPath("/resources/images");
        addImageWatermark(writer, resourcePath + File.separator + "mainlogo.png");

        document.close();

        byte[] pdfBytes = baos.toByteArray();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("attachment", "enrollment_certificate.pdf");

        return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
    }

    private void addImageWatermark(PdfWriter writer, String imagePath) throws IOException, DocumentException {
        PdfContentByte canvas = writer.getDirectContentUnder();
        Image image = Image.getInstance(ResourceUtils.getFile(imagePath).getAbsolutePath());
        image.scaleToFit(500, 500);
        // 이미지 중앙 정렬을 위해 위치 조정
        image.setAlignment(Image.ALIGN_CENTER);
        image.setAbsolutePosition((PageSize.A4.getWidth() - image.getScaledWidth()) / 2,
                (PageSize.A4.getHeight() - image.getScaledHeight()) / 2 - 50); // -50은 제목과의 간격 조정
        image.setTransparency(new int[]{0x04, 0x10});
        canvas.addImage(image);
    }

    private PdfPCell createSignatureCell(String text) {
        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.NO_BORDER);
        Paragraph line = new Paragraph("_______________________");
        line.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(line);
        Paragraph content = new Paragraph(text);
        content.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(content);
        return cell;
    }



}
