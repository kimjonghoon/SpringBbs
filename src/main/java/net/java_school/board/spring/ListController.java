package net.java_school.board.spring;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.java_school.board.Article;
import net.java_school.board.BoardService;
import net.java_school.commons.PagingHelper;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class ListController implements Controller {
	
	private BoardService boardService;
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	public ModelAndView handleRequest(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		//req.setCharacterEncoding("UTF-8");
		String boardCd = req.getParameter("boardCd");
		if (boardCd == null) boardCd = "free";
		int curPage = req.getParameter("curPage") == null ? 1 : Integer.parseInt(req.getParameter("curPage"));
		String searchWord = req.getParameter("searchWord");
		int numPerPage = 10;
		int pagePerBlock = 10;
		
		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		
		PagingHelper pagingHelper = new PagingHelper(totalRecord, curPage, numPerPage, pagePerBlock);
		
		boardService.setPagingHelper(pagingHelper);
		int start = pagingHelper.getStartRecord();
		int end = pagingHelper.getEndRecord();

		ArrayList<Article> list = boardService.getArticleList(boardCd, searchWord, start, end);
		String boardNm = boardService.getBoardNm(boardCd);
		Integer no = boardService.getListNo();
		Integer prevLink = boardService.getPrevLink();
		Integer nextLink = boardService.getNextLink();
		Integer firstPage = boardService.getFirstPage();
		Integer lastPage = boardService.getLastPage();
		int[] pageLinks = boardService.getPageLinks();
		
		// 모델 생성
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("list", list);
		model.put("boardNm", boardNm);
		model.put("no", no);
		model.put("prevLink", prevLink);
		model.put("nextLink", nextLink);
		model.put("firstPage", firstPage);
		model.put("lastPage", lastPage);
		model.put("pageLinks", pageLinks);
		model.put("curPage", curPage);
		
		//반환값인 ModelAndView 인스턴스 생성
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/WEB-INF/jsp/bbs/list.jsp");
		modelAndView.addAllObjects(model);
		
		return modelAndView;
		
	}
	
}
