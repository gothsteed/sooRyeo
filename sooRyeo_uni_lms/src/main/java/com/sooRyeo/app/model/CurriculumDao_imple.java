package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.CurriculumInsertRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;

@Repository
public class CurriculumDao_imple  implements CurriculumDao{
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSession sqlsession;

	@Override
	public int insertCurriculum(CurriculumInsertRequestDto requestDto) {
		return sqlsession.insert("curriculum.insertCurriculum", requestDto);
	}
	
	private int getCurriculumCount(Integer fk_department_seq, Integer grade) {
		Map<String, Object> paraMap = new HashMap<>();

		paraMap.put("fk_department_seq", fk_department_seq);
		paraMap.put("grade", grade);
		
		
		return sqlsession.selectOne("curriculum.getCurriculumCount", paraMap);
	}

	@Override
	public Pager<Curriculum> getCurriculumPage(CurriculumPageRequestDto requestDto, int sizePerPage) {
		Map<String, Object> paraMap = new HashMap<>();

		paraMap.put("fk_department_seq", requestDto.getFk_department_seq());
		paraMap.put("grade", requestDto.getGrade());
		paraMap.put("currentShowPageNo", requestDto.getCurrentPage());

		int startRno = ((requestDto.getCurrentPage()- 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호
		paraMap.put("startRno", startRno);
		paraMap.put("endRno", endRno);

		List<Curriculum> curriculumList = sqlsession.selectList("curriculum.getCurriculumList", paraMap);
		int totalCurriculumCount = getCurriculumCount(requestDto.getFk_department_seq(), requestDto.getGrade());

		return new Pager<Curriculum>(curriculumList, requestDto.getCurrentPage(), sizePerPage, totalCurriculumCount);
	}

}
