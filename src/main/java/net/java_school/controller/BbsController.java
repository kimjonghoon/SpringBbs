package net.java_school.controller;

import java.io.File;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.validation.Valid;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.Board;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
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
public class BbsController {

	@Autowired
	private BoardService boardService;
	
	private List<Board> getBoards(String lang) {
	    switch (lang) {
	    case "en":
	        return boardService.getListOfBoardCodeAndBoardName();
	    case "ko":
	        return boardService.getListOfBoardCodeAndBoardKoreanName();
	    default:
	        return boardService.getListOfBoardCodeAndBoardName();//설정에서 로케일 디폴트를 영어로 설정했으므로  
	    }
	}

	private String getBoardName(String boardCd, String lang) {
		Board board = boardService.getBoardNm(boardCd);
		
		switch (lang) {
		case "en":
			return board.getBoardNm();
		case "ko":
			return board.getBoardNm_ko();
		default:
			return board.getBoardNm();
		}
	}
	
	private Map<String,Integer> getNumbersForPaging(int totalRecord, int curPage, int numPerPage, int pagePerBlock) {
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		int totalPage = totalRecord / numPerPage;
		
		int totalBlock = totalPage / pagePerBlock;
		if (totalPage % pagePerBlock != 0) totalBlock++;
		int block = curPage / pagePerBlock;
		if (curPage % pagePerBlock != 0) block++;
		int firstPage = (block - 1) * pagePerBlock + 1;
		int lastPage = block * pagePerBlock;
		int prevPage = 0;
		if (block > 1) {
			prevPage = firstPage - 1;
		}
		int nextPage = 0;
		if (block < totalBlock) {
			nextPage = lastPage + 1;
		}
		if (block >= totalBlock) {
			lastPage = totalPage;
		}
		int listItemNo = totalRecord - (curPage - 1) * numPerPage;
		int startRecord = (curPage - 1) * numPerPage + 1;
		int endRecord = curPage * numPerPage;
		
		map.put("totalPage", totalPage);
		map.put("firstPage", firstPage);
		map.put("lastPage", lastPage);
		map.put("prevPage", prevPage);
		map.put("nextPage", nextPage);
		map.put("listItemNo", listItemNo);
		map.put("startRecord", startRecord);
		map.put("endRecord", endRecord);
		
		return map;
	}
	
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(String boardCd, Integer curPage, String searchWord, Locale locale, Model model) {

		int numPerPage = 10;
		int pagePerBlock = 10;

		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);

		Map<String, Integer> map = this.getNumbersForPaging(totalRecord, curPage, numPerPage, pagePerBlock);
		Integer startRecord = map.get("startRecord");
		Integer endRecord = map.get("endRecord");
		List<Article> list = boardService.getArticleList(boardCd, searchWord, startRecord, endRecord);

		Integer listItemNo = map.get("listItemNo");
		Integer prevPage = map.get("prevPage");
		Integer nextPage = map.get("nextPage");
		Integer firstPage = map.get("firstPage");
		Integer lastPage = map.get("lastPage");

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		
		String lang = locale.getLanguage();
		List<Board> boards = this.getBoards(lang);
		String boardNm = this.getBoardName(boardCd, lang);
		model.addAttribute("boards", boards);
		model.addAttribute("boardNm", boardNm);
		
