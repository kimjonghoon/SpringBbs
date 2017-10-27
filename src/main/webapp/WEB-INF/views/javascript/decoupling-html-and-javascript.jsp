<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page isELIgnored="true" %>
<div id="last-modified">Last Modified : 2015.4.15</div>

<h1>HTML과 자바스크립트의 분리</h1>

<h2>DOM 실습을 위한 준비 작업</h2>

<a href="https://goo.gl/QlhGyG">https://goo.gl/QlhGyG</a>에 링크한 파일 design.war은 게시판 프로젝트의 war 파일이다. 
서버 측을 구현하지 않은 프로토타입 파일이다.
다운로드한 후 톰캣의 webapps에 복사하여 톰캣이 자동으로 서비스하도록 한다.
(시스템에 따라서 다운로드한 파일의 확장자가 zip로 바뀌는 경우가 있다. 그럼 다시 war로 바꿔야 한다)
http://localhost:port/design을 방문한다. 
상단의 로그인 버튼을 이용하여 로그인하고 게시판 목록, 상세보기를 차례로 방문하여 테스트한다.<br />
<br />
이클립스에서 작업하기 위해서 다음 과정을 따라 한다.<br />
이클립스를 실행하고 워크스페이스를 TOMCAT_HOME/webapps로 선택한다.<br />

<img src="https://lh3.googleusercontent.com/-WI-FtnEcZSk/VYZKtKbFDeI/AAAAAAAACi0/lq2dYQf8DZI/s588/Select-a-workspace.png" alt="1. 워크스페이스를 TOMCAT_HOME/webapps로 선택한다." /><br />

Java Project를 선택하여 새로운 프로젝트를 만든다.<br />
<img src="https://lh3.googleusercontent.com/-IC6xqzvWyXU/VYZKsPH-ttI/AAAAAAAACic/4ygz5BZ8yXg/s499/Create-a-Java-project.png" alt="2. Java Project를 선택하여 새로운 프로젝트를 만든다." /><br />

프로젝트 이름을 design으로 정한다.<br />
<img src="https://lh3.googleusercontent.com/-b1YE6vhJJE4/VYZKtLvFNNI/AAAAAAAACi4/EynjrfoR5bU/s655/Project-name_design.png" alt="3. 프로젝트 이름을 design로 정한다." /><br />

이클립스의 코드 어시스트 기능을 지원받기 위해서 서블릿 API를 빌드 패스에 추가한다.<br />
패키지 익스플로러 뷰에서 프로젝트를 선택하고, 마우스 오른쪽 버튼을 클릭하여 빌드 패스 설정 메뉴를 선택한다.<br />
<img src="https://lh3.googleusercontent.com/-k14jzyz20uA/VYZKsGWaWqI/AAAAAAAACig/jq85iLCAhoE/s624/Configure-Build-Path.png" alt="5. 팩키지 익스플로러 뷰에서 프로젝트를 선택하고 마우스 오른쪽 버튼을 클릭하여 빌드 패스 설정 메뉴를 선택한다." /><br />

TOMCAT_HOME/lib에서 서블릿 API를 찾아 빌드 패스에 추가한다.<br />
<img src="https://lh3.googleusercontent.com/-ulQwB9E-82s/VYZKs4lpGyI/AAAAAAAACi8/5NRl8qysxFU/s769/JAR-Selection-servlet-api.png" alt="6. TOMCAT_HOME/lib에서 서블릿 API를 찾는다." /><br />
<img src="https://lh3.googleusercontent.com/-vA9eVeU--PE/VYZKsGDaTWI/AAAAAAAACik/sa9tkP7ijGA/s660/JAR-Selection-servlet-api-confirm.png" alt="7. servlet-api.jar를 빌드패스에 추가한다." /><br />

마지막으로 src 폴더와 output 폴더의 위치를 확인한다.<br />
<img src="https://lh3.googleusercontent.com/-JKR-bizd2nc/VYZKuojLW9I/AAAAAAAACjE/hxImyJBSvRA/s663/src-bin.png" alt="8. 마지막으로 소스 폴더와 Output 폴더를 확인한다." /><br />

<h3>design.war 파일에 대한 설명</h3>
여기서 설명하려는 내용과는 상관없지만 기존 게시판과 달라진 내용은 다음과 같다.<br />
<ol>
	<li>JSP 디자인은 JSTL를 적용함.</li>
	<li>자바 소스 파일의 위치는 /WEB-INF/src</li>
	<li>User.java에서 ID에 해당하는 username 필드 추가<br />
	<li>Article.java의 내용 변경됨.<br />
	<li>ArticleAddInfo.java는 게시글(Article.java)에 댓글 수, 첨부파일 수, 조회 수 정보를 추가한 클래스임.</li>
	<li>list.jsp(목록)와 view.jsp(게시글 상세보기)에 테스트 코드가 위 설명대로 구현되어 있음.<br /> 
	<li>테스트 코드가 있으므로 데이터베이스 없이도 실습이 가능함.</li>
</ol>

이제부터 상세보기 화면(view.jsp 파일)에서 디자인과 자바스크립트 코드를 분리할 것이다.<br />

<h2>다운로드/파일삭제 링크에서 스크립트 분리</h2>

