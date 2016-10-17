<div id="last-modified">Last Modified : 2014.7.31</div>
<h1>상세보기</h1>

list.html 파일을 에디터에서 다른 이름으로 저장하기 메뉴를 이용하여 view.html 이름의 새 파일을 만든다.<br />
view.html 문서를 열고 #bbs 바로 아래 다음 코드를 추가한다.
목록을 보여주는 코드는 그대로 두어 상세보기 화면 하단에 목록이 다시 보이도록 한다.

<pre class="prettyprint">&lt;table&gt;
&lt;tr&gt;
    &lt;th style="width: 37px;text-align: left;vertical-align: top;"&gt;TITLE&lt;/th&gt;
    &lt;th style="text-align: left;color: #555;"&gt;무궁화꽃이피었습니다&lt;/th&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div id="gul-content"&gt;
    &lt;span id="date-writer-hit"&gt;2014 10-09 17:50:30 by 홍길동 hit 1330&lt;/span&gt;
    &lt;p&gt;
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다&lt;br /&gt;
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다&lt;br /&gt;
    &lt;/p&gt;
&lt;/div&gt;

&lt;!--  댓글 반복 시작 --&gt;
&lt;div class="comments"&gt;
    &lt;span class="writer"&gt;xman&lt;/span&gt;
    &lt;span class="date"&gt;2011.12.11 12:14:32&lt;/span&gt;
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:modifyCommentToggle('5')"&gt;수정&lt;/a&gt;
         | &lt;a href="javascript:deleteComment('5')"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
    &lt;p id="comment5"&gt;무궁화꽃이피었습니다&lt;/p&gt;
    &lt;form id="modifyCommentForm5" class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none;"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" value="5" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="articleNo" value="12" /&gt;
        &lt;input type="hidden" name="curPage" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;div class="fr"&gt;
            &lt;a href="javascript:document.forms.modifyCommentForm5.submit()"&gt;수정하기&lt;/a&gt;
            | &lt;a href="javascript:modifyCommentToggle('5')"&gt;취소&lt;/a&gt;
    &lt;/div&gt;
    &lt;div&gt;
        &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;무궁화꽃이 피었습니다.&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/div&gt;

&lt;div class="comments"&gt;
    &lt;span class="writer"&gt;xman&lt;/span&gt;
    &lt;span class="date"&gt;2011.12.11 12:14:32&lt;/span&gt;
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:modifyCommentToggle('4')"&gt;수정&lt;/a&gt;
         | &lt;a href="javascript:deleteComment('4')"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
    &lt;p id="comment4"&gt;무궁화꽃이피었습니다&lt;/p&gt;
    &lt;form id="modifyCommentForm4" class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none;"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" value="4" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="articleNo" value="12" /&gt;
        &lt;input type="hidden" name="curPage" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;div class="fr"&gt;
        &lt;a href="javascript:document.forms.modifyCommentForm4.submit()"&gt;수정하기&lt;/a&gt;
        | &lt;a href="javascript:modifyCommentToggle('4')"&gt;취소&lt;/a&gt;
    &lt;/div&gt;
    &lt;div&gt;
        &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;무궁화꽃이 피었습니다.&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/div&gt;
&lt;!--  댓글 반복 끝 --&gt;

&lt;form id="addCommentForm" action="addComment_proc.jsp" method="post"&gt;
    &lt;p style="margin: 0; padding: 0;"&gt;
        &lt;input type="hidden" name="articleNo" value="5"/&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="curPage" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;div id="addComment"&gt;
        &lt;textarea name="memo" rows="7" cols="50"&gt;&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;div style="text-align: right;"&gt;
        &lt;input type="submit" value="댓글 남기기" /&gt;
    &lt;/div&gt;
&lt;/form&gt;

