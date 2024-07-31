package com.sooRyeo.app.service;

import java.util.List;

import com.sooRyeo.app.domain.Menu;

public interface SearchService {

	List<Menu> wordSearchShow(String searchWord, int status);

}
