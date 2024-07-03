package com.sooRyeo.app.model;

import java.util.List;
import java.util.Map;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;

public interface StudentDao {

	Student selectStudent(LoginDTO loginDTO);

	// 수업명, 교수명  select
	List<Map<String, String>> classList(int userid);

}
