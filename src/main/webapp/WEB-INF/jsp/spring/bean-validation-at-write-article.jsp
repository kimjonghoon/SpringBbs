<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.5.22</div>

<h1>글쓰기에서의 빈 유효성 검사</h1>

<em class="filename">Article.java</em>
<pre class="prettyprint">
private Integer articleNo;//int 에서 변경

@Size(min=2,max=10,message="게시판코드는 2자에서 10자 사이이어야 합니다.")
private String boardCd;

@Size(min=1,max=60,message="제목은 1자에서 60자 사이이어야 합니다.")
private String title;

@Size(min=1,message="내용은 1자 이상이어야 합니다.")
private String content;

//중간 생략..

public Integer getArticleNo() {
    return articleNo;
}

public void setArticleNo(Integer articleNo) {
    this.articleNo = articleNo;
}
</pre>

<em class="filename">BbsController.java</em>
<pre class="prettyprint">
//글쓰기 화면
@RequestMapping(value="/write_form", method=RequestMethod.GET)
public String writeForm(String boardCd, Model model) {
    String boardNm = boardService.getBoardNm(boardCd);
    model.addAttribute("boardNm", boardNm);
    model.addAttribute("article", new Article());
    return "bbs/write_form";
}

//글쓰기 처리
@RequestMapping(value="/write", method=RequestMethod.POST)
public String write(@Valid Article article,
        BindingResult bindingResult, 
        Model model,
        MultipartHttpServletRequest mpRequest,
        Principal principal) throws Exception {
        
    //유효성 검사
    if (bindingResult.hasErrors()) {
        String boardNm = boardService.getBoardNm(article.getBoardCd());
        model.addAttribute("boardNm", boardNm);
        return "bbs/write_form";
    }
    
    article.setEmail(principal.getName());
    boardService.addArticle(article);

    //파일 업로드 - 기존과 같음

    //파일 데이터 삽입 - 기존과 같음

    return "redirect:/bbs/list?curPage=1&amp;boardCd=" + article.getBoardCd();
}
</pre>

<em class="filename">write_form.jsp</em>
<pre class="prettyprint">
<strong>
&lt;%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %&gt;

&lt;sf:form id="writeForm" action="write" method="post" enctype="multipart/form-data" 
        commandName="article" onsubmit="return check();"&gt;</strong>
&lt;p style="margin: 0;padding: 0;"&gt;
    &lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
    &lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
    &lt;input type="hidden" name="curPage" value="${param.curPage }" /&gt;
    &lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
&lt;/p&gt;
<strong>&lt;sf:errors path="*" cssClass="error" /&gt;</strong>
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:input path="title" style="width: 90%" /&gt;&lt;br /&gt;
        &lt;sf:errors path="title" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;&lt;/textarea&gt;&lt;br /&gt;
        <strong>&lt;sf:errors path="content" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;파일첨부&lt;/td&gt;
    &lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center; padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="전송" /&gt;
    &lt;input type="button" value="목록" onclick="goList()" /&gt;
    &lt;c:if test="${not empty param.articleNo }"&gt;
        &lt;input type="button" value="상세보기" onclick="goView()" /&gt;
    &lt;/c:if&gt;
&lt;/div&gt;
<strong>&lt;/sf:form&gt;</strong>
</pre>


<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://hibernate.org/validator/documentation/getting-started/">Getting started with Hibernate Validator</a></li>
	<li><a href="http://forum.spring.io/forum/spring-projects/web/80192-validation-empty-int-field">Validation - Empty int field</a></li>
	<li><a href="http://stackoverflow.com/questions/14715248/simple-springmvc-3-login-doesnt-work">http://stackoverflow.com/questions/14715248/simple-springmvc-3-login-doesnt-work</a></li>
	<li><a href="http://stackoverflow.com/questions/6227547/spring-3-validation-not-working">http://stackoverflow.com/questions/6227547/spring-3-validation-not-working</a></li>
	<li><a href="http://stackoverflow.com/questions/8909482/spring-mvc-3-ambiguous-mapping-found">http://stackoverflow.com/questions/8909482/spring-mvc-3-ambiguous-mapping-found</a></li>
	<li><a href="http://www.hanb.co.kr/book/look.html?isbn=978-89-7914-887-9#binfo5">예제로 쉽게 배우는 스프링 프레임워크 3.0(한빛미디어) - 사카타 코이치</a></li>
	<li><a href="http://jpub.tistory.com/196">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://docs.spring.io/spring/docs/current/spring-framework-reference/pdf/">spring-framework-reference.pdf</a></li>
	<li><a href="http://mybatis.github.io/mybatis-3/getting-started.html">MyBatis Getting started</a></li>
</ul>