첨부파일 링크와 첨부 파일 삭제 링크에 대한 자바스크립트 코드를 외부 파일에 구현할 것이다.<br />
내용이 없는 자바스크립트 파일 bbs-view.js를 view.jsp 파일이 있는 곳에 만든다.<br />
아래 그림에서 test.txt가 다운로드 링크이고 바로 옆의 x가 삭제 링크다.<br />

<img alt="파일 링크와 삭제 링크" src="https://lh3.googleusercontent.com/-BrUcvQHS2zo/Uqgsyt28r9I/AAAAAAAABfM/fREG_9-4sUw/s576/files.png" /><br />

view.jsp 파일에서 script 태그 전체를 제거하고,   
아래처럼 bbs-view.js를 view.jsp에 임포트한다.<br />

<pre class="prettyprint">
&lt;script type="text/javascript" src="bbs-view.js"&gt;&lt;/script&gt;
</pre>

view.jsp 파일에서 첨부파일 링크와 첨부 파일 삭제 링크에 관한 코드를 아래처럼 바꾼다.<br />

<pre class="prettyprint">
&lt;div id="gul-content"&gt;
  &lt;span id="date-writer-hit"&gt;edited ${articleAddInfo.article.regDateForView } 
  	by ${articleAddInfo.article.name } 
  	hit ${articleAddInfo.hit }&lt;/span&gt;
  &lt;p&gt;${articleAddInfo.article.htmlContent }&lt;/p&gt;
  &lt;p id="file-list" style="text-align: right;"&gt;
    &lt;c:forEach var="file" items="${attachFileList }"&gt;
      <strong>&lt;a href="#" title="${file.attachFileNo }" class="download"&gt;${file.filename }&lt;/a&gt;</strong>
      &lt;c:if test="${user.username == articleAddInfo.article.username }"&gt;
      <strong>&lt;a href="#" title="${file.attachFileNo }"&gt;x&lt;/a&gt;</strong>
      &lt;/c:if&gt;
      &lt;br /&gt;
    &lt;/c:forEach&gt;
  &lt;/p&gt;		
&lt;/div&gt;
</pre>

bbs-view.js에 아래 코드를 입력한다.<br />

<pre class="prettyprint">
window.onload = initPage;

function initPage() {
  //첨부파일 다운로드, 첨부파일 삭제
  var file_list = document.getElementById("file-list");
  var fileLinks = file_list.getElementsByTagName("a");
  for (var i = 0; i &lt; fileLinks.length; i++) {
    var fileLink = fileLinks[i];
    if (fileLink.className == "download") {
      fileLink.onclick = function() {
        var attachFileNo = this.title;
        var form = document.getElementById("downloadForm");
        form.attachFileNo.value = attachFileNo;
        form.submit();
        return false;
      };
    } else {
      fileLink.onclick = function() {
        var attachFileNo = this.title;
        var chk = confirm("정말로 삭제하시겠습니까?");
        if (chk == true) {
          var form = document.getElementById("deleteAttachFileForm");
          form.attachFileNo.value = attachFileNo;
          form.submit();
          return false;
        }
      };
    }
  }

  //TODO 진행하면서 이곳에 차례대로 코드를 추가할 것이다.
	
}//initPage 함수끝
</pre>

<h3>테스트</h3>
테스트는 첨부파일 다운로드와 첨부 파일 삭제를 해본다.<br />
첨부파일 삭제는 로그인 후에 테스트할 수 있다.<br />
실제 첨부파일은 삭제되지 않는다.<br />
대신 첨부파일 삭제를 처리하는 페이지로 이동하면 테스트는 성공이다.<br />
참고로, 리눅스 시스템에서는 js 파일의 인코딩이 UTF-8 이 아니면 한글이 깨진다.<br />
그 외 기능은 이제 작동하지 않는다.<br />


<h2>댓글(수정|삭제, 수정하기|취소)링크에서 스크립트 분리</h2>

이번 실습은 댓글 관련 디자인에서 자바스크립트를 분리하는 것이다.<br />
아래 그림을 참고한다.<br />

<img alt="댓글 반복" src="https://lh3.googleusercontent.com/-z6NH0AKuzUE/VYZNET51rsI/AAAAAAAACjQ/5na_oCNNDy0/s722/comments.png" width="590px" /><br />

view.jsp에서 댓글 관련 디자인을 아래 강조된 부분을 참고하여 고친다.<br />

<pre class="prettyprint">
&lt;!--  댓글 반복 시작 --&gt;
&lt;c:forEach var="comment" items="${commentList }"&gt;
&lt;div class="comments"&gt;
  &lt;span class="writer"&gt;${comment.name }&lt;/span&gt;
  &lt;span class="date"&gt;${comment.regdate }&lt;/span&gt;
  &lt;c:if test="${user.username == comment.username }" &gt;
  &lt;span class="modify-del"&gt;
    <strong>&lt;a href="#"&gt;수정&lt;/a&gt; | &lt;a href="#" title="${comment.commentNo }"&gt;삭제&lt;/a&gt;</strong>
  &lt;/span&gt;
  &lt;/c:if&gt;
  &lt;p&gt;${comment.htmlMemo }&lt;/p&gt;
  &lt;form class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none"&gt;
    &lt;p&gt;
      &lt;input type="hidden" name="commentNo" value="${comment.commentNo }" /&gt;
      &lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
      &lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
      &lt;input type="hidden" name="page" value="${param.page }" /&gt;
      &lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
    &lt;/p&gt;
    &lt;div style="text-align: right;"&gt;
      <strong>&lt;a href="#"&gt;수정하기&lt;/a&gt; | &lt;a href="#"&gt;취소&lt;/a&gt;</strong>
    &lt;/div&gt;
    &lt;div&gt;
      &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;${comment.memo }&lt;/textarea&gt;
    &lt;/div&gt;
  &lt;/form&gt;
