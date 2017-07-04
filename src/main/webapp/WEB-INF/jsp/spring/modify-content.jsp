<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<h1>게시글 수정</h1>

<em class="filename">/WEB-INF/jsp/bbs/modify.jsp</em> 
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 수정하기 폼" /&gt;
&lt;meta name="Description" content="게시판 수정하기 폼" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
	//var form = document.getElementById("modifyForm");
	//TODO 유효성 검사
	return true;
}

function goView() {
	var form = document.getElementById("viewForm");
	form.submit();
}
	
//]]&gt;
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

	&lt;div id="header"&gt;
		&lt;%@ include file="../inc/header.jsp" %&gt;
	&lt;/div&gt;

	&lt;div id="main-menu"&gt;
		&lt;%@ include file="../inc/main-menu.jsp" %&gt;
	&lt;/div&gt;

	&lt;div id="container"&gt;
		&lt;div id="content" style="min-height: 800px;"&gt;
			&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
			
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;${boardNm }&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;h2&gt;수정&lt;/h2&gt;
&lt;form id="modifyForm" action="modify" method="post" 
        enctype="multipart/form-data" onsubmit="return check()"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
	&lt;input type="hidden"  name="articleNo" value="${param.articleNo }" /&gt;
	&lt;input type="hidden"  name="boardCd" value="${param.boardCd }" /&gt;
	&lt;input type="hidden"  name="page" value="${param.page }" /&gt;
	&lt;input type="hidden"  name="searchWord" value="${param.searchWord }" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" style="width: 90%" value="${article.title }" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="17" cols="50"&gt;${article.content }&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td&gt;파일첨부&lt;/td&gt;
	&lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
	&lt;input type="submit" value="전송" /&gt;
	&lt;input type="button" value="상세보기" onclick="goView()" /&gt;
&lt;/div&gt;
&lt;/form&gt;
	
&lt;/div&gt;&lt;!-- bbs 끝 --&gt;
&lt;!--  본문 끝 --&gt;
		&lt;/div&gt;&lt;!-- content 끝 --&gt;
	&lt;/div&gt;&lt;!--  container 끝 --&gt;
	
	&lt;div id="sidebar"&gt;
		&lt;%@ include file="bbs-menu.jsp" %&gt;
	&lt;/div&gt;
	
	&lt;div id="extra"&gt;
		&lt;%@ include file="../inc/extra.jsp" %&gt;
	&lt;/div&gt;

	&lt;div id="footer"&gt;
		&lt;%@ include file="../inc/footer.jsp" %&gt;
	&lt;/div&gt;

&lt;/div&gt;

&lt;div id="form-group" style="display: none;"&gt;
	&lt;form id="viewForm" action="view" method="get"&gt;
	&lt;p&gt;
	&lt;input type="hidden" name="articleNo" value="${param.articleNo }"/&gt;
	&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
	&lt;input type="hidden" name="page" value="${param.page }" /&gt;
	&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/modify", method=RequestMethod.GET)
public String modifyForm(Integer articleNo, 
		String boardCd, 
		Model model) {
	
	Article article = boardService.getArticle(articleNo);
	String boardNm = boardService.getBoardNm(boardCd);
	
	//수정페이지에서의 보일 게시글 정보
	model.addAttribute("article", article);
	model.addAttribute("boardNm", boardNm);
	
	return "bbs/modify";
}
</pre>

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
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
	article.setBoardCd(boardCd);
	boardService.modifyArticle(article);

	//파일업로드
	Iterator&lt;String&gt; it = mpRequest.getFileNames();
	List&lt;MultipartFile&gt; fileList = new ArrayList&lt;MultipartFile&gt;();
	while (it.hasNext()) {
		MultipartFile multiFile = mpRequest.getFile((String) it.next());
		if (multiFile.getSize() &gt; 0) {
			String filename = multiFile.getOriginalFilename();
			multiFile.transferTo(new File(WebContants.UPLOAD_PATH + filename));
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
		attachFile.setEmail(article.getEmail());//원글 소유자가 첨부파일 소유자가 된다
		boardService.addAttachFile(attachFile);
	}
	
	searchWord = URLEncoder.encode(searchWord,"UTF-8");
	
	return "redirect:/bbs/view?articleNo=" + articleNo +
		"&amp;boardCd=" + boardCd +
		"&amp;page=" + page +
		"&amp;searchWord=" + searchWord;

}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
</ul>

