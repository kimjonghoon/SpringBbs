<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page isELIgnored="true" %>
<div id="last-modified">Last Modified : 2015.6.20</div>

<h1>모델 2방식으로 변경</h1>

모델 2 방식으로 변경하기 전에 JSP에 적용할 EL과 JSTL에 대해서 먼저 알아본다.<br />
 
<h3>EL</h3>
EL(Expression Language)은 JSP 스펙에 포함되어 있다.<br />
EL을 사용하면 자바빈즈의 속성값에 보다 쉽게 접근할 수 있다.<br />
예를 들어, ${user.email }은 User 객체의 getEmail() 메서드 호출과 같다.<br />
<br />
EL을 사용할 때 사용할 수 있는 내재 객체는,<br />
pageScope,
requestScope,
sessionScope,
applicationScope,
param,
paramValues,
header,
headerValues,
initParam,
cookie,
pageContext가 있다.<br />

searchWord 파라미터의 값에 접근할 때는 ${param.searchWord }와 같이 내재 객체를 이용한다.<br />
이 방법이 String searchWord = request.getParameter("searchWord");와 &lt;%= searchWord %&gt;를
함께 사용하는 것보다 편리한 점은 searchWord 파라미터가 넘어오지 않더라도 ${param.searchWord }에는 
null이 아니라 ""가 출력된다는 점이다.<br />
<br />
객체가 어느 스코프에 있는지 정확히 몰라도 된다.<br />
예를 들어 ${user.email }에서의 User 객체는, 
pageScope - requestScope - sessionScope - applicationScope 순으로 검색된다.<br />
<br />
스크립틀릿과 EL을 될 수 있으면 혼용해서 사용하지 않도록 한다.<br />
혼용하면 코드가 읽기 힘들어진다.<br />
모델 1에서는 어쩔 수 없이 혼용할 수밖에 없다.<br />
JSP에서 비즈니스 로직을 수행하기 때문이다.<br />
그래서 EL을 모델 2를 진행하는 시점에 소개하는 것이다.<br />

<h3>JSTL</h3>
태그 라이브러리(Tag Library)는 자바 코드로 바뀌는 태그를 만드는 기술이다.<br />
태그는 디자이너에게 거부감이 덜하므로 이 기술은 디자이너와의 협업에 도움이 된다.<br />
JSTL은 JSP Standard Tag Library의 약자로 꼭 필요한 태그 라이브러리를 정리한 것인데,
JSP 스펙에 포함되어 있지 않다.<br />
따라서 JSTL 사용하려면 라이브러리를 내려받아야 한다.<br />
<br />
다음 주소에서 가장 최신 버전인 JSTL 1.1.2를 내려받는다.<br /> 
<a href="http://archive.apache.org/dist/jakarta/taglibs/standard/binaries/">http://archive.apache.org/dist/jakarta/taglibs/standard/binaries/</a><br />
압축을 풀면 생기는 lib 폴더에서 jstl.jar와 standard.jar를 웹 애플리케이션의 WEB-INF/lib에 복사한다.<br />
JSTL 중 core가 가장 많이 사용되는데 core를 사용하려면 taglib 지시어를 아래처럼 JSP에 추가한다.<br />
    
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;</strong>
</pre>

다음 JSTL 예제를 작성하고 도큐먼트 베이스에 만들고 테스트한다.<br />

<em class="filename">/jstl.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.*" %&gt;
&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;
&lt;%
int firstPage = 21;
int lastPage = 30;
ArrayList&lt;Integer&gt; a = new ArrayList&lt;Integer&gt;();
a.add(1);a.add(2);a.add(3);
a.add(4);a.add(5);a.add(6);
a.add(7);a.add(8);a.add(9);a.add(10);
%&gt;
&lt;c:set var="a" value="&lt;%=a %&gt;" /&gt;
&lt;c:set var="c" value="" /&gt;
&lt;c:set var="firstPage" value="&lt;%=firstPage %&gt;" /&gt;
&lt;c:set var="lastPage" value="&lt;%=lastPage %&gt;" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;JSTL core 예제&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;if 문&lt;/h1&gt;

&lt;c:if test="${empty b }"&gt;
    &lt;h4&gt;b 리스트는 비었다.&lt;/h4&gt;
&lt;/c:if&gt;

&lt;c:if test="${not empty c }"&gt;
    &lt;h4&gt;c 는 null 이거나 ""가 아니다.&lt;/h4&gt;
&lt;/c:if&gt;

&lt;c:choose&gt;
    &lt;c:when test="${empty a }"&gt;
        &lt;h4&gt;리스트는 비었다.&lt;/h4&gt;
    &lt;/c:when&gt;
&lt;/c:choose&gt;

&lt;h1&gt;if ~ else 문&lt;/h1&gt;
&lt;c:choose&gt;
    &lt;c:when test="${empty a }"&gt;
        &lt;h4&gt;리스트는 비었다.&lt;/h4&gt;
    &lt;/c:when&gt;
    &lt;c:otherwise&gt;
        &lt;h4&gt;리스트에 뭔가 있다.&lt;/h4&gt;
    &lt;/c:otherwise&gt;
&lt;/c:choose&gt;

&lt;h1&gt;for 문&lt;/h1&gt;
&lt;c:forEach var="i" begin="${firstPage }" end="${lastPage }"&gt;
    [${i }]
&lt;/c:forEach&gt;

&lt;h1&gt;for 문&lt;/h1&gt;
&lt;table&gt;
&lt;c:forEach var="i" items="${a }" varStatus="status"&gt;
    &lt;tr&gt;
        &lt;td&gt;${status.index }&lt;/td&gt;&lt;td&gt;${i }&lt;/td&gt;
    &lt;/tr&gt;
&lt;/c:forEach&gt;
&lt;/table&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

위 예제는 JSTL에서 가장 중요한 core 사용법을 간단하게 소개하고 있다.<br />
<br />
이제는 모델 1 게시판을 모델 2 게시판으로 변경할 준비가 되었다.<br />
작업 전에 주요 변경 사항이 무엇인지 파악해 보자.<br />

<ul>
  <li>모든 JSP는 EL과 JSTL를 사용한다.</li>
  <li>JSP는 결과를 받아서 보여주는 일만 하게 한다.</li>
  <li>비즈니스 로직을 담당하는 액션 클래스를 만든다.</li>
  <li>확장자가 *.do인 요청은 일단 컨트롤러에게 전달되도록 한다.</li>
</ul>

<h3>JSP 화면 디자인 수정</h3>
EL과 JSTL를 사용하여 코드를 수정함과 동시에, 
인클루드 지시어에 사용된 jsp를 제외한 모든 .jsp를 .do로 바꾼다.<br />

<em class="filename">header.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;</strong>
&lt;h1 style="float: left;width: 150px;"&gt;&lt;a href="../"&gt;&lt;img src="../images/ci.gif" alt="java-school" /&gt;&lt;/a&gt;&lt;/h1&gt;
&lt;div id="memberMenu" style="float: right;position: relative;top: 7px;"&gt;
<strong>&lt;c:choose&gt;
    &lt;c:when test="${empty user}"&gt;</strong>
        &lt;input type="button" value="로그인" onclick="location.href='../users/login<strong>.do</strong>'" /&gt;
        &lt;input type="button" value="회원 가입" onclick="location.href='../users/signUp<strong>.do</strong>'" /&gt;
    <strong>&lt;/c:when&gt;
    &lt;c:otherwise&gt;</strong>
        &lt;input type="button" value="로그아웃" onclick="location.href='../users/logout_proc<strong>.do</strong>'" /&gt;
        &lt;input type="button" value="내 정보 수정" onclick="location.href='../users/editAccount<strong>.do</strong>'" /&gt;
    <strong>&lt;/c:otherwise&gt;
&lt;/c:choose&gt;</strong>
&lt;/div&gt;
</pre>

<em class="filename">bbs-menu.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;h1&gt;게시판&lt;/h1&gt;
&lt;ul&gt;
    &lt;li&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="list<strong>.do</strong>?boardCd=free&amp;page=1"&gt;자유 게시판&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="list<strong>.do</strong>?boardCd=qna&amp;page=1"&gt;QnA게시판&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="list<strong>.do</strong>?boardCd=data&amp;page=1"&gt;자료실&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>

main-menu.jsp 역시 위를 참조하여 수정한다.<br />
 


위 JSP 파일은 간단하여 프로그램 로직이 필요 없었다.<br />
목록을 보여주는 JSP에는 프로그램 로직이 필요하다.<br />
따라서 JSTL core를 사용하기 위한 태그 라이브러리 지시어를 추가한다.<br />
loginCheck.jsp를 인클루드하는 부분은 없앤다.<br />
logincheck.jsp가 담당하는 로직은 액션 클래스에서 담당하는 것이 맞기 때문이다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 목록" /&gt;
&lt;meta name="Description" content="게시판 목록" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
           
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
            
