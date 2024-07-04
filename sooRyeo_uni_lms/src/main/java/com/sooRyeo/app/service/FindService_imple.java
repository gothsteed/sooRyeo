package com.sooRyeo.app.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.model.FindDao;
import com.sooRyeo.app.common.AES256;
import com.sooRyeo.app.common.Sha256;

@Service
public class FindService_imple implements FindService {
	
	@Autowired
	private FindDao FindDao;
	
    @Autowired
    private AES256 aes;
    
    

	@Override
	public String idFind(String name, String email, String memberType) {
		
		String memberEmail = "";
		
		try {
			memberEmail = aes.encrypt(email);
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		String userid = FindDao.idfind(name, memberEmail, memberType);
		return userid;
		

	}


	
	// 데이터베이스에 회원이 존재하는지 확인하는 메소드
	@Override
	public boolean memberCheck(String id, String email, String memberType) {
		
		String memberEmail = "";
		
		try {
			memberEmail = aes.encrypt(email);
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		 
		boolean isUserExist = FindDao.memberCheck(id, memberEmail, memberType);
		return isUserExist;
	}


	// 비밀번호 변경
	@Override
	public int pwdFindEnd(String pwd, String userid, String memberType) {
		String memberpwd = Sha256.encrypt(pwd);
		int n = FindDao.pwdFindEnd(memberpwd, userid, memberType);
		return n;
	}
	





}
