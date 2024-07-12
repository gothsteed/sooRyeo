package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.AssignJoinSchedule;
import com.sooRyeo.app.domain.Assignment;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.domain.Time;
import com.sooRyeo.app.domain.TimeTable;
import com.sooRyeo.app.dto.AssignScheInsertDTO;
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


	@Override
	public List<Map<String, String>> paperAssignment(String fk_course_seq) {
		
		List<Map<String, String>> paperAssignment = sqlSession.selectList("professor.paperAssignment", fk_course_seq);
		
		return paperAssignment;
	}


	@Override
	public AssignJoinSchedule assign_view(Map<String, String> paraMap) {
		
		AssignJoinSchedule assign_view = sqlSession.selectOne("professor.assign_view", paraMap);
		
		return assign_view;
	}

	
	@Override
	public int insert_tbl_schedule(AssignScheInsertDTO dto, String fk_course_seq) {
		
		int n = 0;
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("title", dto.getTitle());
		paraMap.put("startDate", dto.getStartDate());
		paraMap.put("endDate", dto.getEndDate());
		
		
		n = sqlSession.insert("professor.insert_tbl_schedule", paraMap);
		
		if(n != 0) {
			
			String schedule_seq = String.valueOf(paraMap.get("schedule_seq"));
			System.out.println("확인용 schedule_seq : " + schedule_seq);
			System.out.println("확인용 fk_course_seq2 : " + fk_course_seq);
			
			paraMap.put("fk_course_seq", fk_course_seq);
			paraMap.put("content", dto.getContent());
			paraMap.put("schedule_seq_assignment", schedule_seq);
			paraMap.put("attatched_file", dto.getAttatched_file());
			
			String attatched_file = paraMap.get("attatched_file");
			System.out.println("확인용 attatched_file : " + attatched_file);
			
			n = sqlSession.insert("professor.insert_tbl_assignment", paraMap);
				
		}
		
		
		return n;
	}


	@Override
	public Assignment select_attached_name(String schedule_seq_assignment) {
		
		Assignment select_attached_name = sqlSession.selectOne("professor.select_attached_name", schedule_seq_assignment);
		
		return select_attached_name;
	}
	
	
	@Override
	public int assignmentDelete(String schedule_seq_assignment) {
		
		int n = 0;		
		
		n = sqlSession.delete("professor.assignmentDelete", schedule_seq_assignment);
		
		return n;
	}

	
	@Override
	public AssignJoinSchedule assignmentEdit(String schedule_seq_assignment) {
		
		AssignJoinSchedule assign_edit = sqlSession.selectOne("professor.assignmentEdit", schedule_seq_assignment);
		
		return assign_edit;
	}











}
