package com.sooRyeo.app.domain;


import lombok.Getter;

@Getter
public class Assignment  {
	
    private Integer schedule_seq_assignment;
    private Integer fk_course_seq;
    private String content;
    private String attatched_file;
    private String orgfilename;

    private Schedule schedule;


}