&lt;/div&gt;
&lt;/c:forEach&gt;
&lt;!--  댓글 반복 끝 --&gt;
</pre>

bbs-view.js 파일에 다음 함수를 추가한다.<br />

<pre class="prettyprint">
function commentUpdate(e) {
  var me = getActivatedObject(e);
  var form = me.parentNode;
  while (form.className != "modify-comment") {
    form = form.parentNode;
  }
  form.submit();
  return false;
}

function modifyCommentToggle(e) {
  var me = getActivatedObject(e);
  var comments = me.parentNode;
  while (comments.className != "comments") {
    comments = comments.parentNode;
  }
  var p = comments.getElementsByTagName("p")[0];//댓글표시 p
  var form = comments.getElementsByTagName("form")[0];//댓글 수정 form
  if (p.style.display) {
    p.style.display = '';
    form.style.display = 'none';
  } else {
    p.style.display = 'none';
    form.style.display = '';
  }
  return false;	
}

/*
 Head First Ajax 참조 : 활성화된 객체 반환
*/
function getActivatedObject(e) {
  var obj;
  if (!e) {
    //IE 옛버전
    obj = window.event.srcElement;
  } else if (e.srcElement) {
    //IE 7 이상
    obj = e.srcElement;
  } else {
    //DOM 레벨2 브라우저
    obj = e.target;
  }
  return obj;
}
</pre>

bbs-view.js 파일에서 initPage() 함수 구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
//댓글
var bbs = document.getElementById("bbs");
var divs = bbs.getElementsByTagName("div");

for (i = 0; i &lt; divs.length; i++) {
  if (divs[i].className == "comments") {
    var comments = divs[i];
    var spans = comments.getElementsByTagName("span");
    for (var j = 0; j &lt; spans.length; j++) {
      if (spans[j].className == "modify-del") {
        var md = spans[j];
        var commentModifyLink = md.getElementsByTagName("a")[0];//수정 링크
        commentModifyLink.onclick = modifyCommentToggle;
        var commentDelLink = md.getElementsByTagName("a")[1];//삭제 링크
        commentDelLink.onclick =  function() {
          var commentNo = this.title;
          var chk = confirm("정말로 삭제하시겠습니까?");
          if (chk == true) {
            var form = document.getElementById("deleteCommentForm");
            form.commentNo.value = commentNo;
            form.submit();
            return false;
          }
        };
      }
   
      //form 태그안의 수정하기 링크
      var form = comments.getElementsByTagName("form")[0];
      var div = form.getElementsByTagName("div")[0];
      commentModifyLink = div.getElementsByTagName("a")[0];
      commentModifyLink.onclick = commentUpdate;
      //form 태그안의 취소링크
      var cancelLink = div.getElementsByTagName("a")[1];
      cancelLink.onclick = modifyCommentToggle;
    }
  }    
}
</pre>

<h3>테스트</h3>
댓글의 "수정 | 삭제" 와 "수정하기 | 취소" 링크를 차례로 테스트한다.<br />


<h2>다음글, 이전글 링크에서 스크립트 분리</h2>

'다음글 이전글' 링크에서 자바스크립트를 분리한다.<br />
아래 그림을 참고한다.<br />

<img alt="다음 글 이전 글 링크" src="https://lh4.googleusercontent.com/-zXFx5qVRpLc/Uqg4ttnJOzI/AAAAAAAABgA/PpYs0BNrhhg/s580/next-prev.png" /><br />

view.jsp 파일에서 "다음글 이전글" 디자인을 수정한다.<br />

<pre class="prettyprint">
&lt;div id="next-prev"&gt;
  &lt;c:if test="${nextArticleAddInfo != null }"&gt;
  &lt;p&gt;다음글 :
    &lt;a href="#" <strong>title="${nextArticleAddInfo.article.postsNo }"</strong>&gt;
    ${nextArticleAddInfo.article.title }
    &lt;/a&gt;
  &lt;/p&gt;
  &lt;/c:if&gt;
  &lt;c:if test="${prevArticleAddInfo != null }"&gt;
  &lt;p&gt;이전글 :
    &lt;a href="#" <strong>title="${prevArticleAddInfo.article.postsNo }"</strong>&gt;
    ${prevArticleAddInfo.article.title }
    &lt;/a&gt;
  &lt;/p&gt;
  &lt;/c:if&gt;
&lt;/div&gt;
</pre>

bbs-view.js 파일에 다음 함수를 추가한다.<br />

<pre class="prettyprint">
function goView() {
  var form = document.getElementById("viewForm");
  form.articleNo.value = this.title;
  form.submit();
  return false;
}
</pre>

bbs-view.js 파일에서 initPage() 함수 구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
//다음글,이전글 링크
var nextPrev = document.getElementById("next-prev");
links = nextPrev.getElementsByTagName("a");
for (i = 0; i &lt; links.length; i++) {
  links[i].onclick = goView;
}
</pre>



