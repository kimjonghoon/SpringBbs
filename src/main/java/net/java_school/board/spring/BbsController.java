package net.java_school.board.spring;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
import net.java_school.commons.PagingHelper;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

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
            Integer curPage, 
            String searchWord,
            HttpServletRequest req,
            HttpSession session,
            Model model) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            //로그인 후 되돌아갈 URL를 구한다.
            String url = req.getServletPath();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            //로그인 페이지로 리다이렉트
            url = URLEncoder.encode(url, "UTF-8");
            return "redirect:/users/login?url=" + url;
        }
        
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
        
        model.addAttribute("list", list);
        model.addAttribute("boardNm", boardNm);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        
        return "bbs/list";
        
    }

    @RequestMapping(value="/write_form", method=RequestMethod.GET)
    public String writeForm(String boardCd,
            HttpServletRequest req,
            HttpSession session,
            Model model) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            //로그인 후 되돌아갈 URL를 구한다.
            String url = req.getServletPath();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            //로그인 페이지로 리다이렉트
            url = URLEncoder.encode(url, "UTF-8");
            return "redirect:/users/login?url=" + url;
        }

        //게시판 이름
        String boardNm = boardService.getBoardNm(boardCd);
        model.addAttribute("boardNm", boardNm);
        
        return "bbs/write_form";
    }

    @RequestMapping(value="/write", method=RequestMethod.POST)
    public String write(MultipartHttpServletRequest mpRequest,
            HttpSession session) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }
        
        String boardCd = mpRequest.getParameter("boardCd");
        String title = mpRequest.getParameter("title");
        String content = mpRequest.getParameter("content");
        
        Article article = new Article();
        article.setBoardCd(boardCd);
        article.setTitle(title);
        article.setContent(content);
        article.setEmail(user.getEmail());
        
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
            attachFile.setEmail(user.getEmail());
            boardService.addAttachFile(attachFile);
        }
        
        return "redirect:/bbs/list?curPage=1&boardCd=" + article.getBoardCd();
    }

    @RequestMapping(value="/view", method=RequestMethod.GET)
    public String view(Integer articleNo, 
            String boardCd, 
            Integer curPage,
            String searchWord,
            HttpServletRequest req,
            HttpSession session,
            Model model) throws Exception {

        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            //로그인 후 되돌아갈 URL를 구한다.
            String url = req.getServletPath();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            //로그인 페이지로 리다이렉트
            url = URLEncoder.encode(url, "UTF-8");
            return "redirect:/users/login?url=" + url;
        }
        
        /*
        상세보기를 할때마다 조회수를 1 증가
        하단에 목록에서 조회수를 제대로 보기위해서는
        목록 레코드를 페치하기 전에 조회수를 먼저 증가시켜야 한다.
        TODO : 사용자 IP 와 시간을 고려해서 조회수를 증가하도록
        */
        boardService.increaseHit(articleNo);
        
        Article article = boardService.getArticle(articleNo);//상세보기에서 볼 게시글
        List<AttachFile> attachFileList = boardService.getAttachFileList(articleNo);
        Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
        Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
        List<Comment> commentList = boardService.getCommentList(articleNo);
        String boardNm = boardService.getBoardNm(boardCd);
        
        //상세보기에서 볼 게시글 관련 정보
        String title = article.getTitle();//제목
        String content = article.getContent();//내용
        content = content.replaceAll(WebContants.LINE_SEPARATOR, "<br />");
        int hit = article.getHit();//조회수
        String name = article.getName();//작성자 이름
        String email = article.getEmail();//작성자 ID
        String regdate = article.getRegdateForView();//작성일

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
        PagingHelper pagingHelper = new PagingHelper(totalRecord, curPage, numPerPage, pagePerBlock);
        boardService.setPagingHelper(pagingHelper);

        List<Article> list = boardService.getArticleList(boardCd, searchWord);
        
        int listItemNo = boardService.getListItemNo();
        int prevPage = boardService.getPrevPage();
        int nextPage = boardService.getNextPage();
        int firstPage = boardService.getFirstPage();
        int lastPage = boardService.getLastPage();
        
        model.addAttribute("list", list);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("boardNm", boardNm);
        
        return "bbs/view";
    }
    
    @RequestMapping(value="/addComment", method=RequestMethod.POST)
    public String addComment(Integer articleNo, 
            String boardCd, 
            Integer curPage, 
            String searchWord,
            String memo,
            HttpSession session) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }

        Comment comment = new Comment();
        comment.setArticleNo(articleNo);
        comment.setEmail(user.getEmail());
        comment.setMemo(memo);
        
        boardService.addComment(comment);
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&boardCd=" + boardCd + 
            "&curPage=" + curPage + 
            "&searchWord=" + searchWord;

    }

    @RequestMapping(value="/updateComment", method=RequestMethod.POST)
    public String updateComment(
            Integer commentNo, 
            Integer articleNo, 
            String boardCd, 
            Integer curPage, 
            String searchWord, 
            String memo,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        Comment comment = boardService.getComment(commentNo);
        
        //로그인 사용자가 댓글 소유자인지를  검사
        if (user == null || !user.getEmail().equals(comment.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        //생성되어 있는 Comment 객체를 재사용한다.
        comment.setMemo(memo);
        boardService.modifyComment(comment);
        
        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&boardCd=" + boardCd + 
            "&curPage=" + curPage + 
            "&searchWord=" + searchWord;

    }

    @RequestMapping(value="/deleteComment", method=RequestMethod.POST)
    public String deleteComment(
            Integer commentNo, 
            Integer articleNo, 
            String boardCd, 
            Integer curPage, 
            String searchWord,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        Comment comment = boardService.getComment(commentNo);
        
        //로그인 사용자가 댓글의 소유자인지 검사
        if (user == null || !user.getEmail().equals(comment.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        boardService.removeComment(commentNo);
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&boardCd=" + boardCd + 
            "&curPage=" + curPage + 
            "&searchWord=" + searchWord;

    }

    @RequestMapping(value="/modify_form", method=RequestMethod.GET)
    public String modifyForm(
            Integer articleNo, 
            String boardCd,
            HttpSession session,
            Model model) {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        Article article = boardService.getArticle(articleNo);
        
        //로그인 사용자가 글 작성자인지 검사
        if (user == null || !user.getEmail().equals(article.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        //수정페이지에서의 보일 게시글 정보
        String title = article.getTitle();
        String content = article.getContent();
        String boardNm = boardService.getBoardNm(boardCd);
        
        model.addAttribute("title", title);
        model.addAttribute("content", content);
        model.addAttribute("boardNm", boardNm);
        
        return "bbs/modify_form";
    }
    
    @RequestMapping(value="/modify", method=RequestMethod.POST)
    public String modify(
            MultipartHttpServletRequest mpRequest,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        int articleNo = Integer.parseInt(mpRequest.getParameter("articleNo"));
        Article article = boardService.getArticle(articleNo);
        
        //로그인 사용자가 글 작성자인지 검사
        if (!article.getEmail().equals(user.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        String boardCd = mpRequest.getParameter("boardCd");
        int curPage = Integer.parseInt(mpRequest.getParameter("curPage"));
        String searchWord = mpRequest.getParameter("searchWord");
        
        String title = mpRequest.getParameter("title");
        String content = mpRequest.getParameter("content");
        
        //게시글 수정
        article.setTitle(title);
        article.setContent(content);
        article.setBoardCd(boardCd);//게시판 종류 변경
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
            attachFile.setArticleNo(articleNo);
            attachFile.setEmail(user.getEmail());
            boardService.addAttachFile(attachFile);
        }
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        return "redirect:/bbs/view?articleNo=" + articleNo 
            + "&boardCd=" + boardCd 
            + "&curPage=" + curPage 
            + "&searchWord=" + searchWord;

    }

    @RequestMapping(value="/download", method=RequestMethod.POST)
    public String download(String filename, HttpSession session, Model model) {
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }

        model.addAttribute("filename", filename);
        return "inc/download";

    }

    @RequestMapping(value="/deleteAttachFile", method=RequestMethod.POST)
    public String deleteAttachFile(
            Integer attachFileNo, 
            Integer articleNo, 
            String boardCd, 
            Integer curPage, 
            String searchWord,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        AttachFile attachFile = boardService.getAttachFile(attachFileNo);
        
        //로그인 사용자가 첨부파일 소유자인지 검사
        if (user == null || !user.getEmail().equals(attachFile.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        boardService.removeAttachFile(attachFileNo);
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&boardCd=" + boardCd + 
            "&curPage=" + curPage + 
            "&searchWord=" + searchWord;

    }

    @RequestMapping(value="/del", method=RequestMethod.POST)
    public String del(
            Integer articleNo, 
            String boardCd, 
            Integer curPage, 
            String searchWord,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        Article article = boardService.getArticle(articleNo);
        
        //로그인 사용자가 글 작성자인지 검사
        if (user == null || !user.getEmail().equals(article.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        boardService.removeArticle(articleNo);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        
        return "redirect:/bbs/list?boardCd=" + boardCd + 
            "&curPage=" + curPage + 
            "&searchWord=" + searchWord;

    }
    
}
