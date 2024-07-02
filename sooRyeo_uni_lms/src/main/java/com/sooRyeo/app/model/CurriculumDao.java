package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.dto.CurriculumInsertRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;
import com.sooRyeo.app.pager.Pager;

public interface CurriculumDao {

	int insertCurriculum(CurriculumInsertRequestDto requestDto);

	Pager<Curriculum> getCurriculumPage(CurriculumPageRequestDto requestDto, int sizePerPage);

}