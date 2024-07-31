package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.sooRyeo.app.domain.Menu;


@Repository
public class SearchDao_imple implements SearchDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Menu> wordSearchShow(String searchWord, int status) {
		
		Map<String, Object> paraMap = new HashMap<>();
		
		paraMap.put("searchWord", searchWord);
		paraMap.put("status", status);
		
		List<Menu> wordList = sqlSession.selectList("search.wordSearchShow", paraMap);
		
		return wordList;	
	}

	

}
