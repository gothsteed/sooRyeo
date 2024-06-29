package com.sooRyeo.app.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.dto.CurriculumInsertRequestDto;

@Repository
public class CurriculumDao_imple  implements CurriculumDao{
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSession sqlsession;

	@Override
	public int insertCurriculum(CurriculumInsertRequestDto requestDto) {
		return sqlsession.insert("curriculum.insertCurriculum", requestDto);
	}

}
