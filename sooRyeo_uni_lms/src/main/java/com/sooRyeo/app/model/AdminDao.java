package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.dto.LoginDTO;

public interface AdminDao {
	
	// 관리자 로그인
	Admin selectAdmin(LoginDTO loginDTO);

}
