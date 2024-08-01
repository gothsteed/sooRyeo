package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.dto.CertificateGradeDTO;

@Repository
public class CertificateDao_imple implements CertificateDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<CertificateGradeDTO> semesterdateList(String student_id) {
		
		List<CertificateGradeDTO> semesterdateList = sqlSession.selectList("certificate.semesterdateList", student_id);
		
		return semesterdateList;
	}
	
	@Override
	public List<CertificateGradeDTO> gradeList(String student_id, String semesterdate) {
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("student_id", student_id);
		paraMap.put("semesterdate", semesterdate);
		
		List<CertificateGradeDTO> gradeList = sqlSession.selectList("certificate.gradeList", paraMap);
		
		return gradeList;
	}



}
