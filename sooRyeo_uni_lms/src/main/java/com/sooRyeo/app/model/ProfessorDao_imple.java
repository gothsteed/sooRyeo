package com.sooRyeo.app.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.AssignJoinSchedule;
import com.sooRyeo.app.domain.Assignment;
import com.sooRyeo.app.domain.AssignmentSubmit;
import com.sooRyeo.app.domain.Course;
import com.sooRyeo.app.domain.Lecture;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.ProfessorTimeTable;
import com.sooRyeo.app.domain.Student;
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
	public int getTotalElementCount(String fk_course_seq) {
		int n = sqlSession.selectOne("professor.getTotalElementCount", fk_course_seq);
		return n;
	}
	
	@Override
	public Pager<Map<String, String>> studentList(String fk_course_seq, int currentPage) {
		
		int sizePerPage = 5;
		
		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("startRno", startRno);
		paraMap.put("endRno", endRno);
		paraMap.put("currentShowPageNo", currentPage);
		paraMap.put("fk_course_seq", fk_course_seq);
		List<Map<String, String>> studentList = sqlSession.selectList("professor.studentList", paraMap);
		
		int totalElementCount = sqlSession.selectOne("professor.getTotalElementCount", fk_course_seq);
		
		return new Pager(studentList, currentPage, sizePerPage, totalElementCount);
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
			paraMap.put("orgfilename", dto.getOrgfilename());
			
			String orgfilename = dto.getOrgfilename();
			String attatched_file = paraMap.get("attatched_file");
			
			System.out.println("확인용 attatched_file : " + attatched_file);
			System.out.println("확인용 orgfilename : " + orgfilename);
			
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


	@Override
	public int delAttatched_file(String schedule_seq_assignment) {
		
		int n = sqlSession.update("professor.delAttatched_file", schedule_seq_assignment);
		
		return n;
	}


	@Override
	public int assignmentEdit_End(AssignScheInsertDTO dto) {
		
		int n = 0;
		String schedule_seq_assignment = String.valueOf(dto.getSchedule_seq_assignment());
		//System.out.println("확인용 dto 시작 " + dto.getStartDate());
		//System.out.println("확인용 dto 끝 " + dto.getEndDate());
		//System.out.println("확인용 dto 제목 " + dto.getTitle());
			
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("title", dto.getTitle());
		paraMap.put("startDate", dto.getStartDate());
		paraMap.put("endDate", dto.getEndDate());
		paraMap.put("schedule_seq_assignment", schedule_seq_assignment);
		
		n = sqlSession.update("professor.update_tbl_schedule", paraMap);
		
		if(n != 0) {
			
			paraMap.put("content", dto.getContent());
			paraMap.put("attatched_file", dto.getAttatched_file());
			paraMap.put("orgfilename", dto.getOrgfilename());
			
			String attatched_file = paraMap.get("attatched_file");
			System.out.println("확인용 attatched_file : " + attatched_file);
			
			n = sqlSession.update("professor.update_tbl_assignment", paraMap);
				
		}		
		
		return n;
	}


	@Override
	public AssignScheInsertDTO file_check(String schedule_seq_assignment) {
		
		AssignScheInsertDTO file_check = sqlSession.selectOne("professor.file_check", schedule_seq_assignment);
		
		return file_check;
	}


	@Override
	public List<Map<String, String>> assignmentCheckJSON(String schedule_seq_assignment) {
		
		List<Map<String, String>> assignmentCheckJSON = sqlSession.selectList("professor.assignmentCheckJSON", schedule_seq_assignment);
		
		return assignmentCheckJSON;
	}
	
	
	@Override
	public AssignmentSubmit searchsubmitFile(String assignment_submit_seq) {
		
		AssignmentSubmit assignsub = sqlSession.selectOne("professor.searchsubmitFile", assignment_submit_seq);
		
		return assignsub;
	}
	
	
	@Override
	public int scoreUpdate(Map<String, String> paraMap) {
		
		int n = 0;
		
		try {
			n = sqlSession.update("professor.scoreUpdate", paraMap);
		} catch (DataIntegrityViolationException e) {
			
		}
		return n;
	}

	
	@Override
	public Assignment searchFile(String schedule_seq_assignment) {
		
		Assignment assignment = sqlSession.selectOne("professor.searchFile", schedule_seq_assignment);
		
		return assignment;
	}


	@Override
	public Pager<Announcement> getAnnouncement(int currentPage) {
		Map<String, Object> paraMap = new HashMap<>();
		
		int sizePerPage = 5;
		
		int startRno = ((currentPage- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		
		paraMap.put("startRno", startRno);
		paraMap.put("endRno", endRno);
		paraMap.put("currentShowPageNo", currentPage);
		List<Announcement> announcementList = sqlSession.selectList("board.getAnnouncement", paraMap);
		
		int A_totalElementCount = sqlSession.selectOne("board.getA_TotalElementCount", paraMap);
		return new Pager(announcementList, currentPage, sizePerPage, A_totalElementCount);
	}


	@Override
	public ProfessorTimeTable courseListJson(String semester, int prof_id) {
		
		Map<String, Object> paraMap = new HashMap<>();
        paraMap.put("semester_date", semester);
        paraMap.put("prof_id", prof_id);		
		 
        List<Course> courseListJson = sqlSession.selectList("professor.courseListJson", paraMap); 
		
        
        for(Course course : courseListJson) {
			
			int course_seq = course.getCourse_seq();
			List<Time> times = sqlSession.selectList("professor.courseListTimeJson", course_seq);
			course.setTimeList(times);
		}
        
		return new ProfessorTimeTable(prof_id, courseListJson);
	}
	
	
	@Override
	public String Student_pic(int student_id) {
		
		String Student_pic = sqlSession.selectOne("professor.Student_pic", student_id);
		
		return Student_pic;
	}
	

	@Override
	public Map<String, Object> score_checkJSON(int student_id, int fk_course_seq) {
		
		Map<String, Object> ScoreMap = new HashMap<>(); 
		
		Map<String, Object> paraMap = new HashMap<>();
        paraMap.put("student_id", student_id);
        paraMap.put("fk_course_seq", fk_course_seq);
        
        int assignmentTotal = 0;
        
        try {
        	assignmentTotal = sqlSession.selectOne("professor.assignmentTotal", paraMap); // 과제 총점
		} catch (Exception e) {
			
		}    
        
        int assignmentCount = sqlSession.selectOne("professor.assignmentCount", fk_course_seq); // 과제 갯수
        
        int regi_course_seq = sqlSession.selectOne("professor.regi_course_seq", paraMap);
        
        paraMap.put("regi_course_seq", regi_course_seq);
        
        Object mark = null;
        
        try {
        	mark = (double)sqlSession.selectOne("professor.mark", paraMap);
		} catch (Exception e) {

		}
        
        
        System.out.println("확인용 assignmentTotal : " + assignmentTotal);
        System.out.println("확인용 assignmentCount : " + assignmentCount);
        System.out.println("확인용 regi_course_seq : " + regi_course_seq);
        
        double assignmentScore = 0;
        
        if(assignmentTotal != 0 && assignmentCount != 0) {
        	assignmentScore = ((double)assignmentTotal/assignmentCount);
        }
        
        System.out.println("확인용 dao에서 assignmentScore : " + assignmentScore);
		
        ScoreMap.put("assignmentScore", assignmentScore);
        ScoreMap.put("regi_course_seq", regi_course_seq);
        ScoreMap.put("mark", mark);
        
		return ScoreMap;
	}


	@Override
	public int insertGradeEnd(Map<String, Object> paraMap) {
		
		int n = 0;
		
		try {
			n = sqlSession.insert("professor.insertGradeEnd", paraMap);
		} catch (Exception e) {
			
		}		

		return n;
		
	}


	@Override
	public int editGradeEnd(Map<String, Object> paraMap) {
		
		int n = 0;
		
		try {
			n = sqlSession.update("professor.editGradeEnd", paraMap);
		} catch (Exception e) {
			
		}		

		return n;
	}


	@Override
	public int examCount(int fk_course_seq) {
		
		int examCount = sqlSession.selectOne("professor.examCount", fk_course_seq);
		
		return examCount;
	}


	@Override
	public double attendanceRate(int student_id, int fk_course_seq) {		
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("student_id", student_id);
		paraMap.put("fk_course_seq", fk_course_seq);
		
		int totalLecture = sqlSession.selectOne("professor.totalLecture", fk_course_seq);
				
		int totalAttendance = sqlSession.selectOne("professor.totalAttendance", paraMap);
		
		
        double attendanceRate = 0;
        
        if(totalLecture != 0 && totalAttendance != 0) {
        	attendanceRate = ((double)totalAttendance/totalLecture)*100;
        }
					
		return attendanceRate;
	}




















}
