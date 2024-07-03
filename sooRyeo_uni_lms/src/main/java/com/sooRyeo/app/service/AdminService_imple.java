package com.sooRyeo.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Department;
import com.sooRyeo.app.dto.CurriculumInsertRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;
import com.sooRyeo.app.dto.RegisterDTO;
import com.sooRyeo.app.model.AdminDao;
import com.sooRyeo.app.model.CurriculumDao;
import com.sooRyeo.app.model.DepartmentDao;
import com.sooRyeo.app.pager.Pager;

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
	private AES256 aES256; 
	
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
		
		
		mav.setViewName("curriculum.admin");
		return mav;
	}

	@Override
	public ModelAndView getCurriculumPage(HttpServletRequest request, ModelAndView mav, CurriculumPageRequestDto requestDto) {
		
		int sizePerPage = 10;
		
		Pager<Curriculum> page = curriculumDao.getCurriculumPage(requestDto, sizePerPage);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Curriculum curr : page.getObjectList()) {
			JSONObject jsonObj = new JSONObject(); 
			
//			jsonObj.put("name", curr.get)
			
		}
		
		
		return null;
	}

	@Override
	public List<Announcement> getAnnouncement(Announcement an) {
		List<Announcement> announcementList = admindao.getAnnouncement(an);
		return announcementList;
	}
	
	

}