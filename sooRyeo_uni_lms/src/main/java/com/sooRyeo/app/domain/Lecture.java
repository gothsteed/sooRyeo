package com.sooRyeo.app.domain;

public class Lecture {
	
    private Integer lecture_seq;
    private Integer fk_course_seq;
    private String video_file_name;
    private String lecture_file_name;
    private String lecture_title;
    private String lecture_content;
    
    
	public Integer getLecture_seq() {
		return lecture_seq;
	}
	public Integer getFk_course_seq() {
		return fk_course_seq;
	}
	public String getVideo_file_name() {
		return video_file_name;
	}
	public String getLecture_file_name() {
		return lecture_file_name;
	}
	public String getLecture_title() {
		return lecture_title;
	}
	public String getLecture_content() {
		return lecture_content;
	}
    
    
    

}
