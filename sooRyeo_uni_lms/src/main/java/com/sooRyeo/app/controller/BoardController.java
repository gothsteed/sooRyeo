package com.sooRyeo.app.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.MyUtil;
import com.sooRyeo.app.domain.Admin;
import com.sooRyeo.app.domain.Announcement;
import com.sooRyeo.app.domain.Pager;
import com.sooRyeo.app.domain.Professor;
import com.sooRyeo.app.domain.Student;
import com.sooRyeo.app.dto.BoardDTO;
import com.sooRyeo.app.service.LectureNoticeService;


@Controller
@RequireLogin(type = {Admin.class, Student.class, Professor.class})
public class BoardController {

	@Autowired
	private LectureNoticeService LecService;
	
	@GetMapping(value="/board/lecture_notice.lms")
	public ModelAndView lecture_notice(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord == null) {
			searchWord = "";
		}
		if(searchWord != null) {
			searchWord = searchWord.trim();
			mav.addObject("searchWord", searchWord);
		}
		
		String fk_course_seq = request.getParameter("fk_course_seq");
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("searchWord",searchWord);
		paraMap.put("fk_course_seq",fk_course_seq);
		
		int currentPage = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		String goBackURL = MyUtil.getCurrentURL(request);
		paraMap.put("currentPage", currentPage);
		
		// 학사공지사항을 전부 불러오는 메소드
		Pager<BoardDTO> lec_List =  LecService.getLectureList(paraMap);
		
		/*
		for(int i = 0; i<lec_List.getObjectList().size(); i++) {
			System.out.println("@@@@@@@@@@@@@@@확인용@@@@@@@@@@@ " + lec_List.getObjectList().get(i).getSeq());
		}
		*/
		
		// 고정글을 불러오는 메소드
		// List<BoardDTO> staticList = LecService.getStaticList();
		
		// mav.addObject("staticList", staticList);
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.addObject("lec_List", lec_List.getObjectList());
		mav.addObject("currentPage", lec_List.getPageNumber());
		mav.addObject("perPageSize", lec_List.getPerPageSize());
		mav.addObject("pageBar", lec_List.makePageBar(request.getContextPath() + "/board/lecture_notice.lms", "searchWord="+searchWord, "fk_course_seq="+fk_course_seq));
		mav.setViewName("lecture_notice/lecture_notice");
		
		mav.addObject("goBackURL",goBackURL);
		