&lt;div id="next-prev"&gt;
    &lt;p&gt;다음 글 : &lt;a href="#"&gt;무궁화꽃이 피었습니다.&lt;/a&gt;&lt;/p&gt;
    &lt;p&gt;이전 글 : &lt;a href="#"&gt;무궁화꽃이 피었습니다.&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

&lt;div id="view-menu"&gt;
    &lt;div class="fl"&gt;
        &lt;input type="button" value="수정" /&gt;
        &lt;input type="button" value="삭제" /&gt;
    &lt;/div&gt;
    
    &lt;div class="fr"&gt;
        &lt;input type="button" value="다음 글" /&gt;
        &lt;input type="button" value="이전 글" /&gt;
        &lt;input type="button" value="목록" /&gt;
        &lt;input type="button" value="새 글쓰기" /&gt;
    &lt;/div&gt;
&lt;/div&gt;
</pre>

댓글이 반복되는 부분에서 comment5와 modifyCommentForm5에서 <strong>5</strong>는 댓글의 고유번호이다.<br />
이 번호는 프로그램적으로 부여되어야 한다.<br />
<br />
디자인 전 화면은 아래와 같다.<br />

<img alt="bbs-view-01" src="https://lh3.googleusercontent.com/-spM9lCbDwXc/VYPncRaiXOI/AAAAAAAACgU/zSstUAGRxFo/s656/bbs-view-01.png" /><br />

댓글 수정을 위한 자바스크립트 함수부터 만들어보자.<br />

<img alt="댓글 수정 링크" src="https://lh3.googleusercontent.com/-IXhhRvu_r64/VYPpuvOQByI/AAAAAAAACgk/KL1la-qwyac/s59/bbs-view-modify-link.png" style="width: 60px;"/><br />

<strong>수정</strong>을 클릭하면 textarea를 포함하는 수정 폼이 나타나야 한다.
(이 수정 폼은 디폴트로 숨겨져 있다)<br />
아래 자바스크립트 코드를 <em class="path">&lt;/head&gt;</em> 바로 위에 복사한다.<br />

<pre class="prettyprint">&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
function modifyCommentToggle(articleNo) {
    var p_id = "comment" + articleNo;
    var p = document.getElementById(p_id);
    
    var form_id = "modifyCommentForm" + articleNo;
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
//]]&gt;                                        
&lt;/script&gt;
</pre>

댓글의 수정과 취소를 클릭하여 자바스크립트 함수가 제대로 동작하는지 확인한다.<br />

<img alt="게시판 상세보기 댓글 수정 토글 자바스크립트 함수 작성하기" src="https://lh3.googleusercontent.com/-35Fwmda0d2c/VYPneSHd3ZI/AAAAAAAACfs/Yv_nJcA-MUU/s335/bbs-view-modify-javascript.png" /><br />

위에서 강조된 수정과 취소 링크는 같은 동작을 한다.<br />
수정 폼이 보이면 안 보이게, 안 보이면 보이게 하는 것이다.<br />
댓글 본문을 담는 p 엘리먼트는 정확히 이와 반대로 동작한다.<br />
이를 토글(toggle)이라 한다.<br />
<br />
본격적인 디자인을 시작한다.<br />
<br />
<strong>날짜 작성자 조회 수 디자인</strong><br />
<br />

[HTML]
<pre class="prettyprint">&lt;div id="gul-content"&gt;
    &lt;span id="date-writer-hit&gt;2014 10-09 17:50:30 by 홍길동 hit 1330&lt;/span&gt;
</pre>

[CSS]
<pre class="prettyprint"><strong>#gul-content span#date-writer-hit {
    display: block;
    margin: 0;
    padding: 0;
    font-size: 11px;
    color: #555;
    text-align: right;
}</strong>
</pre>

[결과 화면]<br />
<img alt="게시판 상세보기 작성자, 조회 수 디자인 결과" src="https://lh3.googleusercontent.com/--9Qsc-ApwwI/VYPnfeXKn_I/AAAAAAAACgM/hmJjO56M_qs/s596/bbs-view-writer-hit-result.png" /><br />

