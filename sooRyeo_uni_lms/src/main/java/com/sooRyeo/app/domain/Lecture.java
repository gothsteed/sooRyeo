package com.sooRyeo.app.domain;

import com.sooRyeo.app.model.CourseDao;
import lombok.Getter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
public class Lecture {
	
    private Integer lecture_seq;
    private Integer fk_course_seq;
    private String video_file_name;
	private String upload_video_file_name;
    private String lecture_title;
    private String lecture_content;
    private Date start_date;
    private Date end_date;
    private Integer lecture_time;

	private List<LectureAttachedFile> attachedFileList = new ArrayList<>();
    


	public boolean checkLectureAuth(CourseDao courseDao, Professor professor) {
		Course course = courseDao.getCourse(fk_course_seq);
		return professor.getProf_id().equals(course.getFk_professor_id());
	}

}
