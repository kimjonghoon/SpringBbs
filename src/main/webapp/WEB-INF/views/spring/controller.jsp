<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.8.8</div>

<h1>게시판 컨트롤러 최종본</h1>

지금까지 작성한 BbsController.java 최종 결과물이다.<br />

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
package net.java_school.board.spring;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
import net.java_school.commons.PagingHelper;
import net.java_school.commons.WebContants;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/bbs")
public class BbsController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(String boardCd, 
			Integer page, 
			String searchWord, 
			Model model) throws Exception {
			
		if (boardCd == null) boardCd = "free";
		if (page == null) page = 1;
		if (searchWord == null) searchWord = "";

		int numPerPage = 10;
		int pagePerBlock = 10;
		
		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		
		PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
		
		boardService.setPagingHelper(pagingHelper);
		int start = pagingHelper.getStartRecord();
		int end = pagingHelper.getEndRecord();

		ArrayList&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord, start, end);
		String boardNm = boardService.getBoardNm(boardCd);
		Integer no = boardService.getListNo();
		Integer prevLink = boardService.getPrevLink();
		Integer nextLink = boardService.getNextLink();
		Integer firstPage = boardService.getFirstPage();
		Integer lastPage = boardService.getLastPage();
		int[] pageLinks = boardService.getPageLinks();
		
		model.addAttribute("list", list);
		model.addAttribute("boardNm", boardNm);
		model.addAttribute("no", no);
		model.addAttribute("prevLink", prevLink);
		model.addAttribute("nextLink", nextLink);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("pageLinks", pageLinks);
		model.addAttribute("page", page);//page는 null 값이면 1로 만들어야 하므로
		model.addAttribute("boardCd", boardCd);//boardCd는 null 값이면 free로 만들어야 하므로
		
		return "bbs/list";
		
	}

	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String write(String boardCd, Model model) throws Exception {
		//게시판 이름
		String boardNm = boardService.getBoardNm(boardCd);
		model.addAttribute("boardNm", boardNm);
		
		return "bbs/writeform";
	}

	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(Article article) {
		article.setEmail("bond007@gmail.org");
		boardService.insert(article);
		return "redirect:/bbs/list?boardCd=" + article.getBoardCd();
	}

	@RequestMapping(value="/view", method=RequestMethod.GET)
	public String view(Integer articleNo, 
			String boardCd, 
			Integer page,
			String searchWord, 
			Model model) throws Exception {

		// 검색어가 null 이면 ""으로 변경	
		if (searchWord == null) searchWord = "";

		// 페이지당 레코드 수 지정
		int numPerPage = 10;
		
		// 페이지 링크의 그룹(block)의 크기 지정
		int pagePerBlock = 10;
		
		/*
		상세보기를 할때마다 조회수를 1 증가
		하단에 목록에서 조회수를 제대로 보기위해서는
		목록 레코드를 페치하기 전에 조회수를 먼저 증가시켜야 한다.
		TODO : 사용자 IP 와 시간을 고려해서 조회수를 증가하도록
		*/
		boardService.increaseHit(articleNo);
		
		//상세보기 
		Article thisArticle = boardService.getArticle(articleNo);
		ArrayList&lt;AttachFile&gt; attachFileList = boardService.getAttachFileList(articleNo);
		ArrayList&lt;Comment&gt; commentList = boardService.getCommentList(articleNo);
		Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
		Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
		
		//목록보기
		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);

		boardService.setPagingHelper(pagingHelper);
		int start = pagingHelper.getStartRecord();
		int end = pagingHelper.getEndRecord();

		ArrayList&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord, start, end);
		String boardNm = boardService.getBoardNm(boardCd);
		Integer no = boardService.getListNo();
		Integer prevLink = boardService.getPrevLink();
		Integer nextLink = boardService.getNextLink();
		Integer firstPage = boardService.getFirstPage();
		Integer lastPage = boardService.getLastPage();
		int[] pageLinks = boardService.getPageLinks();
		
		model.addAttribute("thisArticle", thisArticle);
		model.addAttribute("attachFileList", attachFileList);
		model.addAttribute("commentList", commentList);
		model.addAttribute("nextArticle", nextArticle);
		model.addAttribute("prevArticle", prevArticle);

		// 목록을 위한 데이터
		model.addAttribute("list", list);
		model.addAttribute("boardNm", boardNm);
		model.addAttribute("no", no);
		model.addAttribute("prevLink", prevLink);
		model.addAttribute("nextLink", nextLink);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("pageLinks", pageLinks);
		
		return "bbs/view";
	}
	
	@RequestMapping(value="/commentAdd", method=RequestMethod.POST)
	public String commentAdd(Integer articleNo, 
			String boardCd, 
			Integer page, 
			String searchWord, 
			String memo) throws Exception {
			
		Comment comment = new Comment();
		comment.setMemo(memo);
		comment.setEmail("bond007@gmail.org");
		comment.setArticleNo(articleNo);
		boardService.insertComment(comment);
		
		searchWord = URLEncoder.encode(searchWord,"UTF-8");
		
		return "redirect:/bbs/view?articleNo=" + articleNo + 
			"&amp;boardCd=" + boardCd + 
			"&amp;page=" + page + 
			"&amp;searchWord=" + searchWord;

	}

	@RequestMapping(value="/commentUpdate", method=RequestMethod.POST)
	public String commentUpdate(Integer commentNo, 
			Integer articleNo, 
			String boardCd, 
			Integer page, 
			String searchWord, 
			String memo) throws Exception {
			
		Comment comment = boardService.getComment(commentNo);
		comment.setMemo(memo);
		boardService.updateComment(comment);
		searchWord = URLEncoder.encode(searchWord, "UTF-8");
		
		return "redirect:/bbs/view?articleNo=" + articleNo + 
			"&amp;boardCd=" + boardCd + 
			"&amp;page=" + page + 
			"&amp;searchWord=" + searchWord;

	}

	@RequestMapping(value="/commentDel", method=RequestMethod.POST)
	public String commentDel(Integer commentNo, 
			Integer articleNo, 
			String boardCd, 
			Integer page, 
			String searchWord) throws Exception {
			
		boardService.deleteComment(commentNo);
		
		searchWord = URLEncoder.encode(searchWord,"UTF-8");
		
		return "redirect:/bbs/view?articleNo=" + articleNo + 
			"&amp;boardCd=" + boardCd + 
			"&amp;page=" + page + 
			"&amp;searchWord=" + searchWord;

	}

	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String modify(Integer articleNo, 
			String boardCd, 
			Model model) throws Exception {
		
		Article thisArticle = boardService.getArticle(articleNo);
		String boardNm = boardService.getBoardNm(boardCd);
		
		//수정페이지에서의 보일 게시글 정보
		model.addAttribute("thisArticle", thisArticle);
		model.addAttribute("boardNm", boardNm);
		
		return "bbs/modifyform";
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(MultipartHttpServletRequest mpRequest) throws Exception {
		int articleNo = Integer.parseInt(mpRequest.getParameter("articleNo"));
		Article article = boardService.getArticle(articleNo);
		
		String boardCd = mpRequest.getParameter("boardCd");
		int page = Integer.parseInt(mpRequest.getParameter("page"));
		String searchWord = mpRequest.getParameter("searchWord");
		
		String title = mpRequest.getParameter("title");
		String content = mpRequest.getParameter("content");
		
		//게시글 수정
		article.setTitle(title);
		article.setContent(content);
		article.setBoardCd(boardCd);// 게시판 종류 변경
		boardService.update(article);

		//파일업로드
		Iterator&lt;String&gt; it = mpRequest.getFileNames();
		List&lt;MultipartFile&gt; fileList = new ArrayList&lt;MultipartFile&gt;();
		while (it.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) it.next());
			if (multiFile.getSize() &gt; 0) {
				String filename = multiFile.getOriginalFilename();
				multiFile.transferTo(new File(WebContants.BASE_PATH + filename));
				fileList.add(multiFile);
			}
		}
		
		//파일데이터 삽입
		int size = fileList.size();
		for (int i = 0; i &lt; size; i++) {
			MultipartFile mpFile = fileList.get(i);
			AttachFile attachFile = new AttachFile();
			String filename = mpFile.getOriginalFilename();
			attachFile.setFilename(filename);
			attachFile.setFiletype(mpFile.getContentType());
			attachFile.setFilesize(mpFile.getSize());
			attachFile.setArticleNo(articleNo);
			boardService.insertAttachFile(attachFile);
		}
		searchWord = URLEncoder.encode(searchWord,"UTF-8");
		return "redirect:/bbs/view?articleNo=" + articleNo 
			+ "&amp;boardCd=" + boardCd 
			+ "&amp;page=" + page 
			+ "&amp;searchWord=" + searchWord;

	}

	@RequestMapping(value="/download", method=RequestMethod.POST)
	public String download(String filename, Model model) {
		model.addAttribute("filename", filename);
		return "inc/download";
	}

	@RequestMapping(value="/attachFileDel", method=RequestMethod.POST)
	public String attachFileDel(Integer attachFileNo, 
			Integer articleNo, 
			String boardCd, 
			Integer page, 
			String searchWord) throws Exception {
		
		boardService.deleteFile(attachFileNo);
		
		searchWord = URLEncoder.encode(searchWord,"UTF-8");
		
		return "redirect:/bbs/view?articleNo=" + articleNo + 
			"&amp;boardCd=" + boardCd + 
			"&amp;page=" + page + 
			"&amp;searchWord=" + searchWord;

	}

	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(Integer articleNo, 
			String boardCd, 
			Integer page, 
			String searchWord) throws Exception {
		
		boardService.delete(articleNo);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");
		
		return "redirect:/bbs/list?boardCd=" + boardCd + 
			"&amp;page=" + page + 
			"&amp;searchWord=" + searchWord;

	}
	
}
</pre>

<h3>게시판 최종본</h3>
<a href="src/board/css.zip">css.zip</a><br />
<a href="src/board/images.zip">images.zip</a><br />
<a href="src/board/java.zip">java.zip</a><br />
<a href="src/board/WEB-INF.zip">WEB-INF.zip</a><br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
</ul>