<strong>게시글 본문 디자인</strong><br />
<br />
[HTML]
<pre class="prettyprint">&lt;div id="gul-content"&gt;
    &lt;span id="date-writer-hit"&gt;2014 10-09 17:50:30 by 홍길동 hit 1330&lt;/span&gt;<strong>
    &lt;p&gt;
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다&lt;br /&gt;
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다&lt;br /&gt;
    &lt;/p&gt;</strong>
</pre>

[CSS]
<pre class="prettyprint"><strong>#gul-content p {
    margin: 0 0 15px 0;
    padding: 0;
    color: #333;
}</strong>
</pre>

<strong>댓글 작성자, 댓글 작성일, 수정|삭제 링크, 댓글 본문 디자인</strong><br />
<br />
화면에서 다음 부분이다.<br />

<img alt="게시판 상세보기 댓글 디자인 전" src="https://lh3.googleusercontent.com/-bOYv4mu4zLE/VYPndx6DK5I/AAAAAAAACfc/29dqUdM6hPA/s163/bbs-view-comments.png" /><br />

[HTML]
<pre class="prettyprint">&lt;div class="comments"&gt;<strong>
    &lt;span class="writer"&gt;xman&lt;/span&gt;
    &lt;span class="date"&gt;2011.12.11 12:14:32&lt;/span&gt;
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:modifyCommentToggle('5')"&gt;수정&lt;/a&gt;
        | &lt;a href="javascript:deleteComment('5')"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
    &lt;p id="comment5"&gt;무궁화꽃이피었습니다&lt;/p&gt;</strong>
    &lt;form id="modifyCommentForm5" class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none;"&gt;
        &lt;p&gt;
            &lt;input type="hidden" name="commentNo" value="5" /&gt;
            &lt;input type="hidden" name="boardCd" value="free" /&gt;
            &lt;input type="hidden" name="articleNo" value="12" /&gt;
            &lt;input type="hidden" name="curPage" value="1" /&gt;
            &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
        &lt;/p&gt;
        &lt;div class="fr"&gt;
            &lt;a href="javascript:document.forms.modifyCommentForm5.submit()"&gt;수정하기&lt;/a&gt;
            | &lt;a href="javascript:modifyCommentToggle('5')"&gt;취소&lt;/a&gt;
        &lt;/div&gt;
        &lt;div&gt;
            &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;무궁화꽃이피었습니다.&lt;/textarea&gt;
        &lt;/div&gt;
    &lt;/form&gt;
&lt;/div&gt;
</pre>

[CSS]
<pre class="prettyprint"><b>/* 댓글과 댓글을 테두리로 구분 */
.comments {
    border-top: 1px solid #ebebeb;
    border-right: 1px solid #ebebeb;
    border-left: 1px solid #ebebeb;
}

/* 댓글 작성자 ID */
.comments span.writer {
    display: block;
    float: left;
    margin: 3px;
    padding: 0;
    font-size: 12px;
    font-weight: bold;
    color: #555;
}

/* 댓글 작성일 */
.comments span.date {
    display: block;
    float: left;
    margin: 3px;
    padding: 0;
    font-size: 12px;
    color: #555;
}

/* 댓글 수정|삭제 */
.comments span.modify-del {
    display: block;
    float: right;
    margin: 3px;
    padding: 0;
    font-size: 12px;
    color: #555;
}

/* 댓글 수정|삭제 링크 */
.comments a {
    color: #555;
    text-decoration: none;
    font-size: 11px;
}

.comments a:hover {
    color: #555;
    text-decoration: underline;
}

/* 댓글 내용 */
.comments p {
    clear: both;
    margin: 0;
    padding: 0 3px 3px 3px;
    color: #555;
    font-size: 11px;
}</b>
</pre>

