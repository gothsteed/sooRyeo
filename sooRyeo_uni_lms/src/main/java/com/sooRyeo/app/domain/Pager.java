package com.sooRyeo.app.domain;

import java.util.List;

public  class Pager<T> {

	//페이지에 보여줄 컨탠츠
	private List<T> objectList;
	
	//현재페이지
	private int pageNumber;
	
	//한페이지에 보여줄 개수
	private int perPageSize;
	
	//총 컨탠츠 개수
	private int totalElementCount;
	
	// 총 패이지 수
	private int totalPageCount;
	
	public Pager(List<T> objectList, int pageNumber, int perPageSize, int totalElementCount) {
		this.objectList = objectList;
		this.pageNumber = pageNumber;
		this.perPageSize = perPageSize;
		this.totalElementCount = totalElementCount;
		this.totalPageCount = (int)Math.ceil(((double) totalElementCount)/perPageSize);
	}
	

	public List<T> getObjectList() {
		return objectList;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public int getPerPageSize() {
		return perPageSize;
	}

	public int getTotalElementCount() {
		return totalElementCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}
	
	private String makeUrl(String baseUrl, String... parameters) {
		int parameterSize = parameters.length;
		
		StringBuilder sb = new StringBuilder();
		sb.append(baseUrl).append("?");
		
		for(int i=0; i<parameterSize; i++) {
			sb.append(parameters[i]);
			sb.append("&");
		}
		
		return sb.toString();
	
	}
	
	

	public String makePageBar(String baseUrl, String... parameters) {
		
		int loop = 1;
		int pageNo = ((pageNumber - 1)/perPageSize) * perPageSize + 1;
		String urlWithQuery = makeUrl(baseUrl, parameters);
		
		String pageBar = "<li class='page-item'><a class='page-link' href='"+urlWithQuery+ "page=1'>[맨처음]</a></li>";
		
		
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='"+ urlWithQuery + "page="+ (pageNo - 1) +"'>[이전]</a></li>";
		}
		
		//맨처음 맨마지막 만들기
		
		while( !(loop > perPageSize || pageNo > totalPageCount) ) {
			
			//1 2 3 4 5 6 7  8 9 10
			//pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			
			if(pageNo == pageNumber) {
				
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
			}
			else {
				
				pageBar += "<li class='page-item'><a class='page-link' href='"+ urlWithQuery + "page="+ pageNo + "'>"+pageNo+"</a></li>";
			}
			
			
			loop ++; 
			
			
			// 1 2 3 4 5 6 7  8 9 10
			// 11 12 13 14 15 16 17 18 19 20
			pageNo ++;
			
		}
		
		pageBar += "<li class='page-item'><a class='page-link' href='" + urlWithQuery + "page="+ (totalPageCount) +"'>[맨마지막]</a></li>";
		//다음 마지막 만들기
		if(pageNo <= totalPageCount) {
			pageBar += "<li class='page-item'><a class='page-link' href='"+ urlWithQuery+"page="+ (pageNo + 1)+"'>[다음]</a></li>";
		}
		
		return pageBar;
	}
	
	public boolean isOutOfBount() {
		if(pageNumber >= 1 && pageNumber <= totalPageCount) {
			return false;
		}
		
		return true;
		
	}
	
	public String makeScriptPageBar(String methodName) {
		
		int loop = 1;
		int pageNo = ((pageNumber - 1)/perPageSize) * perPageSize + 1;
		
		String pageBar = "<li class='page-item'><a class='page-link' href='javascript:"+methodName+"(1)'>[맨처음]</a></li>";
		
		
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='javascript:"+methodName+"("+(pageNo - 1)+")'>[이전]</a></li>";
		}
		
		//맨처음 맨마지막 만들기
		
		while( !(loop > perPageSize || pageNo > totalPageCount) ) {
			
			//1 2 3 4 5 6 7  8 9 10
			//pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			
			if(pageNo == pageNumber) {
				
				pageBar += "<li class='page-item active'><a class='page-link' >"+pageNo+"</a></li>";
			}
			else {
				
				pageBar += "<li class='page-item'><a class='page-link' href='javascript:"+methodName+"("+(pageNo)+")'>"+pageNo+"</a></li>";
			}
			
			
			loop ++; 
			
			
			// 1 2 3 4 5 6 7  8 9 10
			// 11 12 13 14 15 16 17 18 19 20
			pageNo ++;
			
		}
		
		pageBar += "<li class='page-item'><a class='page-link' href='javascript:"+methodName+"("+(totalPageCount)+")'>[맨마지막]</a></li>";
		//다음 마지막 만들기
		if(pageNo <= totalPageCount) {
			pageBar += "<li class='page-item'><a class='page-link' href='javascript:"+methodName+"("+(pageNo + 1)+")'>[다음]</a></li>";
		}
		
		return pageBar;
	}
	
}