		return "bbs/list";

	}

	@RequestMapping(value="/{articleNo}", method=RequestMethod.GET)
	public String view(@PathVariable Integer articleNo, String boardCd,  
			Integer curPage, String searchWord, Locale locale, Model model) {
		
		String lang = locale.getLanguage();
		boardService.increaseHit(articleNo);

		Article article = boardService.getArticle(articleNo);//상세보기에서 볼 게시글
		List<AttachFile> attachFileList = boardService.getAttachFileList(articleNo);
		Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
		Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
		List<Comment> commentList = boardService.getCommentList(articleNo);
		String boardNm = this.getBoardName(boardCd, lang);

		//상세보기에서 볼 게시글 관련 정보
		String title = article.getTitle();//제목
		String content = article.getContent();//내용
		content = content.replaceAll(WebContants.LINE_SEPARATOR, "<br />");
		int hit = article.getHit();//조회수
		String name = article.getName();//작성자 이름
		String email = article.getEmail();//작성자 ID
		Date regdate = article.getRegdate();//작성일

		model.addAttribute("title", title);
		model.addAttribute("content", content);
		model.addAttribute("hit", hit);
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		model.addAttribute("regdate", regdate);
		model.addAttribute("attachFileList", attachFileList);
		model.addAttribute("nextArticle", nextArticle);
		model.addAttribute("prevArticle", prevArticle);
		model.addAttribute("commentList", commentList);

		//목록관련
		int numPerPage = 10;//페이지당 레코드 수
		int pagePerBlock = 10;//블록당 페이지 링크수

		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
		
		Map<String, Integer> map = this.getNumbersForPaging(totalRecord, curPage, numPerPage, pagePerBlock);
		Integer startRecord = map.get("startRecord");
		Integer endRecord = map.get("endRecord");
		List<Article> list = boardService.getArticleList(boardCd, searchWord, startRecord, endRecord);

		int listItemNo = map.get("listItemNo");
		int prevPage = map.get("prevPage");
		int nextPage = map.get("nextPage");
		int firstPage = map.get("firstPage");
		int lastPage = map.get("lastPage");

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("boardNm", boardNm);

		
		List<Board> boards = this.getBoards(lang);
		model.addAttribute("boards", boards);
		
		model.addAttribute("articleNo", articleNo);

		return "bbs/view";
	}
	
	@RequestMapping(value="/write_form", method=RequestMethod.GET)
	public String writeForm(String boardCd, Locale locale, Model model) {
		String lang = locale.getLanguage();
		String boardNm = this.getBoardName(boardCd, lang);
		List<Board> boards = this.getBoards(lang);
		
		model.addAttribute("boardNm", boardNm);
		model.addAttribute("article", new Article());
		model.addAttribute("boards", boards);

		return "bbs/write_form";
	}

	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(@Valid Article article,
			BindingResult bindingResult,
			Model model,
			Locale locale,
			MultipartHttpServletRequest mpRequest,
			Principal principal) throws Exception {

		if (bindingResult.hasErrors()) {
			String boardNm = this.getBoardName(article.getBoardCd(), locale.getLanguage());
			model.addAttribute("boardNm", boardNm);
			return "bbs/write_form";
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

		return "redirect:/bbs/?curPage=1&boardCd=" + article.getBoardCd();
	}


	@RequestMapping(value="/addComment", method=RequestMethod.POST)
	public String addComment(Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord,
			String memo,
			Principal principal) throws Exception {

		Comment comment = new Comment();
		comment.setArticleNo(articleNo);
		comment.setEmail(principal.getName());
		comment.setMemo(memo);

		boardService.addComment(comment);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}

	@RequestMapping(value="/updateComment", method=RequestMethod.POST)
	public String updateComment(Integer commentNo, 
			Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord, 
			String memo) throws Exception {

		Comment comment = boardService.getComment(commentNo);
		comment.setMemo(memo);
		boardService.modifyComment(comment);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}

	@RequestMapping(value="/deleteComment", method=RequestMethod.POST)
	public String deleteComment(Integer commentNo, 
			Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {

		Comment comment = boardService.getComment(commentNo);
		boardService.removeComment(comment);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}

	@RequestMapping(value="/modify_form", method=RequestMethod.GET)
	public String modifyForm(Integer articleNo, 
			String boardCd,
			Locale locale,
			Model model) {
		
		String lang = locale.getLanguage();
		Article article = boardService.getArticle(articleNo);
		String boardNm = this.getBoardName(boardCd, lang);

		//수정페이지에서의 보일 게시글 정보
		model.addAttribute("article", article);
		model.addAttribute("boardNm", boardNm);
		
		List<Board> boards = this.getBoards(lang);
		model.addAttribute("boards", boards);
		
		return "bbs/modify_form";
	}

	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(@Valid Article article,
			BindingResult bindingResult,
			Integer curPage,
			String searchWord,
			Locale locale,
			Model model,
			MultipartHttpServletRequest mpRequest) throws Exception {

		if (bindingResult.hasErrors()) {
			String boardNm = this.getBoardName(article.getBoardCd(), locale.getLanguage());
			model.addAttribute("boardNm", boardNm);
			return "bbs/modify_form";
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

		return "redirect:/bbs/view?articleNo=" + article.getArticleNo() 
				+ "&boardCd=" + article.getBoardCd() 
				+ "&curPage=" + curPage 
				+ "&searchWord=" + searchWord;

	}

	/*    @RequestMapping(value="/download", method=RequestMethod.POST)
    public String download(String filename, Model model) {
        model.addAttribute("filename", filename);

        return "inc/download";
    }
	 */
	@RequestMapping(value="/deleteAttachFile", method=RequestMethod.POST)
	public String deleteAttachFile(Integer attachFileNo, 
			Integer articleNo, 
			String boardCd, 
			Integer curPage, 
			String searchWord) throws Exception {

		AttachFile attachFile = boardService.getAttachFile(attachFileNo);
		boardService.removeAttachFile(attachFile);

		searchWord = URLEncoder.encode(searchWord,"UTF-8");

		return "redirect:/bbs/view?articleNo=" + articleNo + 
				"&boardCd=" + boardCd + 
				"&curPage=" + curPage + 
				"&searchWord=" + searchWord;

	}

	@RequestMapping(value="/{articleNo}", method=RequestMethod.DELETE)
	public String deleteArticle(@PathVariable Integer articleNo, String boardCd, Integer curPage, String searchWord) {
		Article article = boardService.getArticle(articleNo);
		boardService.removeArticle(article);
		
		return "redirect:/bbs/?boardCd=" + boardCd + "&curPage=" + curPage + "&searchWord=" + searchWord;

	}

}