		return mav;
	}
	
	@RequestMapping("/board/lecture_notice_view.lms")
	public ModelAndView view(ModelAndView mav, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") instanceof Professor ) {
			model.addAttribute("memeberType", "professor");
		}
		else if(session.getAttribute("loginuser") instanceof Student ) {
			model.addAttribute("memeberType", "student");
		}
		
		String seq = "";
		String goBackURL = "";
		String searchWord = "";
		String fk_course_seq = "";
		
		// redirect 되어서 넘어온 데이터가 있는지 꺼내어 와본다.
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request); // ? 는 아무거나 라는 의미 == object
				
		if(inputFlashMap != null) { // redirect 되어서 넘어온 데이터가 있다면 이라는 의미
			
			@SuppressWarnings("unchecked")
			Map<String,String> redirect_map = (Map<String,String>) inputFlashMap.get("redirect_map"); // 리턴타입이 오브젝트라 캐스팅한 것.
			// "redirect_map" 값은  /view_2.action 에서  redirectAttr.addFlashAttribute("키", 밸류값); 을 할때 준 "키" 이다. 

			// 이전글제목, 다음글제목 보기 시작 
	           seq = redirect_map.get("seq");
	           goBackURL = redirect_map.get("goBackURL");
	           searchWord = redirect_map.get("searchWord");
	           fk_course_seq = redirect_map.get("fk_course_seq");
	           
	           try {
	               searchWord = URLDecoder.decode(redirect_map.get("searchWord"), "UTF-8"); // 한글데이터가 포함되어 있으면 반드시 한글로 복구주어야 한다. 
	               goBackURL = URLDecoder.decode(redirect_map.get("goBackURL"), "UTF-8");
	          } catch (UnsupportedEncodingException e) {
	              e.printStackTrace();
	          }
		}
		else { // redirect 되어서 넘어온 데이터가 아닌 경우
		
			seq = request.getParameter("seq");

			goBackURL = request.getParameter("goBackURL");
			fk_course_seq = request.getParameter("fk_course_seq");
			// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것.
			searchWord = request.getParameter("searchWord");
			
			if(searchWord == null) {
				searchWord = "";
			}
		}
		mav.addObject("goBackURL", goBackURL);
		
		try {
			Integer.parseInt(seq);
			/* 
	            "이전글제목" 또는 "다음글제목" 을 클릭하여 특정글을 조회한 후 새로고침(F5)을 한 경우는   
			            원본이 /view_2.action 을 통해서 redirect 되어진 경우이므로 form 을 사용한 것이 아니라서   
			    "양식 다시 제출 확인" 이라는 alert 대화상자가 뜨지 않는다. 
			            그래서  request.getParameter("seq"); 은 null 이 된다. 
			            즉, 글번호인 seq 가 null 이 되므로 DB 에서 데이터를 조회할 수 없게 된다.     
			            또한 seq 는 null 이므로 Integer.parseInt(seq); 을 하면  NumberFormatException 이 발생하게 된다. 
		    */
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("seq", seq);
			paraMap.put("fk_course_seq", fk_course_seq);
			session =  request.getSession();
			
			// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다.
			paraMap.put("searchWord",searchWord);
			
			//     !!! 중요 !!! 
            //     글1개를 보여주는 페이지 요청은 select 와 함께 
            //     DML문(지금은 글조회수 증가인 update문)이 포함되어져 있다.
            //     이럴경우 웹브라우저에서 페이지 새로고침(F5)을 했을때 DML문이 실행되어
            //     매번 글조회수 증가가 발생한다.
            //     그래서 우리는 웹브라우저에서 페이지 새로고침(F5)을 했을때는
            //     단순히 select만 해주고 DML문(지금은 글조회수 증가인 update문)은 
            //     실행하지 않도록 해주어야 한다. !!! === //
			
			// 위의 글목록보기에서 session.setAttribute("readCountPermission", "yes"); 지정해줌
			BoardDTO bdto = null;
			
			if("yes".equals( (String)session.getAttribute("readCountPermission") )) {
				// 글목록보기인 /list.action 페이지를 클릭한 다음에 특정글을 조회해온 경우이다.
				
				bdto = LecService.getView(paraMap);
				// 글 조회수 증가와 함께 글 1개를 조회를 해오는 것
				
				session.removeAttribute("readCountPermission"); // 용도 폐기 
		    	// 중요 => session 에 저장된 readCountPermission 을 삭제한다.
			}
			else { // 위에 if 까지 갔다가 readCountPermission 이것을 폐기한 후 새로고침을 통해 바로 /view.action 으로 간 경우이다.
				   // 글목록에서 특정 글제목을 클릭하여 본 상태에서
                   // 웹브라우저에서 새로고침(F5)을 클릭한 경우이다.
				
				bdto = LecService.getView_no_increase_readCount(paraMap);
				// 글 조회수 증가는 없이 글 1개만 조회를 해오는 것
				
				// 또는 redirect 해주기 (예 : 버거킹 www.burgerking.co.kr 메뉴소개)
				
				if(bdto == null) {
					mav.setViewName("redirect:/board/lecture_notice.lms");
					return mav;
				}
			}
			mav.addObject("bdto", bdto);
			mav.addObject("fk_course_seq", fk_course_seq);
			
			// 이전글제목, 다음글제목 보기를 위해 넣어준 것
			mav.addObject("paraMap", paraMap);
			
			mav.setViewName("lecture_notice/lecture_notice_view");
			
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/board/lecture_notice.lms");
		}
		
		return mav;
	}
	
	@PostMapping("/board/lecture_notice_view_2.lms")
	public ModelAndView announcementView_2(ModelAndView mav, HttpServletRequest request, RedirectAttributes redirectAttr) {
		
		// 조회하고자 하는 글번호 받아오기
		String seq = request.getParameter("seq");
		
		// 이전글제목, 다음글제목 보기
		String goBackURL = request.getParameter("goBackURL");
		String searchWord = request.getParameter("searchWord");
		String fk_course_seq = request.getParameter("fk_course_seq");
		
		/* 
	        redirect:/ 를 할때 "한글데이터는 0에서 255까지의 허용 범위 바깥에 있으므로 인코딩될 수 없습니다" 라는 
	        java.lang.IllegalArgumentException 라는 오류가 발생한다.
	                    이것을 방지하려면 아래와 같이 하면 된다.
        */
		try {
	         searchWord = URLEncoder.encode(searchWord, "UTF-8");
	         goBackURL = URLEncoder.encode(goBackURL, "UTF-8");
	         
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }
		// 이전글제목, 다음글제목 보기 끝
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		// ==== redirect(GET방식) 시 데이터를 넘길때 GET 방식이 아닌 POST 방식처럼 데이터를 넘기려면 RedirectAttributes 를 사용하면 된다. 시작 ==== //
		Map<String, String> redirect_map = new HashMap<>();
		redirect_map.put("seq",seq); // 여기서 redirect_map 이것 안에 seq를 담아주고, 밑에서  addFlashAttribute를 사용하여 redirectAttr 이곳에 넣어준다.
		// 이전글제목, 다음글제목 보기
		redirect_map.put("goBackURL",goBackURL);
		redirect_map.put("searchWord",searchWord);
		redirect_map.put("fk_course_seq",fk_course_seq);
		
		redirectAttr.addFlashAttribute("redirect_map", redirect_map);
		// redirectAttr.addFlashAttribute("키", 밸류값); 으로 사용하는데 오로지 1개의 데이터만 담을 수 있으므로 여러개의 데이터를 담으려면 Map 을 사용해야 한다.
		
		mav.setViewName("redirect:/board/lecture_notice_view.lms"); // 실제로 redirect:/view.action은 POST 방식이 아닌 GET 방식이다. 
		// ==== redirect(GET방식임) 시 데이터를 넘길때 GET 방식이 아닌 POST 방식처럼 데이터를 넘기려면 RedirectAttributes 를 사용하면 된다. 끝 ==== //
		
		return mav;
	}
	
}
