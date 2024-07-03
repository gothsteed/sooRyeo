package com.sooRyeo.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.model.StudentDao;

@Service
public class StudentService_imple implements StudentService {
	
	@Autowired
	private StudentDao dao;

	@Override
	public List<Map<String, String>> classList(int userid) {
		
		List<Map<String, String>> classList = dao.classList(userid);
		return classList;
	}
	
	

}
