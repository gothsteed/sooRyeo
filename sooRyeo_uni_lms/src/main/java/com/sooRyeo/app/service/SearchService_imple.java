package com.sooRyeo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sooRyeo.app.domain.Menu;
import com.sooRyeo.app.model.SearchDao;

@Service
public class SearchService_imple implements SearchService {

	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private SearchDao scdao; 
	
	@Override
	public List<Menu> wordSearchShow(String searchWord, int status) {
		List<Menu> wordList = scdao.wordSearchShow(searchWord, status);
		return wordList;
	}

}
