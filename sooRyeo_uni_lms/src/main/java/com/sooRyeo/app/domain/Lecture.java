package com.sooRyeo.app.domain;

import com.sooRyeo.app.model.CourseDao;

import java.util.Date;

public class Lecture {
	
    private Integer lecture_seq;
    private Integer fk_course_seq;
    private String video_file_name;
	private String upload_video_file_name;
    private String lecture_file_name;
	private String upload_lecture_file_name;
    private String lecture_title;
    private String lecture_content;
    private Date start_date;
    private Date end_date;
    
    
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
	public Date getStart_date() {
		return start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}


	public String getUpload_video_file_name() {
		return upload_video_file_name;
	}

	public String getUpload_lecture_file_name() {
		return upload_lecture_file_name;
	}

	public boolean checkLectureAuth(CourseDao courseDao, Professor professor) {
		Course course = courseDao.getCourse(fk_course_seq);
		return professor.getProf_id().equals(course.getFk_professor_id());
	}

}