<h2>수정,삭제,다음글,이전글,목록,새글쓰기 버튼에서 스크립트 분리</h2>

이번 실습은 "수정, 삭제, 다음글, 이전글, 목록, 새글쓰기 버튼" 디자인에서 자바스크립트를 분리하는 것이다.<br />
아래 그림을 참고한다.<br />

<img alt="수정,삭제,다음글,이전글,목록,새글쓰기 버튼" src="https://lh6.googleusercontent.com/-SdbquJIhk3c/Uqg-_RDgaRI/AAAAAAAABgY/vWzii2dfbrI/s580/view-menu-buttons.png" /><br />

view.jsp 파일에서 "수정, 삭제, 다음글, 이전글, 목록, 새글쓰기 버튼" 디자인을 아래 강조된 부분을 참고하여 고친다.<br />

<pre class="prettyprint">
&lt;div id="view-menu"&gt;
	&lt;c:if test="${user.username == articleAddInfo.article.username }"&gt;
	&lt;div class="fl"&gt;
		&lt;input type="button" value="수정" <strong>id="goModify"</strong> /&gt;
		&lt;input type="button" value="삭제" <strong>id="goDelete"</strong> /&gt;
	&lt;/div&gt;
	&lt;/c:if&gt;
	
	&lt;div class="fr"&gt;
	&lt;c:if test="${nextArticleAddInfo != null }"&gt;		
		&lt;input type="button" value="다음글" 
			title="${nextArticleAddInfo.article.articleNo }" 
			<strong>id="next-article"</strong> /&gt;
	&lt;/c:if&gt;
	&lt;c:if test="${prevArticleAddInfo != null }"&gt;			
		&lt;input type="button" value="이전글" 
			title="${prevArticleAddInfo.article.articleNo }" 
			<strong>id="prev-article"</strong> /&gt;
	&lt;/c:if&gt;
	
	&lt;input type="button" value="목록" <strong>id="goList"</strong> /&gt;
	&lt;input type="button" value="새글쓰기" <strong>id="goWrite"</strong> /&gt;
	&lt;/div&gt;
&lt;/div&gt;
</pre>

form-group에 다음 폼을 추가한다.<br />

<pre class="prettyprint">
&lt;form id="listForm" action="list.jsp" method="get"&gt;
&lt;p&gt;
  &lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
  &lt;input type="hidden" name="page" value="${param.page }" /&gt;
  &lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
&lt;/p&gt;
&lt;/form&gt;
</pre>
bbs-view.js 파일에 다음 함수를 추가한다.<br />

<pre class="prettyprint">
function goList() {
	var form = document.getElementById("listForm");
	form.page.value = this.title;
	form.submit();
	return false;
}
</pre>

bbs-view.js 파일에서 initPage() 함수 구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
//수정버튼
var modifyBtn = document.getElementById("goModify");
if (modifyBtn) {
	modifyBtn.onclick = function() {
		var form = document.getElementById("modifyForm");
		form.submit();
	};
}
//삭제버튼
var deleteBtn = document.getElementById("goDelete");
if (deleteBtn) {
	deleteBtn.onclick = function() {
		var chk = confirm('정말로 삭제하시겠습니까?');
		if (chk == true) {
			var form = document.getElementById("delForm");
			form.submit();
		}
	};
}
//다음글 버튼
var nextArticle = document.getElementById("next-article");
if (nextArticle) {
	nextArticle.onclick = goView;
}
//이전글 버튼
var prevArticle = document.getElementById("prev-article");
if (prevArticle) {
	prevArticle.onclick = goView;
}
//목록버튼
var listBtn = document.getElementById("goList");
listBtn.onclick = function() {
	var form = document.getElementById("listForm");
	form.submit();
};
//새글쓰기 버튼
var writeBtn = document.getElementById("goWrite");
writeBtn.onclick = function() {
	var form = document.getElementById("writeForm");
	form.submit();
};
</pre>


<h3>테스트</h3>
수정, 삭제, 다음글, 이전글, 목록, 새글쓰기 버튼을 클릭하여 테스트한다.<br />


<h2>목록링크/페이징 처리/새글쓰기 버튼에서 스크립트 분리</h2>

view.jsp에서 목록, 페이징 처리, 새글쓰기 버튼과 관련된 코드에서 디자인과 자바스크립트의 분리를 작업한다.<br />
아래 그림을 참고한다.<br />

<img alt="view.jsp에서 목록과 페이징처리 부분,새글쓰기 버튼" src="https://lh6.googleusercontent.com/-aOqGAfvNW7c/UqhCOa4QZWI/AAAAAAAABgw/wvbVT3ScMtg/s580/list-table_paging_list-menu.png" /><br />

view.jsp 파일에서 목록과 페이징 처리, 새글쓰기 버튼 관련 디자인을 아래처럼 수정한다.<br />

<pre class="prettyprint">
&lt;table <strong>id="list-table"</strong>&gt;
&lt;tr&gt;
	&lt;th style="width: 60px"&gt;NO&lt;/th&gt;
	&lt;th&gt;TITLE&lt;/th&gt;
	&lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
	&lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
&lt;/tr&gt;