&lt;h1&gt;<strong>${boardNm }</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
    &lt;!--  게시판 목록 머리말 --&gt;
    &lt;table&gt;
    &lt;tr&gt;
        &lt;th style="width: 60px"&gt;NO&lt;/th&gt;
        &lt;th&gt;TITLE&lt;/th&gt;
        &lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
        &lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
    &lt;/tr&gt;
    &lt;!--  반복 구간 시작 --&gt;
    <strong>&lt;c:forEach var="article" items="${list }" varStatus="status"&gt;</strong>
    &lt;tr&gt;
        &lt;td style="text-align: center;"&gt;<strong>${listItemNo - status.index }</strong>&lt;/td&gt;
        &lt;td&gt;
            &lt;a href="javascript:goView('<strong>${article.articeNo }</strong>')"&gt;<strong>${article.title }</strong>&lt;/a&gt;
            <strong>&lt;c:if test="${article.attachFileNum &gt; 0 }"&gt;</strong>
            &lt;img src="../images/attach.png" alt="첨부 파일" /&gt;
            <strong>&lt;/c:if&gt;</strong>
            <strong>&lt;c:if test="${article.commentNum &gt; 0 }"&gt;</strong>
            &lt;span class="bbs-strong"&gt;[<strong>${article.commentNum }</strong>]&lt;/span&gt;
            <strong>&lt;/c:if&gt;</strong>
        &lt;/td&gt;
        &lt;td style="text-align: center;"&gt;<strong>${article.regdate }</strong>&lt;/td&gt;
        &lt;td style="text-align: center;"&gt;<strong>${article.hit }</strong>&lt;/td&gt;
    &lt;/tr&gt;
    <strong>&lt;/c:forEach&gt;</strong>
    &lt;!--  반복 구간 끝 --&gt;
    &lt;/table&gt;
        
    &lt;div id="paging"&gt;
        <strong>&lt;c:if test="${prevPage &gt; 0 }"&gt;</strong>
            &lt;a href="javascript:goList('<strong>${prevPage }</strong>')"&gt;[이전]&lt;/a&gt;
        <strong>&lt;/c:if&gt;</strong>
        
        <strong>&lt;c:forEach var="i" begin="${firstPage }" end="${lastPage }"&gt;</strong>
            <strong>&lt;c:choose&gt;
                &lt;c:when test="${param.page == i }"&gt;</strong>
                &lt;span class="bbs-strong"&gt;<strong>${i }</strong>&lt;/span&gt;
                <strong>&lt;/c:when&gt;
                &lt;c:otherwise&gt;</strong>
                &lt;a href="javascript:goList('<strong>${i }</strong>')"&gt;<strong>${i }</strong>&lt;/a&gt;
                <strong>&lt;/c:otherwise&gt;
            &lt;/c:choose&gt;
        &lt;/c:forEach&gt;</strong>

        <strong>&lt;c:if test="${nextPage &gt; 0 }"&gt;</strong>
            &lt;a href="javascript:goList('<strong>${nextPage }</strong>')"&gt;[다음]&lt;/a&gt;
        <strong>&lt;/c:if&gt;</strong>
    &lt;/div&gt;

    &lt;div id="list-menu"&gt;
        &lt;input type="button" value="새 글쓰기" onclick="goWrite()" /&gt;
    &lt;/div&gt;

    &lt;div id="search"&gt;
        &lt;form action="list<strong>.do</strong>" method="get" style="margin: 0;padding: 0;"&gt;
            &lt;p style="margin: 0;padding: 0;"&gt;
                &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
                &lt;input type="hidden" name="page" value="1" /&gt;
                &lt;input type="text" name="searchWord" size="15" maxlength="30" /&gt;
                &lt;input type="submit" value="검색" /&gt;
            &lt;/p&gt;
        &lt;/form&gt;
    &lt;/div&gt;
    
&lt;/div&gt;
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

&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="listForm" action="list<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="viewForm" action="view<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="writeForm" action="write_form<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

list.jsp 수정을 완료했다.<br />
액션은 다음과 같은 데이터를 만들어서 list.jsp에 전달해야 한다.<br />
<br />
boardNm : 게시판 이름<br />
list : 게시글이 담긴 ArrayList<br />
listItemNo : 목록 아이템에 붙는 번호<br /> 
prevPage : [이전] 링크를 위한 페이지 번호<br />
firstPage : 현재 블록에 해당하는 첫 번째 페이지 번호<br />
lastPage : 현재 블록에 해당하는 마지막 페이지 번호<br />
nextPage : [다음] 링크를 위한 페이지 번호<br />


<em class="filename">view.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 상세보기" /&gt;
&lt;meta name="Description" content="게시판 상세보기" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function modifyCommentToggle(articleNo) {
    var p_id = "comment" + articleNo;
    var form_id = "modifyCommentForm" + articleNo;
    var p = document.getElementById(p_id);
    var form = document.getElementById(form_id);
    
    var p_display;
    var form_display;
    
    if (p.style.display) {
        p_display = '';
        form_display = 'none';
    } else {
        p_display = 'none';
        form_display = '';
    }
    
    p.style.display = p_display;
    form.style.display = form_display;
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
    var check = confirm("정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("delForm");
        form.submit();
    }
}

function deleteAttachFile(attachFileNo) {
    var check = confirm("첨부 파일을 정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("deleteAttachFileForm");
        form.attachFileNo.value = attachFileNo;
        form.submit();
    }
}

