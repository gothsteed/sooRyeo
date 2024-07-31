package com.sooRyeo.app.model;

import java.util.List;

import com.sooRyeo.app.domain.Menu;

public interface SearchDao {

	List<Menu> wordSearchShow(String searchWord, int status);
	
}
