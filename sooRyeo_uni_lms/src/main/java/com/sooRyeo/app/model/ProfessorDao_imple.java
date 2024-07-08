package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.domain.Time;
import com.sooRyeo.app.domain.TimeTable;
import com.sooRyeo.app.dto.LoginDTO;

@Repository
public class ProfessorDao_imple implements ProfessorDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	
	
	

	@Override
	public Professor selectProfessor(LoginDTO loginDTO) {
		
		Professor professor = sqlSession.selectOne("professor.selectProfessor", loginDTO);
		return professor;
	}


	@Override
	public Professor getInfo(Professor loginuser) {
		
		Professor professor = sqlSession.selectOne("professor.selectInfo", loginuser);		
		
		return professor;
	}


	@Override
	public int pwdDuplicateCheck(Map<String, String> paraMap) {
		
		// System.out.println("확인용 pwd : "+ pwd);
		
		int n = sqlSession.selectOne("professor.pwdDuplicateCheck", paraMap);
		
		return n;
	}


	@Override
	public int telDuplicateCheck(Map<String, String> paraMap) {
		
		int n = sqlSession.selectOne("professor.telDuplicateCheck", paraMap);
		
		return n;
	}


	@Override
	public int emailDuplicateCheck(Map<String, String> paraMap) {
		
		int n = sqlSession.selectOne("professor.emailDuplicateCheck", paraMap);
		
		return n;
	}


	@Override
	public int professor_info_edit(Map<String, String> editMap) {
		
		int n = sqlSession.update("professor.professor_info_edit", editMap);
		
		return n;
	}


	@Override
	public Professor select_file_name(Map<String, String> editMap) {
		
		Professor professor = sqlSession.selectOne("professor.select_file_name", editMap);
		
		return professor;
	}


	@Override
	public int delFilename(String prof_id) {
		
		int n = sqlSession.update("professor.delFilename", prof_id);
		
		return n;
	}


	@Override
	public ProfessorTimeTable getProfTimeTable(int prof_id) {
		
		List<Course> profCourseList = sqlSession.selectList("professor.getProfCourseList", prof_id);
		
		for(Course course : profCourseList) {
			
			int course_seq = course.getCourse_seq();
			List<Time> times = sqlSession.selectList("professor.getCourseTimeList", course_seq);
			course.setTimeList(times);
		}
		
		return new ProfessorTimeTable(prof_id, profCourseList);
	}
	
	
	@Override
	public List<Map<String, String>> studentList(String fk_course_seq) {
		
		List<Map<String, String>> studentList = sqlSession.selectList("professor.studentList", fk_course_seq);
		
		return studentList;
	}






}
