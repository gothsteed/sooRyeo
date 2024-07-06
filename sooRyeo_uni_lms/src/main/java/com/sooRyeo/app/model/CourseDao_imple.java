package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.domain.Time;
import com.sooRyeo.app.domain.TimeTable;

@Repository
public class CourseDao_imple implements CourseDao {
	
	@Autowired
	@Qualifier("sqlsession")
	SqlSessionTemplate sqlsession;

	@Override
	public int registerCourse(Course newCourse,  Integer studentId) {
		
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("fk_course_seq", newCourse.getCourse_seq());
		paraMap.put("student_id", studentId);
		
		int result = sqlsession.insert("course.registerCourse", paraMap);
		
		
		return result;
	}

	@Override
	public TimeTable getProfTimeTable(int prof_id) {
		List<Course> profCourse = sqlsession.selectList("course.getProfCourseList", prof_id);
		
		for(Course course : profCourse) {
			
			int course_seq = course.getCourse_seq();
			List<Time> times = sqlsession.selectList("course.getCourseTimes", course_seq);
			course.setTimeList(times);
		}
		
		return new ProfessorTimeTable(prof_id, profCourse);
	}

}
