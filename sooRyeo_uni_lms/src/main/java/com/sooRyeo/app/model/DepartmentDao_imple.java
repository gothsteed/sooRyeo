package com.sooRyeo.app.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Department;

@Repository
public class DepartmentDao_imple implements DepartmentDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Department> departmentList_select() {
		
		List<Department> departmentList = sqlSession.selectList("department.departmentList_select");
		return departmentList;
	}

}