&lt;!--  반복 구간 시작 --&gt;
&lt;c:forEach var="articleAddInfo" items="${list }" varStatus="status"&gt;
&lt;tr&gt;
	&lt;td style="text-align: center;"&gt;
	&lt;c:choose&gt;
		&lt;c:when test="${viewArticleAddInfo.article.articleNo == articleAddInfo.article.articleNo }"&gt;
			&lt;img src="../images/arrow.gif" alt="현재글" style="vertical-align: middle;" /&gt;
		&lt;/c:when&gt;
		&lt;c:otherwise&gt;	
			${listItemNo - status.index }
		&lt;/c:otherwise&gt;
	&lt;/c:choose&gt;	
	&lt;/td&gt;
	&lt;td&gt;
		<strong>&lt;a href="#" title="${articleAddInfo.article.articleNo }"&gt;
			${articleAddInfo.article.title }
		&lt;/a&gt;</strong>
		&lt;c:if test="${articleAddInfo.attachFileNum &gt; 0 }"&gt;
			&lt;img src="../images/attach.png" alt="첨부파일" /&gt;
		&lt;/c:if&gt;
		&lt;c:if test="${articleAddInfo.commentNum &gt; 0 }"&gt;
			&lt;span class="bbs-strong"&gt;[${articleAddInfo.commentNum }]&lt;/span&gt;
		&lt;/c:if&gt;
	&lt;/td&gt;
	&lt;td style="text-align: center;"&gt;${articleAddInfo.article.regDateForList }&lt;/td&gt;
	&lt;td style="text-align: center;"&gt;${articleAddInfo.hit }&lt;/td&gt;
&lt;/tr&gt;
&lt;/c:forEach&gt;
&lt;!--  반복 구간 끝 --&gt;
&lt;/table&gt;
	
&lt;div id="paging"&gt;
	
	&lt;c:if test="${prevPage &gt; 0 }"&gt;
		<strong>&lt;a href="#" title="${prevPage }"&gt;[이전]&lt;/a&gt;</strong>
	&lt;/c:if&gt;
	
	&lt;c:forEach var="i" begin="${firstPage }" end="${lastPage }"&gt;
		&lt;c:choose&gt;
			&lt;c:when test="${i == param.page }"&gt;
				&lt;span class="bbs-strong"&gt;${i }&lt;/span&gt;
			&lt;/c:when&gt;
			&lt;c:otherwise&gt;	
				<strong>&lt;a href="#" title="${i }"&gt;${i }&lt;/a&gt;</strong>
			&lt;/c:otherwise&gt;
		&lt;/c:choose&gt;	
	&lt;/c:forEach&gt;
	
	&lt;c:if test="${nextPage &gt; 0 }"&gt;
		<strong>&lt;a href="#" title="${nextPage }"&gt;[다음]&lt;/a&gt;</strong>
	&lt;/c:if&gt;
	
&lt;/div&gt;

&lt;div id="list-menu"&gt;
	<strong>&lt;input type="button" value="새글쓰기" /&gt;</strong>
&lt;/div&gt;
</pre>

bbs-view.js 파일에서 initPage() 함수 구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
//상세보기 안의 목록의 제목링크
var listTable = document.getElementById("list-table");
links = listTable.getElementsByTagName("a");
for (i = 0; i &lt; links.length; i++) {
	links[i].onclick = goView;
}

//페이징처리
var paging = document.getElementById("paging");
links = paging.getElementsByTagName("a");
for (i = 0; i &lt; links.length; i++) {
	links[i].onclick = goList;
}

//검색 버튼 위의 새글쓰기 버튼
var listMenu = document.getElementById("list-menu");
writeBtn = listMenu.getElementsByTagName("input")[0];
writeBtn.onclick = function() {
	var form = document.getElementById("writeForm");
	form.submit();
};
</pre>

<h3>테스트</h3>
제목을 클릭하여 주소창에 변경되는지 확인한다.<br />
페이징 직접 이동 링크를 클릭하고 주소창에서 page가 변경되는지 확인한다.<br />
새글쓰기 버튼을 클릭하여 새글쓰기 페이지로 이동하는지를 확인한다.<br />



<h2>다운로드/파일 삭제 링크에서 스크립트 분리(jQuery)</h2>

다운로드/파일 삭제 링크에서 스크립트 분리에서 구현한 첨부파일 링크와 첨부 파일 삭제 링크에 대한 자바스크립트
코드를  jQuery 코드로 수정한다.<br />
아래 그림에서 test.txt가 파일 다운로드 링크이고 바로 옆의 x가 파일 삭제 링크다.<br />

<img alt="첨부파일링크와 첨부파일 삭제 링크" src="https://lh3.googleusercontent.com/-BrUcvQHS2zo/Uqgsyt28r9I/AAAAAAAABfM/fREG_9-4sUw/s576/files.png" /><br />

jQuery 최신 파일을 <a href="http://jquery.com">jQuery.com</a>에서 다운로드한다.<br />
도큐먼트 베이스 아래 js 폴더를 만들고 그 안에 다운로드한 파일과 bbs-view.js을 복사한다.<br />
view.jsp 파일을 열고 bbs-view.js가 아래에 위치하도록 아래 문장으로 임포트 한다.<br />


<pre class="prettyprint">
<strong>&lt;script type="text/javascript" src="../js/jquery-1.11.2.min.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="../js/bbs-view.js"&gt;&lt;/script&gt;</strong>
</pre>

