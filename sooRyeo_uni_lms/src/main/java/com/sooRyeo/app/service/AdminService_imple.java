package com.sooRyeo.app.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.CurriculumInsertRequestDto;
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
	
	// select 태그에 학과를 전부 불러오는 메소드
	//TODO ****departmentDao 사용해주세요1!!!!
	@Override
	public List<Department> departmentList_select() {
		
		// select 태그에 학과를 전부 불러오는 메소드
		List<Department> departmentList = admindao.departmentList_select();
		return departmentList;
	}

	// 학생 회원 등록정보를 인서트 하는 메소드
	@Override
	public int memberRegister_end(RegisterDTO rdto) {
		int n = admindao.memberRegister_end(rdto);
		return n;
	}

	@Override
	public List<Department> getDeptartments() {
		List<Department> departmentList = departmentDao.departmentList_select();
		return departmentList;
	}

	@Override
	public ModelAndView insertCurriculum(HttpServletRequest request, ModelAndView mav, CurriculumInsertRequestDto requestDto) {
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
		
		mav.setViewName("curriculum.admin");
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
			jsonObj.put("fk_department_seq", curr.getCurriculum_seq());
			jsonObj.put("grade", curr.getGrade());
			jsonObj.put("name", curr.getName());
			jsonObj.put("credit", curr.getCredit());
			
			jsonArr.put(jsonObj);
			
		}
		
		
		result.put("curriculumList", jsonArr);
	
		
		return result.toString();
	}
	
	

}