function deleteComment(commentNo) {
    var check = confirm("댓글을 정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("deleteCommentForm");
        form.commentNo.value = commentNo;
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;<strong>${boardNm }</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;th style="width: 37px;text-align: left;vertical-align: top;"&gt;TITLE&lt;/th&gt;
    &lt;th style="text-align: left;color: #555;"&gt;<strong>${title }</strong>&lt;/th&gt;
&lt;/tr&gt; 
&lt;/table&gt;
&lt;div id="gul-content"&gt;
    &lt;span id="date-writer-hit"&gt;edited <strong>${regdate }</strong> by <strong>${name }</strong> hit <strong>${hit }</strong>&lt;/span&gt;
    &lt;p&gt;<strong>${content }</strong>&lt;/p&gt;
    &lt;p id="file-list" style="text-align: right"&gt;
        <strong>&lt;c:forEach var="file" items="${attachFileList }" varStatus="status"&gt;</strong>
            &lt;a href="<strong>${uploadPath }${file.filename }</strong>"&gt;<strong>${file.filename }</strong>&lt;/a&gt;
            <strong>&lt;c:if test="${user.email == file.email }"&gt;</strong>
            &lt;a href="javascript:deleteAttachFile('<strong>${file.attachFileNo }</strong>')"&gt;x&lt;/a&gt;
            <strong>&lt;/c:if&gt;</strong>
            &lt;br /&gt;
        <strong>&lt;/c:forEach&gt;</strong>
    &lt;/p&gt;
&lt;/div&gt;

&lt;!--  댓글 반복 시작 --&gt;
<strong>&lt;c:forEach var="comment" items="${commentList }" varStatus="status"&gt;</strong>
&lt;div class="comments"&gt;
    &lt;span class="writer"&gt;<strong>${comment.name }</strong>&lt;/span&gt;
    &lt;span class="date"&gt;<strong>${comment.regdate }</strong>&lt;/span&gt;
    <strong>&lt;c:if test="${user.email == comment.email }"&gt;</strong>
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:modifyCommentToggle('<strong>${comment.commentNo }</strong>')"&gt;수정&lt;/a&gt;
         | &lt;a href="javascript:deleteComment('<strong>${comment.commentNo }</strong>')"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
    <strong>&lt;/c:if&gt;</strong>
    &lt;p id="comment<strong>${comment.commentNo }</strong>"&gt;<strong>${comment.memo }</strong>&lt;/p&gt;
    &lt;form id="modifyCommentForm<strong>${comment.commentNo }</strong>" class="modify-comment" action="updateComment_proc<strong>.do</strong>" method="post" style="display: none;"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" value="<strong>${comment.commentNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;div class="fr"&gt;
            &lt;a href="javascript:document.forms.modifyCommentForm<strong>${comment.commentNo }</strong>.submit()"&gt;수정하기&lt;/a&gt;
            | &lt;a href="javascript:modifyCommentToggle('<strong>${comment.commentNo }</strong>')"&gt;취소&lt;/a&gt;
    &lt;/div&gt;
    &lt;div&gt;
        &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;<strong>${comment.memo }</strong>&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/div&gt;
<strong>&lt;/c:forEach&gt;</strong>
&lt;!--  댓글 반복 끝 --&gt;

&lt;form id="addCommentForm" action="addComment_proc<strong>.do</strong>" method="post"&gt;
    &lt;p style="margin: 0; padding: 0;"&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>"/&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;       
    &lt;/p&gt;
    &lt;div id="addComment"&gt;
        &lt;textarea name="memo" rows="7" cols="50"&gt;&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;div style="text-align: right;"&gt;
        &lt;input type="submit" value="댓글 남기기" /&gt;
    &lt;/div&gt;
&lt;/form&gt;

&lt;div id="next-prev"&gt;
    <strong>&lt;c:if test="${nextArticle != null }"&gt;</strong>
    &lt;p&gt;다음 글 : &lt;a href="javascript:goView('<strong>${nextArticle.articleNo }</strong>')"&gt;<strong>${nextArticle.title }</strong>&lt;/a&gt;&lt;/p&gt;
    <strong>&lt;/c:if&gt;</strong>
    <strong>&lt;c:if test="${prevArticle != null }"&gt;</strong>
    &lt;p&gt;이전 글 : &lt;a href="javascript:goView('<strong>${prevArticle.articleNo }</strong>')"&gt;<strong>${prevArticle.title }</strong>&lt;/a&gt;&lt;/p&gt;
    <strong>&lt;/c:if&gt;</strong>
&lt;/div&gt;

&lt;div id="view-menu"&gt;
    <strong>&lt;c:if test="${user.email == email }"&gt;</strong>
    &lt;div class="fl"&gt;
        &lt;input type="button" value="수정" onclick="goModify()" /&gt;
        &lt;input type="button" value="삭제" onclick="goDelete()"/&gt;
    &lt;/div&gt;
    <strong>&lt;/c:if&gt;</strong>
    &lt;div class="fr"&gt;
        <strong>&lt;c:if test="${nextArticle != null }"&gt;</strong>
        &lt;input type="button" value="다음 글" onclick="goView('<strong>${nextArticle.articleNo }</strong>')" /&gt;
        <strong>&lt;/c:if&gt;</strong>
        <strong>&lt;c:if test="${prevArticle != null }"&gt;</strong>
        &lt;input type="button" value="이전 글" onclick="goView('<strong>${prevArticle.articleNo }</strong>')" /&gt;
        <strong>&lt;/c:if&gt;</strong>
        &lt;input type="button" value="목록" onclick="goList('<strong>${param.page }</strong>')" /&gt;
        &lt;input type="button" value="새 글쓰기" onclick="goWrite()" /&gt;
    &lt;/div&gt;
&lt;/div&gt;

&lt;!-- 목록 --&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;th style="width: 60px"&gt;NO&lt;/th&gt;
    &lt;th&gt;TITLE&lt;/th&gt;
    &lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
    &lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
&lt;/tr&gt;
    
<strong>&lt;c:forEach var="article" items="${list }" varStatus="status"&gt;</strong>
&lt;tr&gt;
    &lt;td style="text-align: center;"&gt;
    <strong>&lt;c:choose&gt;</strong>
        <strong>&lt;c:when test="${param.articleNo == article.articleNo }"&gt;</strong>
        &lt;img src="../images/arrow.gif" alt="현재 글" /&gt;
        <strong>&lt;/c:when&gt;</strong>
        <strong>&lt;c:otherwise&gt;</strong>
        <strong>${listItemNo - status.index }</strong>
        <strong>&lt;/c:otherwise&gt;</strong>
    <strong>&lt;/c:choose&gt;</strong>
    &lt;/td&gt;
    &lt;td&gt;
        &lt;a href="javascript:goView('<strong>${article.articleNo }</strong>')"&gt;<strong>${article.title }</strong>&lt;/a&gt;
        <strong>&lt;c:if test="${article.attachFileNum &gt; 0 }"&gt;</strong>
        &lt;img src="../images/attach.png" alt="첨부 파일" /&gt;
        <strong>&lt;/c:if&gt;</strong>
        <strong>&lt;c:if test="${article.commentNum &gt; 0 }"&gt;</strong>
        &lt;span class="bbs-strong"&gt;[<strong>${article.commentNum }</strong>]&lt;/span&gt;
        <strong>&lt;/c:if&gt;</strong>
    &lt;/td&gt;
    &lt;td style="text-align: center;"&gt;<strong>${article.regdate }</strong>&lt;/td&gt;
    &lt;td style="text-align: center;"&gt;<strong>${article.hit }</strong>&lt;/td&gt;
&lt;/tr&gt;
<strong>&lt;/c:forEach&gt;</strong>
&lt;/table&gt;
    
&lt;div id="paging"&gt;
    <strong>&lt;c:if test="${prevPage &gt; 0 }"&gt;</strong>
        &lt;a href="javascript:goList('<strong>${prevPage }</strong>')"&gt;[이전]&lt;/a&gt;
    <strong>&lt;/c:if&gt;</strong>
    
    <strong>&lt;c:forEach var="i" begin="${firstPage }" end="${lastPage }"&gt;</strong>
        <strong>&lt;c:choose&gt;</strong>
            <strong>&lt;c:when test="${param.page == i }"&gt;</strong>
                &lt;span class="bbs-strong"&gt;<strong>${i }</strong>&lt;/span&gt;
            <strong>&lt;/c:when&gt;</strong>
            <strong>&lt;c:otherwise&gt;</strong>
                &lt;a href="javascript:goList('<strong>${i }</strong>')"&gt;<strong>${i }</strong>&lt;/a&gt;
            <strong>&lt;/c:otherwise&gt;
        &lt;/c:choose&gt;</strong>  
    <strong>&lt;/c:forEach&gt;</strong>
    
    <strong>&lt;c:if test="${nextPage &gt; 0 }"&gt;</strong>
        &lt;a href="javascript:goList('<strong>${nextPage }</strong>')"&gt;[다음]&lt;/a&gt;
    <strong>&lt;/c:if&gt;</strong>
&lt;/div&gt;

&lt;div id="list-menu"&gt;
    &lt;input type="button" value="새 글쓰기" onclick="goWrite()" /&gt;
&lt;/div&gt;

&lt;div id="search"&gt;
    &lt;form action="list<strong>.do</strong>" method="get"&gt;
        &lt;p style="margin: 0;padding: 0;"&gt;
            &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
            &lt;input type="hidden" name="page" value="1" /&gt;
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

&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="listForm" action="list<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="viewForm" action="view<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="writeForm" action="write_form<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="modifyForm" action="modify_form<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="delForm" action="del_proc<strong>.do</strong>" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="deleteCommentForm" action="deleteComment_proc<strong>.do</strong>" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" /&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;   
    &lt;form id="deleteAttachFileForm" action="deleteAttachFile_proc<strong>.do</strong>" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="attachFileNo" /&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;       
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>


view.jsp로 액션이 만들어서 전달해야 하는 데이터는 다음과 같다.<br />
<br />
boardNm : 게시판 이름<br />
title : 상세보기 대상 게시글의 제목<br />
regdate : 상세보기 대상 게시글의 등록일<br />
name : 상세보기 대상 게시글의 소유자 이름<br />
hit : 상세보기 대상 게시글의 조회 수<br />
content : 상세보기 대상 게시글의 내용<br />
attachFileList : 상세보기 대상 게시글의 첨부 파일 리스트<br />
commentList : 상세보기 대상 게시글의 댓글 리스트<br />
nextArticle : 다음 게시글 객체<br />
prevArticle : 이전 게시글 객체<br />
-- 이하는 목록과 같음 --<br />
list : 목록<br /> 
listItemNo : 목록 아이템에 붙일 번호<br />
prevPage : [이전] 링크를 위한 페이지 번호<br />
firstPage : 현재 블록에 속한 첫 번째 페이지 번호<br />
lastPage : 현재 블록에 속한 마지막 페이지 번호<br />
nextPage : [다음] 링크를 위한 페이지 번호<br />



<em class="filename">write_form.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;</strong> 
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="글쓰기 화면" /&gt;
&lt;meta name="Description" content="글쓰기 화면" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
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
        
&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;<strong>${boardNm }</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;h2&gt;글쓰기&lt;/h2&gt;
&lt;form id="writeForm" action="write_proc<strong>.do</strong>" method="post" enctype="multipart/form-data" onsubmit="return check();"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
&lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="title" style="width: 90%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;&lt;/textarea&gt;
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;첨부 파일&lt;/td&gt;
    &lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="전송" /&gt;
    &lt;input type="button" value="목록" onclick="goList()" /&gt;
    <strong>&lt;c:if test="${not empty param.articleNo }"&gt;</strong>
    &lt;input type="button" value="상세보기" onclick="goView()" /&gt;
    <strong>&lt;/c:if&gt;</strong>
&lt;/div&gt;
&lt;/form&gt;
&lt;/div&gt;
&lt;!-- 본문 끝 --&gt;

        &lt;/div&gt;
    &lt;/div&gt;
    
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

&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="viewForm" action="view<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="listForm" action="list<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;   
&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

write_form.jsp에 액션이 만들어 전달할 데이터는 boardNm(게시판 이름)이다.<br />

<em class="filename">modify_form.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 수정하기 폼" /&gt;
&lt;meta name="Description" content="게시판 수정하기 폼" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("modifyForm");
    //유효성 검사로직 추가
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;<strong>${boardNm }</strong>&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;h2&gt;수정&lt;/h2&gt;
&lt;form id="modifyForm" action="modify_proc<strong>.do</strong>" method="post" enctype="multipart/form-data" onsubmit="return check();"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
&lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
&lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
&lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
&lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="title" style="width: 90%;" value="<strong>${title }</strong>" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;<strong>${content }</strong>&lt;/textarea&gt;
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;첨부 파일&lt;/td&gt;
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

&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="viewForm" action="view<strong>.do</strong>" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="<strong>${param.articleNo }</strong>" /&gt;
        &lt;input type="hidden" name="boardCd" value="<strong>${param.boardCd }</strong>" /&gt;
        &lt;input type="hidden" name="page" value="<strong>${param.page }</strong>" /&gt;
        &lt;input type="hidden" name="searchWord" value="<strong>${param.searchWord }</strong>" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

modify_form.jsp에 액션이 만들어서 전달할 데이터는 다음과 같다.<br />
<br />
boardNm : 게시판 이름<br />
title : 제목<br />
content : 내용<br />
<br />
다음으로 회원 모듈에서의 화면 디자인을 수정한다.<br />
회원 모듈에서의 디자인은 전달해야 할 데이터가 없으므로 수정이 쉽다.<br />
인클루드 지시어에 쓰인 jsp를 제외한 모든 .jsp를 .do로 바꾼다.<br />


<em class="filename">loginUsers-menu.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;h1&gt;회원&lt;/h1&gt;
&lt;ul&gt;
    &lt;li&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="logout_proc<strong>.do</strong>"&gt;로그아웃&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="editAccount<strong>.do</strong>"&gt;내 정보 수정&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="changePasswd<strong>.do</strong>"&gt;비밀번호 변경&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="bye<strong>.do</strong>"&gt;탈퇴&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>

<em class="filename">notLoginUsers-menu.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;h1&gt;회원&lt;/h1&gt;
&lt;ul&gt;
    &lt;li&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="login<strong>.do</strong>"&gt;로그인&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="signUp<strong>.do</strong>"&gt;회원 가입&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;ID(email) 찾기&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;비밀번호 찾기&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>

<em class="filename">login.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="로그인" /&gt;
&lt;meta name="Description" content="로그인" /&gt;
&lt;title&gt;로그인&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("loginForm");
    //TODO 유효성 검사
    return true;
}

//]]&gt;
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;

    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;
&lt;h1&gt;로그인&lt;/h1&gt;
<strong>&lt;c:if test="${not empty param.msg }"&gt;
&lt;p style="color: red;"&gt;로그인에 실패했습니다.&lt;/p&gt;
&lt;/c:if&gt;</strong>      

&lt;form id="loginForm" action="<strong>login_proc.do</strong>" method="post" onsubmit="return check()"&gt;
&lt;p style="margin: 0; padding: 0;"&gt;
&lt;input type="hidden" name="url" value="<strong>${param.url }</strong>" /&gt;
&lt;/p&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td style="width: 200px;"&gt;Email&lt;/td&gt;
    &lt;td style="width: 390px"&gt;&lt;input type="text" name="email" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding: 15px 0;"&gt;
    &lt;input type="submit" value="확인" /&gt;
    &lt;input type="button" value="회원 가입" onclick="location.href='signUp<strong>.do</strong>'" /&gt;
&lt;/div&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="notLoginUsers-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">signUp.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="회원 가입" /&gt;
&lt;meta name="Description" content="회원 가입" /&gt;
&lt;title&gt;회원 가입&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[ 

function check() {
    //var form = document.getElementById("signUpForm");
    //TODO 유효성 검사
    return true;
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;회원 가입&lt;/h1&gt;
&lt;form id="signUpForm" action="signUp_proc<strong>.do</strong>" method="post" onsubmit="return check()"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td style="width: 200px;"&gt;이름(Full Name)&lt;/td&gt;
    &lt;td style="width: 390px"&gt;&lt;input type="text" name="name" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2" style="text-align: center;font-weight: bold;"&gt;
    Email이 아이디로 쓰이므로 비밀번호는 Email 계정 비밀번호와 같게 하지 마세요.
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호 확인(Confirm)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="confirm" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;Email&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="email" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;이동전화(Mobile)&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="mobile" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="확인" /&gt;
&lt;/div&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="notLoginUsers-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">welcome.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="회원 가입 환영" /&gt;
&lt;meta name="Description" content="회원 가입 환영" /&gt;
&lt;title&gt;회원 가입이 완료되었습니다.&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;
&lt;h1&gt;환영합니다.&lt;/h1&gt;
회원 가입시 입력한 Email이 아이디로 사용됩니다.&lt;br /&gt;
&lt;input type="button" value="로그인" onclick="javascript:location.href='login<strong>.do</strong>'" /&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Welcome&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">editAccount.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="내 정보 수정" /&gt;
&lt;meta name="Description" content="내 정보 수정" /&gt;
&lt;title&gt;내 정보 수정&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("editAccountForm");
    //TODO 유효성 검사
    return true;
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
        
&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;
&lt;h1&gt;내 정보 수정&lt;/h1&gt;
&lt;p&gt;
비밀번호외의 자신의 계정 정보를 수정할 수 있습니다.&lt;br /&gt;
비밀번호는 &lt;a href="changePasswd<strong>.do</strong>"&gt;비밀번호 변경&lt;/a&gt;메뉴를 이용하세요.&lt;br /&gt;
&lt;/p&gt;
&lt;form id="editAccountForm" action="editAccount_proc<strong>.do</strong>" method="post" onsubmit="return check()"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;이름(Full Name)&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="name" value="<strong>${user.name }</strong>" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;이동전화(Mobile)&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="mobile" value="<strong>${user.mobile }</strong>" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;현재 비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="전송" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="loginUsers-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">changePasswd.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="비밀번호 변경" /&gt;
&lt;meta name="Description" content="비빌번호 변경" /&gt;
&lt;title&gt;비밀번호 변경&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
           
function check() {
    var form = document.getElementById("changePasswordForm");
    if (form.newPasswd.value == form.confirm.value) {
        return true;    
    } else {
        alert("[변경 비밀번호]와 [변경 비밀번호 확인]값이 같지 않습니다.");
        return false;
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;
&lt;h1&gt;비밀번호 변경&lt;/h1&gt;
<strong>${user.name }</strong>&lt;br /&gt;
<strong>${user.mobile }</strong>&lt;br /&gt;
&lt;form id="changePasswordForm" action="changePasswd_proc<strong>.do</strong>" method="post" onsubmit="return check()"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;현재 비밀번호&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="currentPasswd" /&gt;&lt;/td&gt;   
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;변경 비밀번호&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="newPasswd" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;변경 비밀번호 확인&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="confirm" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="확인" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;

    &lt;div id="sidebar"&gt;
        &lt;%@ include file="loginUsers-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">changePasswd_confirm.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="비밀번호 변경 확인" /&gt;
&lt;meta name="Description" content="비밀번호 변경 확인" /&gt;
&lt;title&gt;비밀번호 변경 확인&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;
&lt;h1&gt;비밀번호가 변경되었습니다.&lt;/h1&gt;
변경된 비밀번호로 다시 로그인하실 수 있습니다.&lt;br /&gt;
&lt;input type="button" value="로그인" onclick="javascript:location.href='login<strong>.do</strong>'" /&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="loginUsers-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">bye.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="탈퇴" /&gt;
&lt;meta name="Description" content="탈퇴" /&gt;
&lt;title&gt;탈퇴&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
           
function check() {
    //var form = document.getElementById("byeForm");
    //유효성 검사
    return true;
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

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;탈퇴&lt;/h1&gt;
&lt;form id="byeForm" action="bye_proc<strong>.do</strong>" method="post" onsubmit="return check()"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;이메일&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="email" /&gt;&lt;/td&gt;   
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" /&gt;&lt;/td&gt;  
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="확인" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;

    &lt;div id="sidebar"&gt;
        &lt;%@ include file="loginUsers-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>에러 페이지 수정</h3>
다양한 에러 페이지를 만드는 것 대신 하나의 에러 페이지로 모든 에러를 처리하기로 했으므로 굳이 JSTL로 수정할 필요가 없다.<br />
기존의 스크립틀릿 코드를 그대로 사용한다.<br />
인클루드 지시어에 쓰인 jsp를 제외한 모든 .jsp를 .do로 수정한다.<br />

<em class="filename">/error.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%
String contextPath = request.getContextPath();
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="Error" /&gt;
&lt;meta name="Description" content="Error" /&gt;
&lt;title&gt;Error&lt;/title&gt;
&lt;link rel="stylesheet" href="&lt;%=contextPath %&gt;/css/screen.css" type="text/css" /&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
//Analyze the servlet exception
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");

if (servletName == null) {
    servletName = "Unknown";
}

String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

if (requestUri == null) {
    requestUri = "Unknown";
}
%&gt;
&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;h1 style="float: left; width: 150px;"&gt;&lt;a href="&lt;%=contextPath %&gt;"&gt;&lt;img src="&lt;%=contextPath %&gt;/images/ci.gif" alt="java-school" /&gt;&lt;/a&gt;&lt;/h1&gt;
        &lt;div id="memberMenu" style="float: right; position: relative; top: 7px;"&gt;
&lt;%
User loginUser = (User) session.getAttribute("user");
if (loginUser == null) {
%&gt;
    &lt;input type="button" value="로그인" onclick="location.href='&lt;%=contextPath %&gt;/users/login<strong>.do</strong>'" /&gt;
    &lt;input type="button" value="회원 가입" onclick="location.href='&lt;%=contextPath %&gt;/users/signUp<strong>.do</strong>'" /&gt;
&lt;%
} else {
%&gt;   
    &lt;input type="button" value="로그아웃" onclick="location.href='&lt;%=contextPath %&gt;/users/logout_proc<strong>.do</strong>'" /&gt;
    &lt;input type="button" value="내 정보 수정" onclick="location.href='&lt;%=contextPath %&gt;/users/editAccount<strong>.do</strong>'" /&gt;
&lt;%
}
%&gt;
        &lt;/div&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;ul id="nav"&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/java/"&gt;Java&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/jdbc/"&gt;JDBC&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/jsp/"&gt;JSP&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/css-layout/"&gt;CSS Layout&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/jsp-project/"&gt;JSP Project&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/spring/"&gt;Spring&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/javascript/"&gt;JavaScript&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="&lt;%=contextPath %&gt;/bbs/list<strong>.do</strong>?boardCd=free&amp;page=1"&gt;BBS&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 820px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;Error&lt;/div&gt;
            
&lt;h1&gt;Error Page&lt;/h1&gt;
&lt;%
if(statusCode != 500){
    out.write("&lt;h3&gt;Error Details&lt;/h3&gt;");
    out.write("&lt;strong&gt;Status Code&lt;/strong&gt;:" + statusCode + "&lt;br&gt;");
    out.write("&lt;strong&gt;Requested URI&lt;/strong&gt;:"+requestUri);
}
if (throwable != null) {
    out.write("&lt;h3&gt;Exception Details&lt;/h3&gt;");
    out.write("&lt;ul&gt;&lt;li&gt;Servlet Name:" + servletName + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Name:" + throwable.getClass().getName() + "&lt;/li&gt;");
    out.write("&lt;li&gt;Requested URI:" + requestUri + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Message:" + throwable.getMessage() + "&lt;/li&gt;");
    out.write("&lt;/ul&gt;");
}
%&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Error&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;a href="http://www.youtube.com"&gt;&lt;img src="&lt;%=contextPath %&gt;/images/youtube.png" alt="youtube.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.twitter.com"&gt;&lt;img src="&lt;%=contextPath %&gt;/images/twitter.png" alt="twitter.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.facebook.com"&gt;&lt;img src="&lt;%=contextPath %&gt;/images/facebook.png" alt="facebook.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.gmail.com"&gt;&lt;img src="&lt;%=contextPath %&gt;/images/gmail.png" alt="gmail.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.java-school.net"&gt;&lt;img src="&lt;%=contextPath %&gt;/images/java-school.png" alt="java-school.net" /&gt;&lt;/a&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="./inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

홈페이지 역시 인클루드 지시어에 쓰인 jsp를 제외한 모든 .jsp를 .do로 바꾼다.<br />

<h3>구현</h3>
MVC 뼈대를 이루는 클래스부터 작성한다.<br />


ActionForward 클래스는 액션 클래스의 execute() 메서드가 반환하는 타입이다.<br />
ActionForward 객체에는 리다이렉트 여부와 이동하게 될 주소 정보만 저장된다.<br />
리다이렉트 여부가 false면 설정된 주소로 포워딩 된다.<br />
포워딩이나 리다이렉트되는 주소는 액션 클래스에서 만들고 ActionForward에 담겨 컨트롤러에 반환된다.<br />

<em class="filename">ActionForward.java</em>
<pre class="prettyprint">package net.java_school.action;

public class ActionForward {
    private boolean isRedirect;
    private String view;
    
    public boolean isRedirect() {
        return isRedirect;
    }
    public void setRedirect(boolean isRedirect) {
        this.isRedirect = isRedirect;
    }
    public String getView() {
        return view;
    }
    public void setView(String view) {
        this.view = view;
    }
    
}
</pre>


Action 인터페이스는 모든 액션 클래스가 구현해야 한다.<br />

<em class="filename">Action.java</em>
<pre class="prettyprint">package net.java_school.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException;
}
</pre>


인증이 실패했을 때 발생시킬 사용자 정의 예외 클래스이다.<br />
런타임 예외를 상속하여 만든다.<br />

<em class="filename">AuthenticationException.java</em>
<pre class="prettyprint">package net.java_school.exception;

public class AuthenticationException extends RuntimeException {

    private static final long serialVersionUID = -2916142666133028059L;

    public AuthenticationException() {
        super();
    }

    public AuthenticationException(String message, Throwable cause,
            boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }

    public AuthenticationException(String message, Throwable cause) {
        super(message, cause);
    }

    public AuthenticationException(String message) {
        super(message);
    }

    public AuthenticationException(Throwable cause) {
        super(cause);
    }
    
}
</pre>


*.do 요청을 처리할 컨트롤러를 만든다.<br />

<em class="filename">Controller.java</em> 
<pre class="prettyprint">package net.java_school.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.exception.AuthenticationException;

public class Controller extends HttpServlet {

    private static final long serialVersionUID = 4024375917229853991L;
    
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req,resp);
    }
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
            
        req.setCharacterEncoding("UTF-8");
        
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String command = uri.substring(contextPath.length());
        
        String view = null;
        Action action = null;
        ActionForward forward = null;
        
        try {
            if (command.equals("/bbs/list.do")) {
                //action = new ListAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/view.do")) {
                //action = new ViewAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/write_form.do")) {
                //action = new WriteFormAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/write_proc.do")) {
                //action = new WriteAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/addComment_proc.do")) {
                //action = new AddCommentAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/updateComment_proc.do")) {
                //action = new UpdateCommentAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/deleteComment_proc.do")) {
                //action = new DeleteCommentAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/deleteAttachFile_proc.do")) {
                //action = new DeleteAttachFileAction();
                forward = action.execute(req, resp);                
            } else if (command.equals("/bbs/modify_form.do")) {
                //action = new ModifyFormAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/modify_proc.do")) {
                //action = new ModifyAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/bbs/del_proc.do")) {
                //action = new DeleteAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/changePasswd.do")) {
                //action = new ChangePasswdFormAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/changePasswd_proc.do")) {
                //action = new ChangePasswdAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/changePasswd_confirm.do")) {
                forward = new ActionForward(); //단순 포워딩
                forward.setView("/users/changePasswd_confirm.jsp");             
            } else if (command.equals("/users/signUp.do")) {
                forward = new ActionForward(); //단순 포워딩
                forward.setView("/users/signUp.jsp");
            } else if (command.equals("/users/signUp_proc.do")) {
                //action = new SignUpAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/welcome.do")) {
                forward = new ActionForward(); //단순 포워딩
                forward.setView("/users/welcome.jsp");              
            } else if (command.equals("/users/editAccount.do")) {
                //action = new EditAccountFormAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/editAccount_proc.do")) {
                //action = new EditAccountAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/bye.do")) {
                //action = new ByeFormAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/bye_proc.do")) {
                //action = new ByeAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/login.do")) {
                forward = new ActionForward();//단순 포워딩
                forward.setView("/users/login.jsp");
            } else if (command.equals("/users/login_proc.do")) {
                //action = new LoginAction();
                forward = action.execute(req, resp);
            } else if (command.equals("/users/logout_proc.do")) {
                //action = new LogoutAction();
                forward = action.execute(req, resp);
            }
            
            view = forward.getView();
            
            if (forward.isRedirect() == false) {
                RequestDispatcher rd = this.getServletContext().getRequestDispatcher(view);
                rd.forward(req, resp);
            } else {
                resp.sendRedirect(view);
            }
        } catch (AuthenticationException e) {
            //컨트롤러에 인증 실패 예외가 전달되면, 컨트롤러는 에러 메시지를 컨테이너에 전달한다.
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, e.getMessage());
        }
        
    }
    
}
</pre>


컨트롤러 서블릿을 web.xml에 선언하고 URL 매핑한다.<br />


<em class="filename">web.xml</em>
<pre class="prettyprint">&lt;servlet&gt;
   &lt;servlet-name&gt;controller&lt;/servlet-name&gt;
   &lt;servlet-class&gt;net.java_school.controller.Controller&lt;/servlet-class&gt;
   &lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
   &lt;servlet-name&gt;controller&lt;/servlet-name&gt;
   &lt;url-pattern&gt;*.do&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>


웹 애플리케이션에서 공통으로 사용할 상수를 추가한다.<br />

<em class="filename">WebContants.java</em>
<pre class="prettyprint">package net.java_school.commons;

public class WebContants {
    //Session key
    public final static String USER_KEY = "user";
    //Error Message
    public final static String NOT_LOGIN = "Not Login";
    public final static String AUTHENTICATION_FAILED = "Authentication Failed";
    //Line Separator
    <strong>public final static String LINE_SEPARATOR = System.getProperty("line.separator");</strong>
    
}
</pre>



게시판은 로그인 사용자만 이용할 수 있다고 했다.<br />
따라서 로그인을 구현하는 것이 순서에 맞다.<br />  
기존 login_proc.jsp의 구현 내용을 참조하여 로그인을 처리하는 액션 클래스를 만든다.<br />
이 클래스는 login_proc.do란 요청이 왔을 때 작동한다.<br />
로그인이 실패하면 로그인 페이지로 되돌아간다.<br />

<em class="filename">LoginAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.commons.WebContants;
import net.java_school.user.User;
import net.java_school.user.UserService;

public class LoginAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {
        
        String url = req.getParameter("url");
        
        String email = req.getParameter("email");
        String passwd = req.getParameter("passwd");

        UserService service = new UserService();
        User user = service.login(email, passwd);

        ActionForward forward = new ActionForward();
         
        String contextPath = req.getContextPath();
        
        if (user == null) {
            forward.setView(contextPath + "/users/login.do?url=" + url +"&amp;msg=Login-Failed");
            forward.setRedirect(true);
        } else {
            HttpSession session = req.getSession();
            session.setAttribute(WebContants.USER_KEY, user);
            if (url != null &amp;&amp; !url.equals("")) {
                forward.setView(url);
                forward.setRedirect(true);
            } else {
                forward.setView(contextPath + "/bbs/list.do?boardCd=free&amp;page=1");
                forward.setRedirect(true);
            }
        }
        
        return forward;
    }

}
</pre>

로그인 화면으로 리다이렉트하는 코드에서 컨텍스트 패스를 구한 이유는
디렉터리의 깊이가 다른 어떤 URL에서라도 로그인이 작동하도록 하기 위해서다.<br />
<br />
리다이렉트를 위한 주소와 포워딩을 위한 주소는 달리 구해야 한다.<br /> 
포워딩을 위한 주소는 컨텍스트 패스 다음에 컨텍스트 패스를 제외한 /부터 시작하는 주소를 사용한다.<br />
리다이렉트의 경우 리다이렉트 URL를 보내는 페이지의 위치를 기준으로 상대 경로를 구하거나 
컨텍스트 패스를 포함하는 주소를 사용한다.<br />
리다이렉트 시 포워딩하기 위한 URL를 그대로 사용하면 어떤 문제가 생기는지 알아보자.<br />
예를 들어 /bbs/list.do를 리다이렉트하면 톰캣은 bbs라는 웹 애플리케이션을 찾게 될 것이다.<br />
   

로그아웃하면 홈페이지로 이동한다.

<em class="filename">LogoutAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.commons.WebContants;

public class LogoutAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {
            
        ActionForward forward = new ActionForward();
                
        HttpSession session = req.getSession();
        session.removeAttribute(WebContants.USER_KEY);

        String contextPath = req.getContextPath();
        forward.setView(contextPath);
        forward.setRedirect(true);

        return forward;
    }

}
</pre>



SignUpAction 액션 클래스는 회원 가입을 처리한다.<br />
회원 가입이 완료되면 환영 페이지로 리다이렉트한다.<br />
모델 1에서 signUp_proc.jsp의 구현 내용을 참조한다.<br />

<em class="filename">SignUpAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.user.User;
import net.java_school.user.UserService;

public class SignUpAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();

        //email,passwd,name,mobile 파라미터 전달
        String email = req.getParameter("email");
        String passwd = req.getParameter("passwd");
        String name = req.getParameter("name");
        String mobile = req.getParameter("mobile");

        User user = new User(email, passwd, name, mobile);

        UserService service = new UserService();
        service.addUser(user);

        forward.setView("welcome.do");
        forward.setRedirect(true);

        return forward;
    }

}
</pre>



