<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<h1>새글쓰기</h1>

<h2>글쓰기 폼으로 이동</h2>
<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/write", method=RequestMethod.GET)
public String write(String boardCd, Model model) {
	
	//게시판 이름
	String boardNm = boardService.getBoardNm(boardCd);
	model.addAttribute("boardNm", boardNm);
	
	return "bbs/write";
}
</pre>

<em class="filename">/WEB-INF/jsp/bbs/write.jsp</em> 
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /&gt;
&lt;meta name="Keywords" content="글쓰기 화면" /&gt;
&lt;meta name="Description" content="글쓰기 화면" /&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
	//var form = document.getElementById("writeForm");
	//유효성 검사로직 추가
	return true;
}

function goList() {
	var form = document.getElementById("listForm");
	form.submit();
}

function goView() {
	var form = document.getElementById("viewForm");
	if (form.articleNo.value != 0) {
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
&lt;h2&gt;글쓰기&lt;/h2&gt;
&lt;form id="writeForm" action="write" method="post" 
        enctype="multipart/form-data" onsubmit="return check()"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
&lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
&lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
&lt;input type="hidden" name="page" value="${param.page }" /&gt;
&lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" style="width: 90%" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="17" cols="50"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;파일첨부&lt;/td&gt;
    &lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
	&lt;input type="submit" value="전송" /&gt;
	&lt;input type="button" value="목록" onclick="goList()" /&gt;
	&lt;c:if test="${not empty param.articleNo }"&gt;
	&lt;input type="button" value="상세보기" onclick="goView()" /&gt;
	&lt;/c:if&gt;
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
    &lt;form id="listForm" action="list" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
        &lt;input type="hidden" name="page" value="${param.page }" /&gt;
        &lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

빌드를 한 후 bbs/list?boardCd=data&amp;page=1를 방문한다.<br />
새글쓰기 버튼을 클릭하여 글쓰기 폼으로 이동하는지 테스트한다.<br />

<h2>글쓰기 처리</h2>
첨부파일을 업로드하기 위해서는 commons-io와 commons-fileupload 라이브러리가 필요하다.<br />
pom.xml에서 의존성 설정이 되어 있으니 확인한다.<br />
<br />
업로드 디렉터리를 지정해야 하는데, 자주 쓰이는 값이므로 변수화할 것이다.<br />
웹사이트에서 쓰일 상수를 위한 클래스를 작성한다.<br />
UPLOAD_PATH에 파일이 저장되는 디렉터리를 지정한다.<br />
지정한 위치에 upload란 이름의 폴더를 생성한다.<br />

<em class="filename">WebContants.java</em>
<pre class="prettyprint">
package net.java_school.commons;
 
public class WebContants {
    public final static String UPLOAD_PATH = "C:/www/spring-bbs/upload/";
}
</pre>

spring-bbs-servlet.xml에 아래 설정을 추가한다.<br />

<em class="filename">spring-bbs-servlet.xml</em> 
<pre class="prettyprint">
&lt;bean id="multipartResolver"
 class="org.springframework.web.multipart.commons.CommonsMultipartResolver"
 p:maxUploadSize="104857600" p:maxInMemorySize="10485760" /&gt;
</pre>

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/write", method=RequestMethod.POST)
public String write(MultipartHttpServletRequest mpRequest) throws Exception {
 
    String boardCd = mpRequest.getParameter("boardCd");
    String title = mpRequest.getParameter("title");
    String content = mpRequest.getParameter("content");

    Article article = new Article();
    article.setBoardCd(boardCd);
    article.setTitle(title);
    article.setContent(content);
    article.setEmail("hong@gmail.org");//임의로 정하고 회원모듈 구현 후 수정

    boardService.addArticle(article);

    //파일 업로드
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
        attachFile.setArticleNo(article.getArticleNo());
        attachFile.setEmail("hong@gmail.org");//임시로 정함.
        boardService.addAttachFile(attachFile);
    }

    return "redirect:/bbs/list?page=1&amp;boardCd=" + article.getBoardCd();
}
</pre>

회원 모듈이 구현전이므로 이메일을 임시로 정했다.<br />
빌드하고 톰캣을 재실행한다.<br />
글쓰기를 테스트한다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
</ul>

