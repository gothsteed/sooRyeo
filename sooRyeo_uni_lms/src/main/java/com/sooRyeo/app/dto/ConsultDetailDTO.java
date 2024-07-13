package com.sooRyeo.app.dto;

import com.sooRyeo.app.domain.Consult;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
public class ConsultDetailDTO {

    private String title;
    private Integer schedule_seq;
    private String start_date;
    private String end_date;
    private String content;

    private String StudentName;
    private String departmentName;
    private String email;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getSchedule_seq() {
        return schedule_seq;
    }

    public void setSchedule_seq(Integer schedule_seq) {
        this.schedule_seq = schedule_seq;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStudentName() {
        return StudentName;
    }

    public void setStudentName(String studentName) {
        StudentName = studentName;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public static ConsultDetailDTO toDTO(Consult consult) {
        return  new ConsultDetailDTO(consult.getSchedule().getTitle(),
                consult.getFk_schedule_seq(),
                consult.getSchedule().getStart_date(),
                consult.getSchedule().getEnd_date(),
                consult.getContent(),
                consult.getStudent().getName(),
                consult.getStudent().getDepartment().getDepartment_name(),
                consult.getStudent().getEmail());
    }
}