js 폴더에 있는 bbs-view.js의 기존 내용은 모두 지운다.<br />
<br />
view.jsp에서 첨부파일 링크와 첨부 파일 삭제 링크에 관한 코드를 아래처럼 바꾼다.<br />

<pre class="prettyprint">
&lt;div id="gul-content"&gt;
  &lt;span id="date-writer-hit"&gt;
    edited ${articleAddInfo.article.regDateForView } 
    by ${articleAddInfo.article.name } 
    hit ${articleAddInfo.hit }
  &lt;/span&gt;
  &lt;p&gt;${articleAddInfo.article.htmlContent }&lt;/p&gt;
  &lt;p id="file-list" style="text-align: right;"&gt;
    &lt;c:forEach var="file" items="${attachFileList }"&gt;
      &lt;a href="#" title="${file.attachFileNo }" class="download"&gt;${file.filename }&lt;/a&gt;
      &lt;c:if test="${user.username == viewPostsAddInfo.posts.username }"&gt;
        &lt;a href="#" title="${file.attachFileNo }"&gt;x&lt;/a&gt;
      &lt;/c:if&gt;
      &lt;br /&gt;
    &lt;/c:forEach&gt;
  &lt;/p&gt;
&lt;/div&gt;
</pre>

bbs-view.js에 아래 코드를 입력한다.<br />

<pre class="prettyprint">
$(document).ready(function() {
  $('#file-list a.download').click(function() {
    var $attachFileNo = this.title;
    $('#downloadForm input[name*=attachFileNo]').val($attachFileNo);
    $('#downloadForm').submit();
    
    return false;
  });
  
  $('#file-list a:not(.download)').click(function() {
    var chk = confirm("정말로 삭제하시겠습니까?");
    
    if (chk == true) {
      var $attachFileNo = this.title;
      $('#deleteAttachFileForm input[name*=attachFileNo]').val($attachFileNo);
      $('#deleteAttachFileForm').submit();
    }
    
    return false;
  });

});
</pre>

<h3>테스트</h3>
테스트는 첨부파일 다운로드와 첨부 파일 삭제를 해본다.<br />
그 외 기능은 이제 작동하지 않는다.



<h2>댓글(수정/삭제, 수정하기/취소)링크에서 스크립트 분리(jQuery)</h2>

댓글(수정/삭제, 수정하기/취소) 링크에서 스크립트 분리에서 완성한 자바스크립트 코드를 jQuery로 변경한다.<br />
아래 그림을 참고한다.<br />

<img alt="댓글 반복" src="https://lh3.googleusercontent.com/-z6NH0AKuzUE/VYZNET51rsI/AAAAAAAACjQ/5na_oCNNDy0/s722/comments.png" width="590px" /><br />

view.jsp 파일에서 댓글 관련 디자인을 아래와 같다.<br />
강조된 부분이 "댓글(수정/삭제, 수정하기/취소) 링크에서 스크립트 분리" 와 다른 부분이다.<br />

<pre class="prettyprint">
&lt;!--  댓글 반복 시작 --&gt;
&lt;c:forEach var="comment" items="${commentList }"&gt;
&lt;div class="comments"&gt;
  &lt;span class="writer"&gt;${comment.name }&lt;/span&gt;
  &lt;span class="date"&gt;${comment.regdate }&lt;/span&gt;
  &lt;c:if test="${user.username == comment.username }" &gt;
  &lt;span class="modify-del"&gt;
    &lt;a href="#" <strong>class="comment-toggle"</strong>&gt;수정&lt;/a&gt; | 
    &lt;a href="#" <strong>class="comment-delete"</strong> 
      title="${comment.commentNo }"&gt;삭제&lt;/a&gt;
  &lt;/span&gt;
  &lt;/c:if&gt;
  &lt;p <strong>class="view-comment"</strong>&gt;${comment.htmlMemo }&lt;/p&gt;
  &lt;form class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none"&gt;
    &lt;p&gt;
      &lt;input type="hidden" name="commentNo" value="${comment.commentNo }" /&gt;
      &lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
      &lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
      &lt;input type="hidden" name="page" value="${param.page }" /&gt;
      &lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
    &lt;/p&gt;
    &lt;div style="text-align: right;"&gt;
      &lt;a href="#"&gt;수정하기&lt;/a&gt; | &lt;a href="#"&gt;취소&lt;/a&gt;
    &lt;/div&gt;
    &lt;div&gt;
      &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;${comment.memo }&lt;/textarea&gt;
    &lt;/div&gt;
  &lt;/form&gt;
&lt;/div&gt;
&lt;/c:forEach&gt;
&lt;!--  댓글 반복 끝 --&gt;
</pre>


