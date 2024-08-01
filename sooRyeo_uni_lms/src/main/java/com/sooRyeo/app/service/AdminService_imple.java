package com.sooRyeo.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.domain.StudentStatusChange;
import com.sooRyeo.app.dto.CurriculumRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;
import com.sooRyeo.app.dto.RegisterDTO;
import com.sooRyeo.app.model.AdminDao;
import com.sooRyeo.app.model.CurriculumDao;
import com.sooRyeo.app.model.DepartmentDao;

@Service
public class AdminService_imple implements AdminService {

	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private AdminDao admindao; 
	
	@Autowired
	private DepartmentDao departmentDao;
	
	@Autowired
	private CurriculumDao curriculumDao;
	
	@Autowired
	private AES256 aes;
	
	// select 태그에 학과를 전부 불러오는 메소드
	//TODO ****departmentDao 사용해주세요1!!!!
	@Override
	public List<Department> departmentList_select() {
		
		// select 태그에 학과를 전부 불러오는 메소드
		List<Department> departmentList = departmentDao.departmentList_select();
		return departmentList;
	}

	// 학생 회원 등록정보를 인서트 하는 메소드
	@Override
	public int memberRegister_end(RegisterDTO rdto) {
		System.out.println(rdto.getEmail());
		System.out.println(rdto.getTel());
		
		try {
			rdto.setEmail(aes.encrypt(rdto.getEmail()));
			rdto.setTel(aes.encrypt(rdto.getTel()));
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		int n = admindao.memberRegister_end(rdto);
		return n;
	}
	
	// 회원등록시 입력한 이메일이 이미 있는 이메일인지 검사하는 메소드
	@Override
	public String emailDuplicateCheck(String email) {
		
		String emailDuplicateCheck = "";
		try {
			emailDuplicateCheck = admindao.emailDuplicateCheck(aes.encrypt(email));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return emailDuplicateCheck;
	}

	@Override
	public List<Department> getDeptartments() {
		List<Department> departmentList = departmentDao.departmentList_select();
		return departmentList;
	}

	@Override
	public ModelAndView insertCurriculum(HttpServletRequest request, ModelAndView mav, CurriculumRequestDto requestDto) {
		int n = curriculumDao.insertCurriculum(requestDto);
		
		
		
		if(n != 1) {
			mav.addObject("loc", request.getContextPath()+ "/admin/dashboard.lms");
			
			mav.addObject("message", "등록에 실패하였습니다");
			mav.setViewName("msg");
			
			return mav;
		}
		
		mav.setViewName("redirect:/admin/dashboard.lms");
		
		return mav;
	}

	@Override
	public ModelAndView ShowCurriculumPage(HttpServletRequest request, ModelAndView mav) {
		
		List<Department> departments =  departmentDao.departmentList_select();
		mav.addObject("departments", departments);
		
		mav.setViewName("curriculum");
		return mav;
	}

	@Override
	public String getCurriculumPage(HttpServletRequest request, ModelAndView mav, CurriculumPageRequestDto requestDto) {
		
		int sizePerPage = 10;
		
		Pager<Curriculum> page = curriculumDao.getCurriculumPage(requestDto, sizePerPage);

		JSONObject result = new JSONObject();
		result.put("pageBar", page.makeScriptPageBar("fetchData"));
		
		JSONArray jsonArr = new JSONArray();
		
		for(Curriculum curr : page.getObjectList()) {
			JSONObject jsonObj = new JSONObject(); 
			
			jsonObj.put("curriculum_seq", curr.getCurriculum_seq());
			jsonObj.put("department_name", curr.getDepartment_name());
			jsonObj.put("fk_department_seq", curr.getFk_department_seq());
			jsonObj.put("grade", curr.getGrade());
			jsonObj.put("name", curr.getName());
			jsonObj.put("credit", curr.getCredit());
			jsonObj.put("required", curr.getRequired());
			
			jsonArr.put(jsonObj);
			
		}

		result.put("curriculumList", jsonArr);
		
		
		return result.toString();
	}


	@Override
	public ResponseEntity<String> deleteCurriculum(HttpServletRequest request, ModelAndView mav) throws NumberFormatException {
		
		int curriculum_seq = Integer.parseInt( request.getParameter("curriculum_seq"));
		
		int result = curriculumDao.deleteCurriculum(curriculum_seq);
		
		
		if(result != 1) {
			System.out.println("삭제실패");
			return ResponseEntity.status(500).body("삭제에 실패하였습니다");
		}
		
		System.out.println("삭제성공");
		return ResponseEntity.ok().body("삭제 성공하였습니다");
		
	}

	@Override
	public ResponseEntity<String> updateCurriculum(HttpServletRequest request, ModelAndView mav,
			CurriculumRequestDto requestDto) {
		
		
		int result  = curriculumDao.updateCurriculum(requestDto);
		
		
		if(result != 1) {
			System.out.println("수정 실패");
			return ResponseEntity.status(500).body("수정에 실패하였습니다");
		}
		
		
		System.out.println("수정 성공");
		return ResponseEntity.ok().body("수정 성공하였습니다");
	}
	
	@Override
	public ModelAndView makeCourseRegiseterPage(HttpServletRequest request, ModelAndView mav) {
		mav.addObject("departments", departmentDao.departmentList_select());
		mav.setViewName("courseRegister");
		return mav;
	}

	@Override
	public List<Map<String, String>> studentCntByDeptname() {
		List<Map<String, String>> deptnamePercentageList = admindao.studentCntByDeptname();
	    return deptnamePercentageList;
	}

	// 학적변경신청한 학생들을 전부 불러오는 메소드
	@Override
	public List<StudentStatusChange> application_status_student() {
		List<StudentStatusChange> application_status_student = admindao.application_status_student();
	    return application_status_student;
	}

	// 관리자가 승인 혹은 반려한 신청을 삭제해주는 메소드
	@Override
	public int deleteApplication(String student_id) {
		int n = admindao.deleteApplication(student_id);
		return n;
	}
	
	// 관리자가 승인을 해주면 학생의 학적 상태를 업데이트 해주는 메소드
	@Override
	public int updateStudentStatus(String student_id, String change_status) {
		int n = admindao.updateStudentStatus(student_id, change_status);
		return n;
	}

	@Override
	public List<Student> getStudenList() {
		List<Student> studenList = admindao.getStudenList();
	    return studenList;
	}

	@Override
	public List<Professor> getProfessorList() {
		List<Professor> professorList = admindao.getProfessorList();
	    return professorList;
	}




	

}