<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<h1>게시글 보기</h1>

<em class="filename">/WEB-INF/jsp/bbs/view.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.commons.WebContants" %&gt;</strong>
&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 상세보기" /&gt;
&lt;meta name="Description" content="게시판 상세보기" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function download(filename) {
	var form = document.getElementById("downForm");
	form.filename.value = filename;
	form.submit();
}
 
function deleteAttachFile(attachFileNo) {
	var chk = confirm("정말로 삭제하시겠습니까?");
	if (chk==true) {
		var form = document.getElementById("deleteAttachFileForm");
		form.attachFileNo.value = attachFileNo;
		form.submit();
	}
}

function deleteComment(commentNo) {
	var chk = confirm("정말로 삭제하시겠습니까?");
	if (chk==true) {
		var form = document.getElementById("deleteCommentForm");
		form.commentNo.value = commentNo;
		form.submit();
	}
}

function updateComment(no) {
	var commentno = "comment" + no;
	var formno = "modifyCommentForm" + no;
	var pele = document.getElementById(commentno);
	var formele = document.getElementById(formno);
	var pdisplay;
	var formdisplay;
	if ( pele.style.display ) {
		pdisplay = '';
		formdisplay = 'none';
	} else {
		pdisplay = 'none';
		formdisplay = '';
	}
	pele.style.display = pdisplay;
	formele.style.display = formdisplay;
}

function goList(page) {
	var form = document.getElementById("listForm");
	form.page.value = page;
	form.submit();
}

function goView(articleNo) {
	var form = document.getElementById("viewForm");
	form.articleNo.value = articleNo;
	form.submit();
}

function goWrite() {
	var form = document.getElementById("writeForm");
	form.submit();
}

function goModify() {
	var form = document.getElementById("modifyForm");
	form.submit();
}

function goDelete() {
	var chk = confirm('정말로 삭제하시겠습니까?');
	if (chk == true) {
		var form = document.getElementById("delForm");
		form.submit();
	}
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
&lt;table&gt;
&lt;tr&gt;
	&lt;th style="width: 37px;text-align: left;vertical-align: top;"&gt;TITLE&lt;/th&gt;
	&lt;th style="text-align: left;color: #555;"&gt;${title }&lt;/th&gt;
&lt;/tr&gt;	
&lt;/table&gt;

&lt;div id="gul-content"&gt;
	&lt;span id="date-writer-hit"&gt;edited ${regdate } by ${name } hit ${hit }&lt;/span&gt;
	&lt;p&gt;${content }&lt;/p&gt;
	&lt;p id="file-list" style="text-align: right;"&gt;
		&lt;c:forEach var="file" items="${attachFileList }" varStatus="status"&gt;
		&lt;a href="javascript:download('${file.filename }')"&gt;${file.filename }&lt;/a&gt;
		&lt;a href="javascript:deleteAttachFile('${file.attachFileNo }')"&gt;x&lt;/a&gt;
		&lt;br /&gt;
		&lt;/c:forEach&gt;	
	&lt;/p&gt;		
&lt;/div&gt;
	
&lt;!--  댓글 반복 시작 --&gt;
&lt;c:forEach var="comment" items="${commentList }" varStatus="status"&gt;	
&lt;div class="comments"&gt;
	&lt;span class="writer"&gt;${comment.name }&lt;/span&gt;
	&lt;span class="date"&gt;${comment.regdate }&lt;/span&gt;
	&lt;span class="modify-del"&gt;
		&lt;a href="javascript:updateComment('${comment.commentNo }')"&gt;수정&lt;/a&gt; |
		&lt;a href="javascript:deleteComment('${comment.commentNo }')"&gt;삭제&lt;/a&gt;
	&lt;/span&gt;

	&lt;p id="comment${comment.commentNo }"&gt;${comment.memo }&lt;/p&gt;
	&lt;form class="modify-comment" id="modifyCommentForm${comment.commentNo }" action="updateComment" method="post" style="display: none;"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="commentNo" value="${comment.commentNo }" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWod }" /&gt;
	&lt;/p&gt;
	&lt;div style="text-align: right;"&gt;
		&lt;a href="javascript:document.forms.modifyCommentForm${comment.commentNo }.submit()"&gt;수정하기&lt;/a&gt;
		| &lt;a href="javascript:updateComment('${comment.commentNo }')"&gt;취소&lt;/a&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;${comment.memo }&lt;/textarea&gt;
	&lt;/div&gt;
	&lt;/form&gt;
