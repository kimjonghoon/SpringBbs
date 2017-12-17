package net.java_school.controller;

import java.io.File;
import java.net.URLEncoder;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.Board;
import net.java_school.board.BoardService;
import net.java_school.commons.NumbersForPaging;
import net.java_school.commons.Paginator;
import net.java_school.commons.WebContants;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/bbs")
public class BbsController extends Paginator {

	@Autowired
	private BoardService boardService;
	
	private String getBoardName(String boardCd, String lang) {
		Board board = boardService.getBoard(boardCd);
		
		switch (lang) {
		case "en":
			return board.getBoardNm();
		case "ko":
			return board.getBoardNm_ko();
		default:
			return board.getBoardNm();
		}
	}
	
	//목록
	@RequestMapping(value="/{boardCd}", method=RequestMethod.GET)
	public String list(@PathVariable String boardCd, Integer page, String searchWord, Locale locale, Model model) {

		if (page == null) page = 1;
		
		int numPerPage = 20;
		int pagePerBlock = 10;

		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);

		NumbersForPaging numbers = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);


		//oracle
/*		Integer startRecord = (page - 1) * numPerPage + 1;
		Integer endRecord = page * numPerPage;
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardCd", boardCd);
		map.put("searchWord", searchWord);
		map.put("start", startRecord.toString());
		map.put("end", endRecord.toString());
		List<Article> list = boardService.getArticleList(map);*/


		
		//mysql
		Integer offset = (page - 1) * numPerPage;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardCd", boardCd);
		map.put("searchWord", searchWord);
		map.put("offset", offset.toString());
		Integer rowCount = numPerPage;
		map.put("rowCount", rowCount.toString());
		List<Article> list = boardService.getArticleList(map);

		
		Integer listItemNo = numbers.getListItemNo();
		Integer prevPage = numbers.getPrevBlock();
		Integer nextPage = numbers.getNextBlock();
		Integer firstPage = numbers.getFirstPage();
		Integer lastPage = numbers.getLastPage();
		Integer totalPage = numbers.getTotalPage();

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("totalPage", totalPage);
		
		String lang = locale.getLanguage();
		List<Board> boards = boardService.getBoards();
		String boardName = this.getBoardName(boardCd, lang);
		model.addAttribute("boards", boards);
		model.addAttribute("boardName", boardName);
		
		//파라미터로 전달되지 않는다.
		model.addAttribute("boardCd", boardCd);
		
		return "bbs/list";

	}

	//상세보기
	@RequestMapping(value="/{boardCd}/{articleNo}", method=RequestMethod.GET)
	public String view(@PathVariable String boardCd, @PathVariable Integer articleNo,   
			Integer page, String searchWord, Locale locale, HttpServletRequest req, Model model) {

		if(page == null) page = 1;
		String lang = locale.getLanguage();
		
		//조회수 증가 수정: views 테이블 이용 2017.8.14 추가
		//articleNo, user'ip, yearMonthDayHour
		String ip = req.getRemoteAddr();
		LocalDateTime now = LocalDateTime.now();
		Integer year = now.getYear();
		Integer month = now.getMonthValue();
		Integer day = now.getDayOfMonth();
		Integer hour = now.getHour();
		String yearMonthDayHour = year.toString() + month.toString() + day.toString() + hour.toString();

		try {
			boardService.increaseHit(articleNo, ip, yearMonthDayHour);
		} catch (Exception e) {
			
		}

		Article article = boardService.getArticle(articleNo);//상세보기에서 볼 게시글
		List<AttachFile> attachFileList = boardService.getAttachFileList(articleNo);
		Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
		Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
		//List<Comment> commentList = boardService.getCommentList(articleNo);
		String boardName = this.getBoardName(boardCd, lang);

		//상세보기에서 볼 게시글 관련 정보
		String title = article.getTitle();//제목
		String content = article.getContent();//내용
		content = content.replaceAll(WebContants.LINE_SEPARATOR, "<br />");
		//int hit = article.getHit();//조회수
		String name = article.getName();//작성자 이름
		String email = article.getEmail();//작성자 ID
		Date regdate = article.getRegdate();//작성일
		
		//조회수 구하기 추가 2017.8.14
		int hit = boardService.getTotalViews(articleNo);

		model.addAttribute("title", title);
		model.addAttribute("content", content);
		model.addAttribute("hit", hit);
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		model.addAttribute("regdate", regdate);
		model.addAttribute("attachFileList", attachFileList);
		model.addAttribute("nextArticle", nextArticle);
		model.addAttribute("prevArticle", prevArticle);
		//model.addAttribute("commentList", commentList);

		//목록관련
		int numPerPage = 20;//페이지당 레코드 수
		int pagePerBlock = 10;//블록당 페이지 링크수

		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		
		NumbersForPaging numbers = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);
		