bbs-view.js에서 <em class="path">$(document).ready(function() {...}</em> 
구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
//댓글반복
$('.comments').click(function(e) {
	if ($(e.target).is('.comment-toggle')) {
		var $form = $(e.target).parent().parent().find('.modify-comment');
		var $p = $(e.target).parent().parent().find('.view-comment');
		if ($form.is(':hidden') == true) {
			$form.show();
			$p.hide();
		} else {
			$form.hide();
			$p.show();
		}
		return false;
	} else if ($(e.target).is('.comment-delete')) {
		var chk = confirm("정말로 삭제하시겠습니까?");
		if (chk == true) {
			var $commentNo = $(e.target).attr('title');
			$('#deleteCommentForm input[name*=commentNo]').val($commentNo);
			$('#deleteCommentForm').submit();
		}
		return false;
	}
});
//form 안의 수정하기 링크
$('.modify-comment a:contains("수정하기")').click(function(e) {
	$(e.target).parent().parent().submit();
	return false;
});
//form 안의 취소 링크
$('.modify-comment a:contains("취소")').click(function(e) {
	var $form = $(e.target).parent().parent();
	var $p = $(e.target).parent().parent().parent().find('.view-comment');
	if ($form.is(':hidden') == true) {
		$form.show();
		$p.hide();
	} else {
		$form.hide();
		$p.show();
	}
	return false;
});
</pre>

<h3>테스트</h3>
댓글의 수정과 삭제를 테스트한다.<br />





<h2>이전글, 다음글 링크에서 스크립트 분리(jQuery)</h2>

이전글, 다음글 링크에서 분리한 자바스크립트 코드를 jQuery 코드로 변경한다.<br />
아래 그림을 참고한다.<br />

<img alt="다음글 이전글 링크" src="https://lh4.googleusercontent.com/-zXFx5qVRpLc/Uqg4ttnJOzI/AAAAAAAABgA/PpYs0BNrhhg/s580/next-prev.png" /><br />

view.jsp 파일에서 다음 부분이다.<br />
디자인은 이전 실습과 같다.<br />

<pre class="prettyprint">
&lt;div id="next-prev"&gt;
	&lt;c:if test="${nextArticleAddInfo != null }"&gt;
	&lt;p&gt;다음글 :
	  &lt;a href="#" title="${nextArticleAddInfo.article.articleNo }"&gt;
	  ${nextArticleAddInfo.article.title }
	  &lt;/a&gt;
	&lt;/p&gt;
	&lt;/c:if&gt;
	&lt;c:if test="${prevArticleAddInfo != null }"&gt;
	&lt;p&gt;이전글 :
	  &lt;a href="#" title="${prevArticleAddInfo.article.articleNo }"&gt;
	  ${prevArticleAddInfo.article.title }
	  &lt;/a&gt;
	&lt;/p&gt;
	&lt;/c:if&gt;
&lt;/div&gt;
</pre>

bbs-view.js 파일에 다음 함수를 추가한다.<br />

<pre class="prettyprint">
function goView(articleNo) {
	$('#viewForm input[name*=articleNo]').val(articleNo);
	$('#viewForm').submit();
}
</pre>

bbs-view.js에서 
<em class="path">$(document).ready(function() {..}</em>
함수 구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
$('#next-prev a').click(function() {
	var $articleNo = this.title;
	goView($articleNo);
	return false;
});
</pre>





<h2>수정, 삭제, 다음글, 이전글, 목록, 새글쓰기 버튼에서 스크립트 분리(jQuery)</h2>

수정, 삭제, 다음글, 이전글, 목록, 새글쓰기 버튼에서 분리한 스크립트 코드를 jQuery로 변경한다.<br />

<img alt="수정,삭제,다음글,이전글,목록,새글쓰기 버튼" src="https://lh6.googleusercontent.com/-SdbquJIhk3c/Uqg-_RDgaRI/AAAAAAAABgY/vWzii2dfbrI/s580/view-menu-buttons.png" /><br />

view.jsp에서 다음 부분으로 디자인은 전과 같다.<br />

<pre class="prettyprint">
&lt;div id="view-menu"&gt;
	&lt;c:if test="${user.username == articleAddInfo.article.username }"&gt;
	&lt;div class="fl"&gt;
		&lt;input type="button" value="수정" id="goModify" /&gt;
		&lt;input type="button" value="삭제" id="goDelete" /&gt;
	&lt;/div&gt;
	&lt;/c:if&gt;
	&lt;div class="fr"&gt;
	&lt;c:if test="${nextArticleAddInfo != null }"&gt;		
		&lt;input type="button" value="다음글" 
			title="${nextArticleAddInfo.article.articleNo }" 
			<strong>id="next-article"</strong> /&gt;
	&lt;/c:if&gt;
	&lt;c:if test="${prevArticleAddInfo != null }"&gt;			
		&lt;input type="button" value="이전글" 
			title="${prevArticleAddInfo.article.articleNo }" 
			<strong>id="prev-article"</strong> /&gt;
	&lt;/c:if&gt;
	&lt;input type="button" value="목록" id="goList" /&gt;
	&lt;input type="button" value="새글쓰기" id="goWrite" /&gt;
	&lt;/div&gt;
&lt;/div&gt;
</pre>

bbs-view.js 파일에 다음 함수를 추가한다.<br />

<pre class="prettyprint">
function goList(page) {
	$('#listForm input[name*=page]').val(page);
	$('#listForm').submit();
}
</pre>

bbs-view.js에서 
<em class="path">$(document).ready(function() {..}</em>
함수 구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
//수정 버튼
$('#goModify').click(function() {
	$('#modifyForm').submit();
});
//삭제 버튼
$('#goDelete').click(function() {
	var chk = confirm('정말로 삭제하시겠습니까?');
	if (chk == true) {
		$('#delForm').submit();
	}
});
//다음글 버튼
$('#next-article').click(function() {
	var $articleNo = this.title;
	goView($articleNo);
});
//이전글 버튼
$('#prev-article').click(function() {
	var $articleNo = this.title;
	goView($articleNo);
});
//목록버튼
$('#goList').click(function() {
	$('#listForm').submit();
});
//새글쓰기 버튼
$('#goWrite').click(function() {
	$('#writeForm').submit();
});
</pre>



<h2>목록링크/페이징 처리/새글쓰기 버튼에서 스크립트 분리(jQuery)</h2>

목록링크/페이징 처리/새글쓰기 버튼에서 분리한 스크립트 코드를 jQuery 코드로 변경한다.<br />

<img alt="view.jsp에서 목록과 페이징처리 부분,새글쓰기 버튼" src="https://lh6.googleusercontent.com/-aOqGAfvNW7c/UqhCOa4QZWI/AAAAAAAABgw/wvbVT3ScMtg/s580/list-table_paging_list-menu.png" /><br />

view.jsp에서 다음 부분이며, 디자인은 전과 같다.<br />

<pre class="prettyprint">
&lt;table id="list-table"&gt;
&lt;tr&gt;
	&lt;th style="width: 60px"&gt;NO&lt;/th&gt;
	&lt;th&gt;TITLE&lt;/th&gt;
	&lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
	&lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
&lt;/tr&gt;

&lt;!--  반복 구간 시작 --&gt;
&lt;c:forEach var="articleAddInfo" items="${list }" varStatus="status"&gt;
&lt;tr&gt;
	&lt;td style="text-align: center;"&gt;
	&lt;c:choose&gt;
		&lt;c:when test="${viewArticleAddInfo.article.articleNo == articleAddInfo.article.articleNo }"&gt;
			&lt;img src="../images/arrow.gif" alt="현재글" style="vertical-align: middle;" /&gt;
		&lt;/c:when&gt;
		&lt;c:otherwise&gt;	
			${listItemNo - status.index }
		&lt;/c:otherwise&gt;
	&lt;/c:choose&gt;	
	&lt;/td&gt;
	&lt;td&gt;
		<strong>&lt;a href="#" title="${articleAddInfo.article.articleNo }"&gt;
			${articleAddInfo.article.title }
		&lt;/a&gt;</strong>
		&lt;c:if test="${articleAddInfo.attachFileNum &gt; 0 }"&gt;
			&lt;img src="../images/attach.png" alt="첨부파일" /&gt;
		&lt;/c:if&gt;
		&lt;c:if test="${articleAddInfo.commentNum &gt; 0 }"&gt;
			&lt;span class="bbs-strong"&gt;[${articleAddInfo.commentNum }]&lt;/span&gt;
		&lt;/c:if&gt;
	&lt;/td&gt;
	&lt;td style="text-align: center;"&gt;${articleAddInfo.article.regDateForList }&lt;/td&gt;
	&lt;td style="text-align: center;"&gt;${articleAddInfo.hit }&lt;/td&gt;
&lt;/tr&gt;
&lt;/c:forEach&gt;
&lt;!--  반복 구간 끝 --&gt;
&lt;/table&gt;
	
&lt;div id="paging"&gt;
	&lt;c:if test="${prevPage &gt; 0 }"&gt;
		<strong>&lt;a href="#" title="${prevPage }"&gt;[이전]&lt;/a&gt;</strong>
	&lt;/c:if&gt;
	
	&lt;c:forEach var="i" begin="${firstPage }" end="${lastPage }"&gt;
		&lt;c:choose&gt;
			&lt;c:when test="${i == param.page }"&gt;
				&lt;span class="bbs-strong"&gt;${i }&lt;/span&gt;
			&lt;/c:when&gt;
			&lt;c:otherwise&gt;	
				<strong>&lt;a href="#" title="${i }"&gt;${i }&lt;/a&gt;</strong>
			&lt;/c:otherwise&gt;
		&lt;/c:choose&gt;	
	&lt;/c:forEach&gt;
	
	&lt;c:if test="${nextPage &gt; 0 }"&gt;
		<strong>&lt;a href="#" title="${nextPage }"&gt;[다음]&lt;/a&gt;</strong>
	&lt;/c:if&gt;
	
&lt;/div&gt;

&lt;div id="list-menu"&gt;
	<strong>&lt;input type="button" value="새글쓰기" /&gt;</strong>
&lt;/div&gt;
</pre>

bbs-view.js에서 
<em class="path">$(document).ready(function() {.. }</em>
함수 구현부의 가장 아래에 다음 코드를 추가한다.<br />

<pre class="prettyprint">
//상세보기 안의 목록의 제목링크
$('#list-table a').click(function() {
	var $articleNo = this.title;
	goView($articleNo);
	return false;
});
//페이징 처리
$('#paging a').click(function() {
	var $page = this.title;
	goList($page);
	return false;
});
//검색 버튼 위의 새글쓰기 버튼
$('#list-menu input').click(function() {
	$('#writeForm').submit();
});
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.wikibook.co.kr/PublisherApp/homepage/detailView?isbn=9788992939331">jQuery 1.3 작고 강력한 자바스크립트 라이브러리 | 조나단 채퍼 외 | 위키북스</a></li>
	<li><a href="http://www.hanb.co.kr/book/look.html?isbn=978-89-7914-693-6"> Head First Ajax - 레베카 리오단 지음 | 홍승표, 김은희 역 | 한빛미디어</a></li>
</ul>