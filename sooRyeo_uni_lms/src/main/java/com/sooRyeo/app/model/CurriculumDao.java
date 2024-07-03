package com.sooRyeo.app.model;

import com.sooRyeo.app.domain.Curriculum;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.dto.CurriculumRequestDto;
import com.sooRyeo.app.dto.CurriculumPageRequestDto;

public interface CurriculumDao {

	int insertCurriculum(CurriculumRequestDto requestDto);

	Pager<Curriculum> getCurriculumPage(CurriculumPageRequestDto requestDto, int sizePerPage);

	int deleteCurriculum(int curriculum_seq);

	int updateCurriculum(CurriculumRequestDto requestDto);

}
