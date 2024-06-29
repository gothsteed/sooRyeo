package com.sooRyeo.app.model;

import com.sooRyeo.app.dto.CurriculumInsertRequestDto;

public interface CurriculumDao {

	int insertCurriculum(CurriculumInsertRequestDto requestDto);

}
