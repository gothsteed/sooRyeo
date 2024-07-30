package com.sooRyeo.app.model;

import java.util.List;

public interface SearchDao {

	List<String> wordSearchShow(String searchWord, int status);
	
}