EditAccountFormAction 액션 클래스는 내 정보 수정 버튼을 클릭하여 /users/editAccount.do
요청이 컨트롤러에 전달되면 작동한다.<br />
로그인되어 있지 않으면 로그인 페이지로 이동한다.<br />
이때 로그인 후 되돌아올 수 있도록 요청을 전달한다.<br />
이 부분은 모델 1의 loginCheck.jsp 파일을 참조한다.<br />

<em class="filename">EditAccountFormAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.commons.WebContants;
import net.java_school.user.User;

public class EditAccountFormAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        //loginCheck.jsp와 같은 로직
        if (user == null) {
            String url = req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            url = URLEncoder.encode(url, "UTF-8");
            String contextPath = req.getContextPath();
            forward.setRedirect(true);
            forward.setView(contextPath + "/users/login.do?url=" + url);

            return forward;
        }

        forward.setView("/users/editAccount.jsp");

        return forward;
    }

}
</pre>



EditAccountAction 액션 클래스는 /users/editAccount_proc.do 요청에 대해 작동하여
회원정보 수정을 처리한다.<br />

<em class="filename">EditAccountAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;
import net.java_school.user.UserService;

public class EditAccountAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {
            
        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        //name, mobile, passwd 파라미터 전달
        String name = req.getParameter("name");
        String mobile = req.getParameter("mobile");
        String passwd = req.getParameter("passwd");
        
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }
        
        String email = user.getEmail();
        
        UserService service = new UserService();
        
        //user.setEmail(email);
        user.setPasswd(passwd);
        user.setName(name);
        user.setMobile(mobile);
        
        int check = service.editAccount(user);
        
        if (check &gt; 0) {
            session.setAttribute(WebContants.USER_KEY, user);
            forward.setView("changePasswd.do");
            forward.setRedirect(true);
        } else {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        return forward;
    }

}
</pre>



