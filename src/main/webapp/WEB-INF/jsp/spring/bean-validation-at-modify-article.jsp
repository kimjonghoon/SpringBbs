<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.5.22</div>

<h1>글 수정에서의 빈 유효성 검사</h1>


<em class="filename">BbsController.java</em>
<pre class="prettyprint">
//게시글 수정 처리
@RequestMapping(value="/modify", method=RequestMethod.POST)
public String modify(@Valid Article article,
        BindingResult bindingResult,
        Integer page,
        String searchWord,
        Model model,
        MultipartHttpServletRequest mpRequest) throws Exception {
        
    if (bindingResult.hasErrors()) {
        String boardNm = boardService.getBoardNm(article.getBoardCd());
        model.addAttribute("boardNm", boardNm);

        return "bbs/modify_form";
    }

    //관리자가 수정하더라도 글 소유자를 유지
    String email = boardService.getArticle(article.getArticleNo()).getEmail();
    article.setEmail(email);

    boardService.modifyArticle(article);

    //파일 업로드 -기존과 같음..

    //파일데이터 삽입 중 setArticleNo(articleNo)를 setArticleNo(article.getArticleNo())로

    searchWord = URLEncoder.encode(searchWord, "UTF-8");
    
    return "redirect:/bbs/view?articleNo=" + article.getArticleNo() +
        "&amp;boardCd=" + article.getBoardCd() +
        "&amp;page=" + page +
        "&amp;searchWord=" + searchWord
}
</pre>

<em class="filename">modify_form.jsp</em>
<pre class="prettyprint">
<strong>
&lt;%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %&gt;

&lt;sf:form id="modifyForm" action="modify" method="post" commandName="article" 
        enctype="multipart/form-data" onsubmit="return check()"&gt;</strong>
&lt;p style="margin: 0;padding: 0;"&gt;
    &lt;input type="hidden" name="articleNo" value="${param.articleNo }" /&gt;
    &lt;input type="hidden" name="boardCd" value="${param.boardCd }" /&gt;
    &lt;input type="hidden" name="page" value="${param.page }" /&gt;
    &lt;input type="hidden" name="searchWord" value="${param.searchWord }" /&gt;
&lt;/p&gt;
<strong>&lt;sf:errors path="*" cssClass="error" /&gt;</strong>
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:input path="title" style="width: 90%" value="${article.title }" /&gt;&lt;br /&gt;
        &lt;sf:errors path="title" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;${article.content }&lt;/textarea&gt;&lt;br /&gt;
        <strong>&lt;sf:errors path="content" cssClass="error" /&gt;</strong>
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

