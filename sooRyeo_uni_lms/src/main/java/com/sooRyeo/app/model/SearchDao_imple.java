package com.sooRyeo.app.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


@Repository
public class SearchDao_imple implements SearchDao {
	
	@Autowired
	@Qualifier("sqlsession") // 이름이 같은것을 주입
	private SqlSessionTemplate sqlSession;

	@Override
	public List<String> wordSearchShow(String searchWord, int status) {
		
		Map<String, Object> paraMap = new HashMap<>();
		
		paraMap.put("searchWord", searchWord);
		paraMap.put("status", status);
		
		List<String> wordList = sqlSession.selectList("board.wordSearchShow", paraMap);
		
		return wordList;	
	}

	

}