ChangePasswdFormAction 액션 클래스는 /users/changePasswd.do 요청에 작동한다.<br />

<em class="filename">ChangePasswdFormAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.commons.WebContants;
import net.java_school.user.User;

public class ChangePasswdFormAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {
        
        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            String url = req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            url = URLEncoder.encode(url, "UTF-8");
            String contextPath = req.getContextPath();
            forward.setView(contextPath + "/users/login.do?url=" + url);
            forward.setRedirect(true);
            
            return forward;
        }

        forward.setView("/users/changePasswd.jsp");
        
        return forward;
    }
}
</pre>



ChangePasswdAction 액션 클래스는 /users/changePasswd_proc.do 요청에 작동하여 
비밀번호 변경을 처리한다.<br />

<em class="filename">ChangePasswdAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;
import net.java_school.user.UserService;

public class ChangePasswdAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req,
    		HttpServletResponse resp) throws IOException {
       
        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }

        //currentPasswd(현재 비밀번호),newPasswd(변경 비밀번호)
        String currentPasswd = req.getParameter("currentPasswd");
        String newPasswd = req.getParameter("newPasswd");
        String email = user.getEmail();

        UserService service = new UserService();
        int check = service.changePasswd(currentPasswd, newPasswd, email);
                
        if (check &lt; 1) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        forward.setView("changePasswd_confirm.do");
        forward.setRedirect(true);
        
        return forward;
    }
}
</pre>



