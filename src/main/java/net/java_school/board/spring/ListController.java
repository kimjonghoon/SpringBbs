package net.java_school.board.spring;

import java.util.HashMap;
import java.util.List;
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

		String boardCd = req.getParameter("boardCd");
		int curPage = Integer.parseInt(req.getParameter("curPage"));
		String searchWord = req.getParameter("searchWord");
		int numPerPage = 10;
		int pagePerBlock = 10;
		
		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		
		PagingHelper pagingHelper = new PagingHelper(totalRecord, curPage, numPerPage, pagePerBlock);
		boardService.setPagingHelper(pagingHelper);

		List<Article> list = boardService.getArticleList(boardCd, searchWord);
		String boardNm = boardService.getBoardNm(boardCd);
		Integer listItemNo = boardService.getListItemNo();
		Integer prevPage = boardService.getPrevPage();
		Integer nextPage = boardService.getNextPage();
		Integer firstPage = boardService.getFirstPage();
		Integer lastPage = boardService.getLastPage();
		
		// 모델 생성
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("list", list);
		model.put("boardNm", boardNm);
		model.put("listItemNo", listItemNo);
		model.put("prevPage", prevPage);
		model.put("nextPage", nextPage);
		model.put("firstPage", firstPage);
		model.put("lastPage", lastPage);
		model.put("curPage", curPage);
		model.put("boardCd", boardCd);
		
		//반환값인 ModelAndView 인스턴스 생성
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("bbs/list");
		modelAndView.addAllObjects(model);
		
		return modelAndView;
		
	}
	
}