&lt;/div&gt;
&lt;/c:forEach&gt;
&lt;!--  댓글 반복 끝 --&gt;
&lt;form id="addCommentForm" action="addComment" method="post"&gt;
	&lt;p style="margin: 0;padding: 0;"&gt;
		&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;div id="addComment"&gt;
		&lt;textarea name="memo" rows="7" cols="50"&gt;&lt;/textarea&gt;
	&lt;/div&gt;
	&lt;div style="text-align: right;"&gt;
		&lt;input type="submit" value="댓글남기기" /&gt;
	&lt;/div&gt;
&lt;/form&gt;
	
&lt;div id="next-prev"&gt;
	&lt;c:if test="${nextArticle != null }"&gt;
		&lt;p&gt;다음글 : &lt;a href="javascript:goView('${nextArticle.articleNo }')"&gt;${nextArticle.title }&lt;/a&gt;&lt;/p&gt;
	&lt;/c:if&gt;
	&lt;c:if test="${prevArticle != null }"&gt;
		&lt;p&gt;이전글 : &lt;a href="javascript:goView('${prevArticle.articleNo }')"&gt;${prevArticle.title }&lt;/a&gt;&lt;/p&gt;
	&lt;/c:if&gt;
&lt;/div&gt;

&lt;div id="view-menu"&gt;
	&lt;div class="fl"&gt;
		&lt;input type="button" value="수정" onclick="goModify();" /&gt;
		&lt;input type="button" value="삭제" onclick="goDelete()" /&gt;
	&lt;/div&gt;
	&lt;div class="fr"&gt;
	&lt;c:if test="${nextArticle != null }"&gt;		
		&lt;input type="button" value="다음글" onclick="goView('${nextArticle.articleNo }')" /&gt;
	&lt;/c:if&gt;
	&lt;c:if test="${prevArticle != null }"&gt;			
		&lt;input type="button" value="이전글" onclick="goView('${prevArticle.articleNo }')" /&gt;
	&lt;/c:if&gt;
		&lt;input type="button" value="목록" onclick="goList('${param.page }')" /&gt;
		&lt;input type="button" value="새글쓰기" onclick="goWrite()" /&gt;
	&lt;/div&gt;
&lt;/div&gt;

&lt;table&gt;
&lt;tr&gt;
	&lt;th style="width: 60px"&gt;NO&lt;/th&gt;
	&lt;th&gt;TITLE&lt;/th&gt;
	&lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
	&lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
&lt;/tr&gt;

&lt;!--  반복 구간 시작 --&gt;
&lt;c:forEach var="article" items="${list }" varStatus="status"&gt;
&lt;tr&gt;
	&lt;td style="text-align: center;"&gt;
		&lt;c:choose&gt;
			&lt;c:when test="${param.articleNo == article.articleNo }"&gt;
				&lt;img src="../images/arrow.gif" alt="현재글" /&gt;
			&lt;/c:when&gt;
			&lt;c:otherwise&gt;
				${listItemNo - status.index }
			&lt;/c:otherwise&gt;
		&lt;/c:choose&gt;
	&lt;/td&gt;
	&lt;td&gt;
		&lt;a href="javascript:goView('${article.articleNo }')"&gt;${article.title }&lt;/a&gt;
		&lt;c:if test="${article.attachFileNum &gt; 0 }"&gt;
			&lt;img src="../images/attach.png" alt="첨부파일" /&gt;
		&lt;/c:if&gt;
		&lt;c:if test="${article.commentNum &gt; 0 }"&gt;
			&lt;span class="bbs-strong"&gt;[${article.commentNum }]&lt;/span&gt;
		&lt;/c:if&gt;
	&lt;/td&gt;
	&lt;td style="text-align: center;"&gt;${article.regdateForList }&lt;/td&gt;
	&lt;td style="text-align: center;"&gt;${article.hit }&lt;/td&gt;
&lt;/tr&gt;
&lt;/c:forEach&gt;
&lt;!--  반복 구간 끝 --&gt;
&lt;/table&gt;
		