ByeFormAction 액션 클래스는 /users/bye.do 요청에 작동한다.<br />

<em class="filename">ByeFormAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.user.User;

public class ByeFormAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            String url = req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            url = URLEncoder.encode(url, "UTF-8");
            String contextPath = req.getContextPath();
            forward.setView(contextPath + "/users/login.do?url=" + url);
            forward.setRedirect(true);
 
            return forward;
        }

        forward.setView("/users/bye.jsp");
        
        return forward;
    }

}
</pre>



ByeAction 액션 클래스는 /users/bye_proc.do 요청에 작동하여 회원 탈퇴를 처리한다.<br />

<em class="filename">ByeAction.java</em>
<pre class="prettyprint">package net.java_school.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;
import net.java_school.user.UserService;

public class ByeAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN); 
        }

        String email = req.getParameter("email");
        String passwd = req.getParameter("passwd");

        UserService service = new UserService();

        service.bye(email, passwd);
        session.removeAttribute(WebContants.USER_KEY);

        forward.setView("/users/bye_confirm.jsp");
        
        return forward;
    }

}

</pre>



ListAction 액션 클래스는 /bbs/list.do 요청에 작동한다.<br />
목록 화면을 디자인할 때 화면에 전달된다고 가정했던 데이터를 
이 액션 객체가 만들고 목록 화면에 전달해야 한다.<br />