[결과 화면]<br />
<img alt="게시판 상세보기 댓글 디자인 결과" src="https://lh3.googleusercontent.com/-7QuRC_gSH2A/VYPnds5VcdI/AAAAAAAACfY/geZAjEzaOYE/s602/bbs-view-comments-result.png" /><br />

<strong>댓글 수정 폼 디자인</strong><br />
<br />
아래에 강조한 부분이다.<br />
<img alt="게시판 상세보기 댓글 수정 폼 디자인 전" src="https://lh3.googleusercontent.com/-_2d0PBTFctU/VYPneMT2QsI/AAAAAAAACgQ/OAU0LDeRwKc/s598/bbs-view-modify-form.png" /><br />

[HTML]
<pre class="prettyprint">&lt;div class="comments"&gt;
    &lt;span class="writer"&gt;xman&lt;/span&gt;
    &lt;span class="date"&gt;2011.12.11 12:14:32&lt;/span&gt;
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:modifyCommentToggle('5')"&gt;수정&lt;/a&gt;
        | &lt;a href="javascript:deleteComment('5')"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
    &lt;p id="comment5"&gt;무궁화꽃이피었습니다&lt;/p&gt;
    <strong>
    &lt;form id="modifyCommentForm5" class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none;"&gt;
        &lt;p&gt;
            &lt;input type="hidden" name="commentNo" value="5" /&gt;
            &lt;input type="hidden" name="boardCd" value="free" /&gt;
            &lt;input type="hidden" name="articleNo" value="12" /&gt;
            &lt;input type="hidden" name="curPage" value="1" /&gt;
            &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
        &lt;/p&gt;
        &lt;div class="fr"&gt;
            &lt;a href="javascript:document.forms.modifyCommentForm5.submit()"&gt;수정하기&lt;/a&gt;
            | &lt;a href="javascript:modifyCommentToggle('5')"&gt;취소&lt;/a&gt;
        &lt;/div&gt;
        &lt;div&gt;
            &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;무궁화꽃이피었습니다.&lt;/textarea&gt;
        &lt;/div&gt;
    &lt;/form&gt;
    </strong>
&lt;/div&gt;
</pre>

[CSS]
<pre class="prettyprint"><strong>.modify-comment {
    clear: both; 
    padding: 0.22em 2.22em 0.22em 3.22em; 
}

.modify-comment-ta {
    border: 1px solid silver;
    padding: 3px;
    width: 99%;
    color:#555;
    background-color: #eee;
    font-size: 11px; 
}</strong>
</pre>

[결과 화면]<br />
<img alt="게시판 상세보기 댓글 수정 폼 디자인 결과" src="https://lh3.googleusercontent.com/-6c8yr8M8Ceg/VYPnd_9xc-I/AAAAAAAACfo/U-J7YACnkfA/s597/bbs-view-modify-form-result.png" /><br />


<strong>댓글 쓰기 폼 디자인</strong><br />

화면에서는 다음 부분이다.<br />
<img alt="게시판 상세보기 댓글 쓰기 폼 디자인 전" src="https://lh3.googleusercontent.com/-G9VGAM5vZZE/VYPncTAz8sI/AAAAAAAACgY/Wz1eU4WULUQ/s598/bbs-view-addComments.png" /><br />

[HTML]<br />
<pre class="prettyprint">&lt;form id="addCommentForm" action="addComment_proc.jsp" method="post"&gt;
    &lt;p style="margin: 0; padding: 0;"&gt;
        &lt;input type="hidden" name="articleNo" value="5"/&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="curPage" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;div id="addComment"&gt;
        &lt;textarea name="memo" rows="7" cols="50"&gt;&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;div style="text-align: right;"&gt;
        &lt;input type="submit" value="댓글 남기기" /&gt;
    &lt;/div&gt;
&lt;/form&gt;
</pre>


[CSS]
<pre class="prettyprint"><strong>#addComment {
    margin-bottom: 5px;
    padding: 0.22em;
    border: 1px solid #eee;
    background-color: #fafbf7;
}