/*		
		//oracle
		Integer startRecord = (page - 1) * numPerPage + 1;
		Integer endRecord = page * numPerPage;
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardCd", boardCd);
		map.put("searchWord", searchWord);
		map.put("start", startRecord.toString());
		map.put("end", endRecord.toString());
		List<Article> list = boardService.getArticleList(map);
*/
		
		
		//mysql
		Integer offset = (page - 1) * numPerPage;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardCd", boardCd);
		map.put("searchWord", searchWord);
		map.put("offset", offset.toString());
		Integer rowCount = numPerPage;
		map.put("rowCount", rowCount.toString());
		List<Article> list = boardService.getArticleList(map);
		

		int listItemNo = numbers.getListItemNo();
		int prevPage = numbers.getPrevBlock();
		int nextPage = numbers.getNextBlock();
		int firstPage = numbers.getFirstPage();
		int lastPage = numbers.getLastPage();

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("boardName", boardName);

		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);
		
		//파라미터로 전달되지 않기에
		model.addAttribute("articleNo", articleNo);
		model.addAttribute("boardCd", boardCd);
		
		return "bbs/view";
	}
	
	//글쓰기 양식
	@RequestMapping(value="/{boardCd}/new", method=RequestMethod.GET)
	public String writeForm(@PathVariable String boardCd, Locale locale, Model model) {
		String lang = locale.getLanguage();
		String boardName = this.getBoardName(boardCd, lang);
		List<Board> boards = boardService.getBoards();
		
		model.addAttribute("boardName", boardName);
		model.addAttribute("article", new Article());
		model.addAttribute("boards", boards);
		//boardCd 파라미터가 전달되지 않는다.
		model.addAttribute("boardCd", boardCd);

		return "bbs/write";
		
	}

	//글쓰기
	@RequestMapping(value="/{boardCd}", method=RequestMethod.POST)
	public String write(@Valid Article article,
			BindingResult bindingResult,
			@PathVariable String boardCd,
			Locale locale,
			Model model,
			MultipartHttpServletRequest mpRequest,
			Principal principal) throws Exception {

		if (bindingResult.hasErrors()) {
			String boardName = this.getBoardName(article.getBoardCd(), locale.getLanguage());
			model.addAttribute("boardName", boardName);
			List<Board> boards = boardService.getBoards();
			model.addAttribute("boards", boards);
			//boardCd 파라미터가 전달되지 않는다.
			model.addAttribute("boardCd", boardCd);

			return "bbs/write";
		}

		article.setEmail(principal.getName());

		boardService.addArticle(article);

		//파일 업로드
		Iterator<String> it = mpRequest.getFileNames();
		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		while (it.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) it.next());
			if (multiFile.getSize() > 0) {
				String filename = multiFile.getOriginalFilename();
				multiFile.transferTo(new File(WebContants.UPLOAD_PATH + filename));
				fileList.add(multiFile);
			}
		}

		//파일데이터 삽입
		int size = fileList.size();
		for (int i = 0; i < size; i++) {
			MultipartFile mpFile = fileList.get(i);
			AttachFile attachFile = new AttachFile();
			String filename = mpFile.getOriginalFilename();
			attachFile.setFilename(filename);
			attachFile.setFiletype(mpFile.getContentType());
			attachFile.setFilesize(mpFile.getSize());
			attachFile.setArticleNo(article.getArticleNo());
			attachFile.setEmail(principal.getName());
			boardService.addAttachFile(attachFile);
		}

		return "redirect:/bbs/" + article.getBoardCd() + "?page=1";
		
	}

	//수정 양식
	@RequestMapping(value="/{boardCd}/{articleNo}/edit", method=RequestMethod.GET)
	public String modifyForm(@PathVariable String boardCd, @PathVariable Integer articleNo, Locale locale, Model model) {
		
		String lang = locale.getLanguage();
		Article article = boardService.getArticle(articleNo);
		String boardName = this.getBoardName(boardCd, lang);

		//수정페이지에서의 보일 게시글 정보
		model.addAttribute("article", article);
		model.addAttribute("boardName", boardName);
		
		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);
		//파라미터로 전달하지 않는다.
		model.addAttribute("boardCd", boardCd);
		model.addAttribute("articleNo", articleNo);
		
		return "bbs/modify";
	}

	//수정
	@RequestMapping(value="/{boardCd}/{articleNo}", method=RequestMethod.POST)
	public String modify(@Valid Article article, 
			BindingResult bindingResult, 
			@PathVariable String boardCd, 
			@PathVariable Integer articleNo, 
			Integer page, 
			String searchWord, 
			Locale locale, 
			Model model, 
			MultipartHttpServletRequest mpRequest) throws Exception {

		if (bindingResult.hasErrors()) {
			String boardName = this.getBoardName(article.getBoardCd(), locale.getLanguage());
			model.addAttribute("boardName", boardName);
			List<Board> boards = boardService.getBoards();
			model.addAttribute("boards", boards);
			model.addAttribute("boardCd", boardCd);
			model.addAttribute("articleNo", articleNo);

			return "bbs/modify";
		}

		//관리자가 수정하더라도 원글 소유자를 그대로 유지하기 위해서 
		String email = boardService.getArticle(article.getArticleNo()).getEmail();
		article.setEmail(email);

		//게시글 수정
		boardService.modifyArticle(article);

		//파일업로드
		Iterator<String> it = mpRequest.getFileNames();
		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		while (it.hasNext()) {
			MultipartFile multiFile = mpRequest.getFile((String) it.next());
			if (multiFile.getSize() > 0) {
				String filename = multiFile.getOriginalFilename();
				multiFile.transferTo(new File(WebContants.UPLOAD_PATH + filename));
				fileList.add(multiFile);
			}
		}

		//파일데이터 삽입
		int size = fileList.size();
		for (int i = 0; i < size; i++) {
			MultipartFile mpFile = fileList.get(i);
			AttachFile attachFile = new AttachFile();
			String filename = mpFile.getOriginalFilename();
			attachFile.setFilename(filename);
			attachFile.setFiletype(mpFile.getContentType());
			attachFile.setFilesize(mpFile.getSize());
			attachFile.setArticleNo(article.getArticleNo());
			attachFile.setEmail(article.getEmail());//첨부파일 소유자는 원글 소유자가 되도록
			boardService.addAttachFile(attachFile);
		}

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/" 
			+ article.getBoardCd() 
			+ "/" 
			+ article.getArticleNo() 
			+ "?page=" 
			+ page 
			+ "&searchWord=" 
			+ searchWord;

	}

	//게시글 삭제
	@RequestMapping(value="/{boardCd}/{articleNo}", method=RequestMethod.DELETE)
	public String deleteArticle(@PathVariable String boardCd, @PathVariable Integer articleNo, Integer page, String searchWord) {
		Article article = boardService.getArticle(articleNo);
		boardService.removeArticle(article);
		
		return "redirect:/bbs/" 
			+ boardCd 
			+ "?page=" 
			+ page 
			+ "&searchWord=" 
			+ searchWord;

	}

	@RequestMapping(value="/deleteAttachFile", method=RequestMethod.POST)
	public String deleteAttachFile(Integer attachFileNo, 
			Integer articleNo, 
			String boardCd, 
			Integer page, 
			String searchWord) throws Exception {

		AttachFile attachFile = boardService.getAttachFile(attachFileNo);
		boardService.removeAttachFile(attachFile);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/" 
			+ boardCd 
			+ "/" 
			+ articleNo 
			+ "?page=" 
			+ page 
			+ "&searchWord=" 
			+ searchWord;

	}

}