<em class="filename">ListAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.Article;
import net.java_school.board.BoardService;
import net.java_school.commons.PagingHelper;
import net.java_school.commons.WebContants;
import net.java_school.user.User;

public class ListAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            String url = req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            url = URLEncoder.encode(url, "UTF-8");
            String contextPath = req.getContextPath();
            forward.setView(contextPath + "/users/login.do?url=" + url);
            forward.setRedirect(true);
            
            return forward;
        }
        
        String boardCd = req.getParameter("boardCd");
        int page = Integer.parseInt(req.getParameter("page"));
        String searchWord = req.getParameter("searchWord");
        
        BoardService service = new BoardService();
        
        int totalRecord = service.getTotalRecord(boardCd, searchWord);
        int numPerPage = 10;
        int pagePerBlock = 10;
        PagingHelper pagingHelper = 
        	new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
        
        service.setPagingHelper(pagingHelper);
        
        List&lt;Article&gt; list = service.getArticleList(boardCd, searchWord);
        int listItemNo = service.getListItemNo();
        int prevPage = service.getPrevPage();
        int firstPage = service.getFirstPage();
        int lastPage = service.getLastPage();
        int nextPage = service.getNextPage();
        String boardNm = service.getBoardNm(boardCd);
        
        req.setAttribute("list", list);
        req.setAttribute("listItemNo", listItemNo);
        req.setAttribute("prevPage", prevPage);
        req.setAttribute("firstPage", firstPage);
        req.setAttribute("lastPage", lastPage);
        req.setAttribute("nextPage", nextPage);
        req.setAttribute("boardNm", boardNm);
        
        forward.setView("/bbs/list.jsp");
        
        return forward;
        
    }
}
</pre>



ViewAction 액션 클래스는 /bbs/view.do 요청에 작동한다.<br />
상세보기 페이지에서 필요한 데이터를 만들고 전달한다.<br />

<em class="filename">ViewAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
import net.java_school.commons.PagingHelper;
import net.java_school.commons.WebContants;
import net.java_school.user.User;

public class ViewAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            String url = req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            url = URLEncoder.encode(url, "UTF-8");
            String contextPath = req.getContextPath();
            forward.setView(contextPath + "/users/login.do?url=" + url);
            forward.setRedirect(true);
                        
            return forward;
        }

        int articleNo = Integer.parseInt(req.getParameter("articleNo"));
        String boardCd = req.getParameter("boardCd");
        int page = Integer.parseInt(req.getParameter("page"));
        String searchWord = req.getParameter("searchWord");

        BoardService service = new BoardService();
        
        int totalRecord = service.getTotalRecord(boardCd, searchWord);
        int numPerPage = 10;
        int pagePerBlock = 10;
        PagingHelper pagingHelper = 
        	new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
        serivce.setPagingHelper(pagingHelper);
                
        service.increaseHit(articleNo);

        Article article = service.getArticle(articleNo);//상세보기 게시글
        List&lt;AttachFile&gt; attachFileList = service.getAttachFileList(articleNo);//첨부 파일 리스트
        Article nextArticle = service.getNextArticle(articleNo, boardCd, searchWord);//다음 글
        Article prevArticle = service.getPrevArticle(articleNo, boardCd, searchWord);//이전 클
        List&lt;Article&gt; list = service.getArticleList(boardCd, searchWord);//목록
        List&lt;Comment&gt; commentList = service.getCommentList(articleNo);//댓글 리스트
        String boardNm = service.getBoardNm(boardCd);

        //상세보기 게시글
        String title = article.getTitle();//제목
        String content = article.getContent();//내용
        content = content.replaceAll(WebContants.LINE_SEPARATOR, "&lt;br /&gt;");
        int hit = article.getHit();//조회 수
        String name = article.getName();//작성자 이름
        String email = article.getEmail();//작성자 ID
        Date regdate = article.getRegdate();//작성일
        String contextPath = req.getContextPath();
        String uploadPath = contextPath + "/upload/";//첨부 파일 경로
        
        int listItemNo = service.getListItemNo();
        int prevPage = service.getPrevPage();
        int firstPage = service.getFirstPage();
        int lastPage = service.getLastPage();
        int nextPage = service.getNextPage();
        
        req.setAttribute("title", title);
        req.setAttribute("content", content);
        req.setAttribute("hit", hit);
        req.setAttribute("name", name);
        req.setAttribute("email", email);
        req.setAttribute("regdate", regdate);
        req.setAttribute("uploadPath", uploadPath);
        req.setAttribute("attachFileList", attachFileList);
        req.setAttribute("nextArticle", nextArticle);
        req.setAttribute("prevArticle", prevArticle);
        req.setAttribute("commentList", commentList);
        
        req.setAttribute("list", list);
        req.setAttribute("listItemNo", listItemNo);
        req.setAttribute("prevPage", prevPage);
        req.setAttribute("firstPage", firstPage);
        req.setAttribute("lastPage", lastPage);
        req.setAttribute("nextPage", nextPage);
        req.setAttribute("boardNm", boardNm);
        
        forward.setView("/bbs/view.jsp");
        
        return forward;
    }
}
</pre>



WriteFormAction 액션 클래스는 /bbs/write_form.do 요청에 작동한다.<br />

<em class="filename">WriteFormAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.BoardService;
import net.java_school.user.User;

public class WriteFormAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            String url = req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            url = URLEncoder.encode(url, "UTF-8");
            String contextPath = req.getContextPath();
            forward.setView(contextPath + "/users/login.do?url=" + url);
            forward.setRedirect(true);
            
            return forward;
        }

        String boardCd = req.getParameter("boardCd");

        BoardService service = new BoardService();
        String boardNm = service.getBoardNm(boardCd);
        
        req.setAttribute("boardNm", boardNm);
        
        forward.setView("/bbs/write_form.jsp");
        
        return forward;
    }
}
</pre>



WriteAction 액션 클래스는 /bbs/write_proc.do 요청에 작동하여 글쓰기를 처리한다.<br />

<em class="filename">WriteAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.BoardService;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class WriteAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }
        
        ServletContext servletContext = req.getServletContext();
        String dir = servletContext.getRealPath("/upload");

        MultipartRequest multi = new MultipartRequest(
                req,
                dir,
                5*1024*1024,
                "UTF-8",
                new DefaultFileRenamePolicy());

        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String filename = multi.getFilesystemName("attachFile");
        String filetype = multi.getContentType("attachFile");

        File f = multi.getFile("attachFile");
        long filesize = 0L;
        AttachFile attachFile = null;

        if (f != null) {
            filesize = f.length();
            attachFile = new AttachFile();
            attachFile.setFilename(filename);
            attachFile.setFiletype(filetype);
            attachFile.setFilesize(filesize);
            attachFile.setEmail(user.getEmail());
        }

        String boardCd = multi.getParameter("boardCd");

        Article article = new Article();
        article.setEmail(user.getEmail());
        article.setTitle(title);
        article.setContent(content);
        article.setBoardCd(boardCd);

        BoardService service = new BoardService();
        service.addArticle(article, attachFile);
        
        forward.setView("list.do?boardCd=" + boardCd + "&amp;page=1");
        forward.setRedirect(true);
        
        return forward;
    }
}
</pre>