&lt;div id="paging"&gt;
	
	&lt;c:if test="${prevPage &gt; 0 }"&gt;
		&lt;a href="javascript:goList('${prevPage }')"&gt;[이전]&lt;/a&gt;
	&lt;/c:if&gt;
	
	&lt;c:forEach var="i" begin="${firstPage }" end="${lastPage }"&gt;
		&lt;c:choose&gt;
		&lt;c:when test="${param.page == i}"&gt;
			&lt;span class="bbs-strong"&gt;${i }&lt;/span&gt;
		&lt;/c:when&gt;
		&lt;c:otherwise&gt;
			&lt;a href="javascript:goList('${i }')"&gt;${i }&lt;/a&gt;
		&lt;/c:otherwise&gt;
		&lt;/c:choose&gt;
	&lt;/c:forEach&gt;
	
	&lt;c:if test="${nextLink &gt; 0 }"&gt;
		&lt;a href="javascript:goList('${nextPage }')"&gt;[다음]&lt;/a&gt;
	&lt;/c:if&gt;
	
&lt;/div&gt;


&lt;div id="list-menu"&gt;
	&lt;input type="button" value="새글쓰기" onclick="goWrite()" /&gt;
&lt;/div&gt;

&lt;div id="search"&gt;
	&lt;form id="searchForm" action="./list" method="get" style="margin: 0;padding: 0;"&gt;
		&lt;p style="margin: 0;padding: 0;"&gt;
			&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
			&lt;input type="text" name="searchWord" size="15" maxlength="30" /&gt;
			&lt;input type="submit" value="검색" /&gt;
		&lt;/p&gt;	
	&lt;/form&gt;
&lt;/div&gt;
	
&lt;/div&gt;&lt;!--  bbs 끝 --&gt;
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
	&lt;form id="listForm" action="list" method="get"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
	&lt;form id="viewForm" action="view" method="get"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="articleNo" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
	&lt;form id="writeForm" action="write_form" method="get"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
	&lt;form id="modifyForm" action="modify_form" method="get"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
	&lt;form id="delForm" action="del" method="post"&gt;	
	&lt;p&gt;
		&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
	&lt;form id="deleteCommentForm" action="deleteComment" method="post"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="commentNo" /&gt;
		&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;	
	&lt;form id="deleteAttachFileForm" action="deleteAttachFile" method="post"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="attachFileNo" /&gt;
		&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
		&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
		&lt;input type="hidden" name="page" value="${param.page }" /&gt;
		&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
	&lt;form id="downForm" action="./download" method="post"&gt;
	&lt;p&gt;
		&lt;input type="hidden" name="filename" /&gt;
	&lt;/p&gt;
	&lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

WebContants.java에 LINE_SEPARATOR 상수를 추가한다.<br />
<em class="filename">WebContants.java</em> 
<pre class="prettyprint">
package net.java_school.commons;
 
public class WebContants {
    <strong>public final static String LINE_SEPARATOR = System.getProperty("line.separator");</strong>
    public final static String UPLOAD_PATH = "C:/www/spring-bbs/upload/";
    
}
</pre>

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/view", method=RequestMethod.GET)
public String view(Integer articleNo, 
		String boardCd, 
		Integer page,
		String searchWord, 
		Model model) {

	boardService.increaseHit(articleNo);
	
	//상세보기 
	Article article = boardService.getArticle(articleNo);
	List&lt;AttachFile&gt; attachFileList = boardService.getAttachFileList(articleNo);
	Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
	Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
	List&lt;Comment&gt; commentList = boardService.getCommentList(articleNo);
	String boardNm = boardService.getBoardNm(boardCd);
	
	//상세보기에서 볼 게시글 관련 정보
	String title = article.getTitle();//제목
	String content = article.getContent();//내용
	content = content.replaceAll(WebContants.LINE_SEPARATOR, "&lt;br /&gt;");
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
	
	//목록보기
	int numPerPage = 10;//페이지당 레코드 수
	int pagePerBlock = 10;//블록당 페이지 링크수
	
	int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
	PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
	boardService.setPagingHelper(pagingHelper);

	List&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord);
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
</pre>


<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>	
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
</ul>