#addComment textarea {
    width: 99%;
    padding: 3px;
    border: 0;
    color: #555;    
}</strong>
</pre>

[결과 화면]<br />
<img alt="게시판 상세보기 댓글 쓰기 폼 디자인 결과" src="https://lh3.googleusercontent.com/-3eCDFB4lAWE/VYPncbyPU8I/AAAAAAAACfI/CsFQ5ZqjN_A/s601/bbs-view-addComments-result.png" /><br />
<strong>다음 글, 이전 글 디자인</strong><br />
화면에서는 다음 부분이다.<br />
<img alt="게시판 상세보기 다음 글 이전 글 디자인 전" src="https://lh3.googleusercontent.com/-7ourJrdqanc/VYPnfKmtjFI/AAAAAAAACgA/JFZm59MyMMU/s197/bbs-view-next-prev.png" /><br />

[HTML]
<pre class="prettyprint">&lt;div id="next-prev"&gt;
    &lt;p&gt;다음 글 : &lt;a href="#"&gt;무궁화꽃이 피었습니다.&lt;/a&gt;&lt;/p&gt;
    &lt;p&gt;이전 글 : &lt;a href="#"&gt;무궁화꽃이 피었습니다.&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;
</pre>

[CSS]
<pre class="prettyprint"><strong>#next-prev {
    margin: 7px 0;
    border-top: 1px solid #e1e1e1;
}

#next-prev p {
    margin: 0;
    padding: 5px;
    border-bottom: 1px solid #e1e1e1;
    font-size: 12px;
    color: #333;
}

#next-prev a {
    color: #333;
    text-decoration: none;
}

#next-prev a:hover {
    color: #333;
    text-decoration: underline;
}</strong>
</pre>

[결과 화면]<br />
<img alt="게시판 상세보기 다음 글 이전 글 디자인 결과" src="https://lh3.googleusercontent.com/-wU4qc8o8FU0/VYPnetPkSxI/AAAAAAAACf0/wfTFhBLbgUc/s601/bbs-view-next-prev-result.png" /><br />
<br />
<strong>수정, 삭제, 다음 글, 이전 글, 목록, 새 글쓰기 버튼 위치 조정</strong><br />
화면에서 다음 부분이다.<br />
<img alt="게시판 상세보기 수정*삭제*다음 글*이전 글*목록*새 글쓰기 버튼 디자인 전" src="https://lh3.googleusercontent.com/--C_8xydabOo/VYPndYkt72I/AAAAAAAACgE/PZrb8qK256Q/s329/bbs-view-buttons.png" /><br />

[HTML]
<pre class="prettyprint">&lt;div id="view-menu"&gt;
    &lt;div class="fl"&gt;
        &lt;input type="button" value="수정" /&gt;
        &lt;input type="button" value="삭제" /&gt;
    &lt;/div&gt;

    &lt;div class="fr"&gt;
        &lt;input type="button" value="다음 글" /&gt;
        &lt;input type="button" value="이전 글" /&gt;
        &lt;input type="button" value="목록" /&gt;
        &lt;input type="button" value="새 글쓰기" /&gt;
    &lt;/div&gt;
&lt;/div&gt;
</pre>

[CSS]
<pre class="prettyprint"><strong>#view-menu {
    height: 22px;
    margin-bottom: 47px;
}

.fl {
    float: left;
}

.fr {
    float: right;
}</strong>
</pre>

[결과 화면]<br />
<img alt="게시판 상세보기 수정*삭제*다음 글*이전 글*목록*새 글쓰기 버튼 디자인 결과" src="https://lh3.googleusercontent.com/-6j4_CK9ayTg/VYPndPZTiUI/AAAAAAAACgI/fE3YUhtI-MY/s599/bbs-view-buttons-result.png" /><br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.alistapart.com/articles/holygrail/">http://www.alistapart.com/articles/holygrail/</a></li>
</ul>

