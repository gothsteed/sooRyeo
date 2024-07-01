package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.LoginDTO;

public interface StudentDao {

	Student selectStudent(LoginDTO loginDTO);

}
