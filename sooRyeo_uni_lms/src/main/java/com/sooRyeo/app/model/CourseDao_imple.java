package com.sooRyeo.app.model;

import java.sql.SQLException;
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

import oracle.sql.ROWID;

@Repository
public class CourseDao_imple implements CourseDao {

	@Autowired
	@Qualifier("sqlsession")
	SqlSessionTemplate sqlsession;

	@Override
	public int registerCourse(Course newCourse, Integer studentId) {

		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("fk_course_seq", newCourse.getCourse_seq());
		paraMap.put("student_id", studentId);

		int result = sqlsession.insert("course.registerCourse", paraMap);

		return result;
	}

	@Override
	public TimeTable getProfTimeTable(int prof_id) {
		List<Course> profCourse = sqlsession.selectList("course.getProfCourseList", prof_id);

		for (Course course : profCourse) {

			int course_seq = course.getCourse_seq();
			List<Time> times = sqlsession.selectList("course.getCourseTimes", course_seq);
			course.setTimeList(times);
		}

		return new ProfessorTimeTable(prof_id, profCourse);
	}

	@Override
	public int openCourse(Course newCourse, Integer prof_id) {
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("fk_professor_id", prof_id);
		paraMap.put("fk_curriculum_seq", newCourse.getFk_curriculum_seq());
		paraMap.put("capacity", newCourse.getCapacity());

		int result = sqlsession.insert("course.openCourse", paraMap);
		
		System.out.println(paraMap.get("course_seq"));

	    Integer course_seq = (Integer) paraMap.get("course_seq");

		for (Time time : newCourse.getTimeList()) {
			paraMap = new HashMap<String, Object>();
			paraMap.put("fk_course_seq", course_seq);
			paraMap.put("day_of_week", time.getDay_of_week());
			paraMap.put("start_period", time.getStart_period());
			paraMap.put("end_period", time.getEnd_period());

			result = sqlsession.insert("course.insertCourseTime", paraMap);
		}

		return result;
	}

	@Override
	public int updateToDeleteCourse(int course_seq) {
		
		return sqlsession.update("course.updateToDelete", course_seq);
	}

}