ModifyFormAction 액션 클래스는 /bbs/modify_form.do 요청에 작동한다.<br />

<em class="filename">ModifyFormAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.Article;
import net.java_school.board.BoardService;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class ModifyFormAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        int articleNo = Integer.parseInt(req.getParameter("articleNo"));
        String boardCd = req.getParameter("boardCd");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        BoardService service = new BoardService();
        Article article = service.getArticle(articleNo);

        if (user == null || !user.getEmail().equals(article.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }

        String title = article.getTitle();
        String content = article.getContent();
        String boardNm = service.getBoardNm(boardCd);

        req.setAttribute("title", title);
        req.setAttribute("content", content);
        req.setAttribute("boardNm", boardNm);
        
        forward.setView("/bbs/modify_form.jsp");
        
        return forward;
    }
}
</pre>



ModifyAction 액션 클래스는 /bbs/modify_proc.do 요청에 작동하여 글 수정을 처리한다.<br />

<em class="filename">ModifyAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.BoardService;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class ModifyAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        ServletContext servletContext = req.getServletContext();
        String dir = servletContext.getRealPath("/upload");

        MultipartRequest multi = new MultipartRequest(
                req,
                dir,
                5*1024*1024,
                "UTF-8",
                new DefaultFileRenamePolicy());

        BoardService service = new BoardService();
        int articleNo = Integer.parseInt(multi.getParameter("articleNo"));

        if (!service.getArticle(articleNo).getEmail().equals(user.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }

        String boardCd = multi.getParameter("boardCd");
        int page = Integer.parseInt(multi.getParameter("page"));
        String searchWord = multi.getParameter("searchWord");
        searchWord = java.net.URLEncoder.encode(searchWord, "UTF-8");

        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String filename = multi.getFilesystemName("attachFile");
        String filetype = multi.getContentType("attachFile");

        File f = multi.getFile("attachFile");
        long filesize = 0L;
        AttachFile attachFile = null;

        if (f != null) {
            filesize = f.length();
            attachFile = new AttachFile();
            attachFile.setFilename(filename);
            attachFile.setFiletype(filetype);
            attachFile.setFilesize(filesize);
            attachFile.setEmail(user.getEmail());
            attachFile.setArticleNo(articleNo);
        }

        Article article = new Article();
        article.setArticleNo(articleNo);
        article.setBoardCd(boardCd);
        article.setTitle(title);
        article.setContent(content);
        article.setEmail(user.getEmail());

        service.modifyArticle(article, attachFile);

        forward.setView("view.do?articleNo="+ articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);
        forward.setRedirect(true);
        
        return forward;
    }
}
</pre>



DeleteAction 액션 클래스는 /bbs/del_proc.do 요청에 작동하여 게시글 삭제를 처리한다.<br />

<em class="filename">DeleteAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.Article;
import net.java_school.board.BoardService;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class DeleteAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        int articleNo = Integer.parseInt(req.getParameter("articleNo"));

        BoardService service = new BoardService();
        Article article = service.getArticle(articleNo);
        
        if (user == null || !user.getEmail().equals(article.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }

        service.removeArticle(articleNo);

        String boardCd = req.getParameter("boardCd");
        String page = req.getParameter("page");
        String searchWord = req.getParameter("searchWord");

        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        
        forward.setView("list.do?boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);
        forward.setRedirect(true);
        
        return forward;
    }
}
</pre>



AddCommentAction 액션 클래스는 /bbs/addComment_proc.do 요청에 작동하여 댓글 쓰기를 처리한다.<br />

<em class="filename">AddCommentAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class AddCommentAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }

        int articleNo = Integer.parseInt(req.getParameter("articleNo"));
        String boardCd = req.getParameter("boardCd");
        int page = Integer.parseInt(req.getParameter("page"));
        String searchWord = req.getParameter("searchWord");
        String memo = req.getParameter("memo");

        Comment comment = new Comment();
        comment.setArticleNo(articleNo);
        comment.setEmail(user.getEmail());
        comment.setMemo(memo);

        BoardService service = new BoardService();
        service.addComment(comment);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        forward.setView("view.do?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);
        forward.setRedirect(true);
        
        return forward;
    }
}
</pre>



UpdateCommentAction 액션 클래스는 /bbs/updateComment_proc.do 요청에 작동하여 댓글 수정을 처리한다.<br />

<em class="filename">UpdateCommentAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class UpdateCommentAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        int commentNo = Integer.parseInt(req.getParameter("commentNo"));

        BoardService service = new BoardService();
        Comment comment = service.getComment(commentNo);
        
        if (user == null || !user.getEmail().equals(comment.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }

        int articleNo = Integer.parseInt(req.getParameter("articleNo"));
        String boardCd = req.getParameter("boardCd");
        int page = Integer.parseInt(req.getParameter("page"));
        String searchWord = req.getParameter("searchWord");

        String memo = req.getParameter("memo");

        comment.setCommentNo(commentNo);
        comment.setArticleNo(articleNo);
        comment.setEmail(user.getEmail());
        comment.setMemo(memo);

        service.modifyComment(comment);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        
        forward.setView("view.do?articleNo="+ articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);
        forward.setRedirect(true);
        
        return forward;
    }

}
</pre>



DeleteCommentAction 액션 클래스는 /bbs/deleteComment_proc.do 요청에 작동하여 댓글 삭제를 처리한다.<br />

<em class="filename">DeleteCommentAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class DeleteCommentAction implements Action {
    
    @Override
    public ActionForward execute(HttpServletRequest req, 
        HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
                
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        int commentNo = Integer.parseInt(req.getParameter("commentNo"));

        BoardService service = new BoardService();
        Comment comment = service.getComment(commentNo);
        if (user == null || !user.getEmail().equals(comment.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }

        int articleNo = Integer.parseInt(req.getParameter("articleNo"));
        String boardCd = req.getParameter("boardCd");
        int page = Integer.parseInt(req.getParameter("page"));
        String searchWord = req.getParameter("searchWord");

        service.removeComment(commentNo);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        forward.setView("view.do?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);
        forward.setRedirect(true);
        
        return forward;
    }
}
</pre>



DeleteAttachFileAction 액션 클래스는 /bbs/deleteAttachFile_proc.do 요청에 작동하여 첨부 파일 삭제를 처리한다.<br />

<em class="filename">DeleteAttachFileAction.java</em>
<pre class="prettyprint">package net.java_school.board.action;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.java_school.action.Action;
import net.java_school.action.ActionForward;
import net.java_school.board.AttachFile;
import net.java_school.board.BoardService;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

public class DeleteAttachFileAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        ActionForward forward = new ActionForward();
        
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(WebContants.USER_KEY);

        int attachFileNo = Integer.parseInt(req.getParameter("attachFileNo"));

        BoardService service = new BoardService();
        AttachFile attachFile = service.getAttachFile(attachFileNo);
        
        if (user == null || !user.getEmail().equals(attachFile.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }

        int articleNo = Integer.parseInt(req.getParameter("articleNo"));
        String boardCd = req.getParameter("boardCd");
        int page = Integer.parseInt(req.getParameter("page"));
        String searchWord = req.getParameter("searchWord");

        service.removeAttachFile(attachFileNo);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        
        forward.setView("view.do?articleNo=" + articleNo + "&amp;boardCd=" + boardCd + "&amp;page=" + page + "&amp;searchWord=" + searchWord);
        forward.setRedirect(true);
        
        return forward;
    }

}
</pre>

<h3>모델 2 개발 방식</h3>

<ul>
	<li>모델 뷰 컨트롤러로 구성된다.</li>
	<li>모든 요청은 컨트롤러로 전달된다.</li>
	<li>컨트롤러는 모델에 작업을 위임한다.</li>
	<li>모델은 비즈니스 로직을 수행하고 결과 데이터를 뷰에 전달한다.</li>
</ul>

뷰는 우리의 프로젝트에서 JSP이다.<br />
모델은 위에서 액션 클래스이며 비즈니스 로직을 담당한다.<br />
비즈니스 로직이란 업무에 필요한 데이터를 처리하는 로직이다.<br />
비즈니스 로직을 뷰에서 보일 데이터를 생산하는 로직이라 생각해도 된다.<br />
비즈니스 로직은 뷰에서 떼어 내어 모델에 구현해야 한다.<br />
뷰에 비즈니스 로직이 있다면 좋은 코드가 아니다.<br />
