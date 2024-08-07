package com.sooRyeo.app.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.sooRyeo.app.aop.RequireLogin;
import com.sooRyeo.app.common.FileManager;
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
	
	@Autowired
	private FileManager fileManager;
	
	@GetMapping(value="/board/lecture_notice.lms")
	public ModelAndView lecture_notice(ModelAndView mav, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") instanceof Professor ) {
			model.addAttribute("memeberType", "professor");
		}
		else if(session.getAttribute("loginuser") instanceof Student ) {
			model.addAttribute("memeberType", "student");
		}
		
		session = request.getSession();
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
		List<BoardDTO> staticList = LecService.getStaticList(fk_course_seq);
		
		mav.addObject("staticList", staticList);
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
	public ModelAndView lecture_notice_view(ModelAndView mav, HttpServletRequest request, Model model) {
		
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
	public ModelAndView lecture_notice_view_2(ModelAndView mav, HttpServletRequest request, RedirectAttributes redirectAttr) {
		
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
	
	// 게시판 글쓰기 폼페이지 요청
	@GetMapping("/board/lectureNoticeWrite.lms")
	public ModelAndView lectureNoticeWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String fk_course_seq = request.getParameter("fk_course_seq");
		
		mav.addObject("fk_course_seq", fk_course_seq);
		mav.setViewName("lecture_notice/lectureNoticeWrite");
		return mav;
	}
	
	@PostMapping("/board/lectureNoticeWriteEnd.lms")
	public ModelAndView lectureNoticeWriteEnd(HttpServletRequest request, ModelAndView mav, BoardDTO bdto) {
		
		int n = 0;
		n = LecService.lectureNoticeWriteEnd(bdto);
		// 글쓰기 insert 메소드
		
		String fk_course_seq = request.getParameter("fk_course_seq");
		
		if(n == 1) {
			mav.addObject("message", "글쓰기를 성공하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/board/lecture_notice.lms?fk_course_seq="+fk_course_seq);
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "글쓰기를 실패하였습니다.");
			mav.addObject("loc", request.getContextPath()+"/board/lectureNoticeWrite.lms");
			mav.setViewName("msg");
		}
		
		return mav;
	}	
	
	@PostMapping("/board/del.lms")
	public ModelAndView L_delEnd(ModelAndView mav,HttpServletRequest request) { // 여기서는 받아올것이 1개밖에 없어서 굳이 boardvo로 불러올 필요가 없어서 안적었다.
		
		String seq = request.getParameter("seq");
		String fk_course_seq = request.getParameter("fk_course_seq");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord","");
		paraMap.put("seq", seq);
		
		int n = LecService.del(paraMap);
		
		if(n==1) {
			mav.addObject("message", "글이 삭제되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/board/lecture_notice.lms?fk_course_seq="+fk_course_seq);
			mav.setViewName("msg");
		}
		return mav;
	}	
	
	@GetMapping("/board/edit.lms")
	public ModelAndView L_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		String fk_course_seq = request.getParameter("fk_course_seq");
		
		String message = "";
		
		try {
			Integer.parseInt(seq);
			
			// 수정해야할 글 1개의 내용을 가져오기
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("seq", seq);
			paraMap.put("fk_course_seq", fk_course_seq);
			paraMap.put("searchWord", "");
			
			BoardDTO bdto = LecService.getView_no_increase_readCount(paraMap); // 조회수 증가 없이 글 한개만 조회하는 것(만들어둔 메소드).
			
			if(bdto == null) {
				message = "글 수정이 불가합니다."; // 없는 번호를 입력했을 경우
			}
			else {
				mav.addObject("bdto", bdto);
				mav.addObject("fk_course_seq", fk_course_seq);
				mav.setViewName("lecture_notice/lecture_notice_edit");
				
				return mav;
			}
		} catch (NumberFormatException e) {
			message = "글 수정이 불가합니다."; // get 방식으로 문자 입력을 시도할 경우 띄워준다.
		}
		String loc = "javascript:history.back()";
		mav.addObject("message", message); // 이것 자체가 request에 담아주는 행위
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	@PostMapping("/board/lecture_notice_edit_End.lms")
	public ModelAndView lecture_notice_edit_End(ModelAndView mav, BoardDTO bdto ,HttpServletRequest request) {

		String fk_course_seq = request.getParameter("fk_course_seq");
		
		int n = LecService.edit(bdto);
		
		if(n==1) {
			mav.addObject("message", "글이 수정되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/board/lecture_notice_view.lms?seq="+bdto.getSeq()+"&fk_course_seq="+fk_course_seq);
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@GetMapping("/board/announcement.lms")
	public ModelAndView announcement(ModelAndView mav, Announcement an, HttpServletRequest request) {

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
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("searchWord",searchWord);
		
		int currentPage = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			currentPage = 1;
		}
		String goBackURL = MyUtil.getCurrentURL(request);
		paraMap.put("currentPage", currentPage);
		
		// 학사공지사항을 전부 불러오는 메소드
		Pager<Announcement> announcementList =  LecService.getAnnouncement(paraMap);
		
		// 고정글을 불러오는 메소드
		List<Announcement>staticList = LecService.getA_StaticList();
		
		mav.addObject("staticList", staticList);
		mav.addObject("announcementList", announcementList.getObjectList());
		mav.addObject("currentPage", announcementList.getPageNumber());
		mav.addObject("perPageSize", announcementList.getPerPageSize());
		mav.addObject("pageBar", announcementList.makePageBar(request.getContextPath() +  "/board/announcement.lms", "searchWord="+searchWord));
		mav.setViewName("announcement");
		
		mav.addObject("goBackURL",goBackURL);
		
		return mav;
	}
	
	@RequestMapping("/board/announcementView.lms")
	public ModelAndView a_view(ModelAndView mav, HttpServletRequest request) {
		
		String seq = "";
		String goBackURL = "";
		String searchWord = "";
		
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
			HttpSession session =  request.getSession();
			
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
			Announcement an = null;
			
			if("yes".equals( (String)session.getAttribute("readCountPermission") )) {
				// 글목록보기인 /list.action 페이지를 클릭한 다음에 특정글을 조회해온 경우이다.
				
				an = LecService.getA_View(paraMap);
				// 글 조회수 증가와 함께 글 1개를 조회를 해오는 것
				
				session.removeAttribute("readCountPermission"); // 용도 폐기 
		    	// 중요 => session 에 저장된 readCountPermission 을 삭제한다.
			}
			else { // 위에 if 까지 갔다가 readCountPermission 이것을 폐기한 후 새로고침을 통해 바로 /view.action 으로 간 경우이다.
				   // 글목록에서 특정 글제목을 클릭하여 본 상태에서
                   // 웹브라우저에서 새로고침(F5)을 클릭한 경우이다.
				
				an = LecService.getA_View_no_increase_readCount(paraMap);
				// 글 조회수 증가는 없이 글 1개만 조회를 해오는 것
				
				// 또는 redirect 해주기 (예 : 버거킹 www.burgerking.co.kr 메뉴소개)
				
				if(an == null) {
					mav.setViewName("redirect:/board/announcement.lms");
					return mav;
				}
			}
			mav.addObject("an", an);
			
			// 이전글제목, 다음글제목 보기를 위해 넣어준 것
			mav.addObject("paraMap", paraMap);
			
			mav.setViewName("announcementView");
			
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/board/announcement.lms");
		}
		
		return mav;
	}
	
	
	@PostMapping("/board/announcementView_2.lms")
	public ModelAndView announcementView_2(ModelAndView mav, HttpServletRequest request, RedirectAttributes redirectAttr) {
		
		// 조회하고자 하는 글번호 받아오기
		String seq = request.getParameter("seq");
		
		// 이전글제목, 다음글제목 보기
		String goBackURL = request.getParameter("goBackURL");
		String searchWord = request.getParameter("searchWord");
		
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
		
		redirectAttr.addFlashAttribute("redirect_map", redirect_map);
		// redirectAttr.addFlashAttribute("키", 밸류값); 으로 사용하는데 오로지 1개의 데이터만 담을 수 있으므로 여러개의 데이터를 담으려면 Map 을 사용해야 한다.
		
		mav.setViewName("redirect:/board/announcementView.lms"); // 실제로 redirect:/view.action은 POST 방식이 아닌 GET 방식이다. 
		// ==== redirect(GET방식임) 시 데이터를 넘길때 GET 방식이 아닌 POST 방식처럼 데이터를 넘기려면 RedirectAttributes 를 사용하면 된다. 끝 ==== //
		
		return mav;
	}
	
	@GetMapping("/board/download.lms")
	public void download(HttpServletRequest request, HttpServletResponse response) {
		
		String seq = request.getParameter("seq");
		
		Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("seq", seq);
	    paraMap.put("searchWord", "");
	    
	    response.setContentType("text/html; charset=UTF-8");
	    
	    PrintWriter out = null;
	    // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	    
	    try {
	    	Integer.parseInt(seq);
	    	Announcement an = LecService.getA_View_no_increase_readCount(paraMap);
	    	
	    	if(an == null || (an != null && an.getAttatched_file() == null)) {
	    		// 비정상적으로 다운로드 할 경우
	    		
	    		out = response.getWriter();
	    		// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	    		
	    		out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
	            return;
	    	}
	    	else {
	    		// 정상적으로 다운로드 할 경우
	    		
	    		String fileName = an.getAttatched_file();
	    		String orgFilename = an.getOrgfilename();
	    		
	    		HttpSession session = request.getSession(); 
		        String root = session.getServletContext().getRealPath("/");
		        // 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
		        
		        String path = root+"resources"+File.separator+"files";
		        
		        // ***** file 다운로드 하기 ***** //
	            boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도 
	            flag = fileManager.doFileDownload(fileName, orgFilename, path, response); 
	            // file 다운로드 성공시 flag 는 true
	            
	            if(!flag) {
	               // 다운로드가 실패한 경우 메시지를 띄워준다. 
	               out = response.getWriter();
	               // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	               
	               out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");
	            }
	    	}
		} catch (Exception e) {
			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e2) {
				e2.printStackTrace();
			}
		}
	} // end of public void download(HttpServletRequest request, HttpServletResponse response) {}------------------
	
	// 게시판 글쓰기 폼페이지 요청
	@GetMapping("/board/addList.lms")
	public ModelAndView addList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("addList");
		return mav;
	}
	
	@PostMapping("/board/addListEnd.lms")
	public ModelAndView addListend(ModelAndView mav, MultipartHttpServletRequest mrequest, BoardDTO bdto) {
		
		MultipartFile attach =  bdto.getAttach();
		
		String orgFilename = "";
		
		if(attach != null) {
	         HttpSession session = mrequest.getSession(); 
	         String root = session.getServletContext().getRealPath("/");
	         // webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\sooRyeo_uni_lms\resources\files
	         
	         String path = root+"resources"+File.separator+"files";
	         String newFileName = "";
	         // WAS(톰캣)의 디스크에 저장될 파일명
	         
	         byte[] bytes = null;
	         // 첨부 파일의 내용물을 담은 것
	         
	         try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename =  attach.getOriginalFilename();

				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// WAS(톰캣)에 저장된 파일명(2024062712074811660790417300.xlsx) 이다.	
				orgFilename = originalFilename;
				
				bdto.setAttatched_file(newFileName);
				bdto.setOrgfilename(orgFilename);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int n = 0;
		n = LecService.addList(bdto);
		
		if(n == 1) {
			mav.addObject("message", "글쓰기를 성공하였습니다.");
			mav.addObject("loc", mrequest.getContextPath()+"/board/announcement.lms");
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "글쓰기를 실패하였습니다.");
			mav.addObject("loc", mrequest.getContextPath()+"/board/addList.lms");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	@PostMapping("/board/a_del.lms")
	public ModelAndView delEnd(ModelAndView mav,HttpServletRequest request) { // 여기서는 받아올것이 1개밖에 없어서 굳이 boardvo로 불러올 필요가 없어서 안적었다.
		
		String seq = request.getParameter("announcement_seq");
		
		// #184. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 시작
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchWord","");
		paraMap.put("seq", seq);
		
		Announcement an = LecService.getA_View_no_increase_readCount(paraMap);

		String fileName = an.getAttatched_file();
		// 20240701090336621493163800.png 이것이 WAS 톰캣 디스크에 저장된 파일명이다.
		
		if(fileName != null && !"".equals(fileName)) {
			 // 첨부파일이 저장되어 있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
             // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다. 
	         HttpSession session = request.getSession(); 
	         String root = session.getServletContext().getRealPath("/");
	         
	         // System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
	         // ~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\
	         
	         String path = root+"resources"+File.separator+"files";
	         /*    File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		               운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		               운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
	         */
	         // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	         // System.out.println("~~~ 확인용 path => " + path);
	         // ~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\board\resources\files
	         
	         paraMap.put("path", path); // 삭제해야할 파일이 저장된 경로
	         paraMap.put("fileName", fileName); // 삭제해야할 파일이 저장된 경로
	         
	         try {
                 fileManager.doFileDelete(fileName, path);
             } catch (Exception e) {
                 e.printStackTrace();
             }
		}
		// 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝
		
		int n = LecService.a_del(paraMap);
		
		if(n==1) {
			mav.addObject("message", "글이 삭제되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/board/announcement.lms");
			mav.setViewName("msg");
		}
		return mav;
	}	
	
	@GetMapping("/board/a_edit.lms")
	public ModelAndView a_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		
		String message = "";
		
		try {
			Integer.parseInt(seq);
			
			// 수정해야할 글 1개의 내용을 가져오기
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("seq", seq);
			paraMap.put("searchWord", "");
			
			Announcement an = LecService.getA_View_no_increase_readCount(paraMap); // 조회수 증가 없이 글 한개만 조회하는 것(만들어둔 메소드).
			
			if(an == null) {
				message = "글 수정이 불가합니다."; // 없는 번호를 입력했을 경우
			}
			else {
				mav.addObject("an", an);
				mav.setViewName("editList");
				
				return mav;
			}
		} catch (NumberFormatException e) {
			message = "글 수정이 불가합니다."; // get 방식으로 문자 입력을 시도할 경우 띄워준다.
		}
		String loc = "javascript:history.back()";
		mav.addObject("message", message); // 이것 자체가 request에 담아주는 행위
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	@PostMapping("/board/editListEnd.lms")
	public ModelAndView editEnd(ModelAndView mav, BoardDTO bdto ,HttpServletRequest request) { // 원래는 request를 통해 getparameter 를 했지만, 이제는 spring이라  boardvo로 불러온다.

		int n = LecService.a_edit(bdto);
		
		if(n==1) {
			mav.addObject("message", "글이 수정되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/board/announcementView.lms?seq="+bdto.getSeq());
			mav.setViewName("msg");
		}
		
		return mav;
	}

	
	
}
