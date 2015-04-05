<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>title</title>
<meta name="Keywords" content="keywords" />
<meta name="Description" content="description" />
<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen" />
<link rel="stylesheet" href="css/print.css" type="text/css" media="print" />
<script type="text/javascript">
//<![CDATA[
function modifyComment(no) {
	var p_id = "comment" + no;
	var p = document.getElementById(p_id);
	
	var form_id = "modifyCommentForm" + no;
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
//]]>
</script>
</head>
<body>

<div id="wrap">

    <div id="header">
	<h1><a href="#"><img src="images/ci.gif" alt="java-school logo" /></a></h1>
    </div>
    
    <div id="main-menu">
        <ul id="nav">
            <li><a href="#">Java</a></li>
            <li><a href="#">JDBC</a></li>
            <li><a href="#">JSP</a></li>
            <li><a href="#">Eclipse</a></li>
            <li><a href="#">Struts2</a></li>
            <li><a href="#">Ajax</a></li>
            <li><a href="#">Android</a></li>
        </ul>
    </div>
    
    <div id="container">
            <div id="content">

<!--  게시판 코드 시작 -->
<div id="url-navi">Eclipse &gt; Eclipse Tutorial</div>
<h1>Eclipse 설치</h1>

<div id="bbs">
<!--  게시글 상세보기 시작 -->
<table>
<tr>
    <th style="width: 37px;text-align: left;vertical-align: top;">TITLE</th>
    <th style="text-align: left;color: #555;">무궁화꽃이피었습니다</th>
</tr>
</table>
<div id="gul-content">
    <span id="date-writer-hit">2014 10-09 17:50:30 by 홍길동 hit 1330</span>
    <p>
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다<br />
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다<br />
    </p>
</div>

<!--  덧글 반복 시작 -->
<div class="comments">
    <span class="writer">xman</span>
    <span class="date">2011.12.11 12:14:32</span>
    <span class="modify-del">
        <a href="javascript:modifyComment('5')">수정</a>
         | <a href="javascript:goCommentDelete('5')">삭제</a>
    </span>
    <p id="comment5">무궁화꽃이피었습니다</p>
    <div class="modify-comment">
        <form id="modifyCommentForm5" action="updateComments.jsp" method="post" style="display: none;">
        <p>
            <input type="hidden" name="commentNo" value="5" />
            <input type="hidden" name="boardCd" value="free" />
            <input type="hidden" name="no" value="12" />
            <input type="hidden" name="curPage" value="1" />
            <input type="hidden" name="searchWord" value="무궁화꽃" />
        </p>
        <div class="fr">
                <a href="javascript:document.forms.modifyCommentForm5.submit()">수정하기</a>
                | <a href="javascript:modifyComment('5')">취소</a>
        </div>
        <div>
            <textarea class="modify-comment-ta" name="memo" rows="7" cols="50">무궁화꽃이 피었습니다.</textarea>
        </div>
        </form>
    </div>
</div>
<!--  덧글 반복 끝 -->

<!--  덧글 반복 시작 -->
<div class="comments">
    <span class="writer">xman</span>
    <span class="date">2011.12.11 12:14:32</span>
    <span class="modify-del">
        <a href="javascript:modifyComment('4')">수정</a>
         | <a href="javascript:goCommentDelete('4')">삭제</a>
    </span>
    <p id="comment4">무궁화꽃이피었습니다</p>
    <div class="modify-comment">
        <form id="modifyCommentForm4" action="updateComments.jsp" method="post" style="display: none;">
        <p>
            <input type="hidden" name="commentNo" value="4" />
            <input type="hidden" name="boardCd" value="free" />
            <input type="hidden" name="no" value="12" />
            <input type="hidden" name="curPage" value="1" />
            <input type="hidden" name="searchWord" value="무궁화꽃" />
        </p>
        <div class="fr">
            <a href="javascript:document.forms.modifyCommentForm4.submit()">수정하기</a>
            | <a href="javascript:modifyComment('4')">취소</a>
        </div>
        <div>
            <textarea class="modify-comment-ta" name="memo" rows="7" cols="50">무궁화꽃이 피었습니다.</textarea>
        </div>
        </form>
    </div>
</div>
<!--  덧글 반복 끝 -->

<form id="addCommentForm" action="addComment.jsp">
    <div id="addComment">
        <textarea rows="7" cols="50"></textarea>
    </div>
    <div style="text-align: right;">
        <input type="button" value="덧글남기기" />
    </div>
</form>

<div id="next-prev">
    <p>다음글 : <a href="#">무궁화꽃이 피었습니다.</a></p>
    <p>이전글 : <a href="#">무궁화꽃이 피었습니다.</a></p>
</div>

<div id="view-menu">
    <div class="fl">
        <input type="button" value="수정" />
        <input type="button" value="삭제" />
    </div>
    
    <div class="fr">
        <input type="button" value="다음글" />
        <input type="button" value="이전글" />
        <input type="button" value="목록" />
        <input type="button" value="새글쓰기" />
    </div>
</div>
<!--  게시글 상세보기 끝 -->

        <table>
        <!--  게시판 목록 머리말 -->
        <tr>
                <th style="width: 60px;">NO</th>
                <th>TITLE</th>
                <th style="width: 84px;">DATE</th>
                <th style="width: 60px;">HIT</th>
        </tr>
        
        <!--  반복 구간 시작 -->
        <tr>
                <td style="text-align: center;">11</td> <!--번호-->
                <td>
                        <a href="#">제목</a>
                        <!--첨부파일이 있으면 표시-->
                        <img src="images/attach.png" alt="첨부파일" />
                        <!--덧글갯수표시-->
                        <span class="bbs-strong">[5]</span>
                </td>
                <td style="text-align: center;">2011.11.15</td> <!--등록일-->
                <td style="text-align: center;">4555</td> <!--조회수-->
        </tr>
        <!--  반복 구간 끝 -->
        </table>
                
        <div id="paging">
                <span class="bbs-strong">1</span>
                <a href="#">[2]</a>
                <a href="#">[3]</a>
                <a href="#">[4]</a>
                <a href="#">[5]</a>
        </div>

        <div id="list-menu">
                <input type="button" value="새글쓰기" />
        </div>

        <div id="search">
                <form id="searchForm" action="list.jsp" method="post">
                        <p style="margin: 0;padding: 0;" >
                                <input type="hidden" name="boardCd" value="eclipse" />
                                <input type="text" name="searchWord" size="15" maxlength="30" />
                                <input type="submit" value="검색" />
                        </p>
                </form>
        </div>

</div>
<!--  게시판 코드 끝 -->

	</div>
    </div>
    
    <div id="sidebar">
	    <h1>Eclipse</h1>
	    <ul>
		<li><a href="#">Eclipse Tutorial</a>
		    <ul>
		        <li><a href="#">Eclipse 설치</a></li>
		        <li><a href="#">WTP 설치</a></li>
		    </ul>
		</li>
	    </ul>
    </div>
    
    <div id="extra"></div>
    
    <div id="footer">
	<ul>
		<li><a href="#">이용약관</a></li>
		<li><a href="#">개인정보보호정책</a></li>
		<li><a href="#">이메일무단수집거부</a></li>
		<li id="company-info">전화 : 02-123-5678, FAX : 02-123-5678<br />
		people@ggmail.org<br />
		Copyright java-school.net All Rights Reserved.</li>
		<li><a href="#">찾아오시는 길</a></li>
    	</ul>    
    </div>
        
</div>

</body>
</html>
