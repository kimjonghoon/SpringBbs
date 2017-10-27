<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.5.21</div>

<h1>뷰 레벨 보안</h1>

게시글 보기 화면에서 글 소유자가 아닌 사용자가 아래 그림에서 박스로 강조된 메뉴를 봐서는 안된다.<br />

<img alt="Before applying spring security at viewlayer" src="https://lh3.googleusercontent.com/7mUut6ifJQxxowLptysUi0z7rSY9nrsPwQr5J_HkZosjh-lU1te9649PhrqwYkIkeu67pVv0iZB2PND5iz7w1ihp2XyboTnFykXFs2p4F1eztyI6dH_lhovjeHqhfZ4DDhqQ_XpvDSebDg7f0HzALTTYWR7z1VrTvFwKzMzAV5CTvcf4v5m9LMfgKyeDWdeDyAo4g_ijmp0NGRN8bKJ-KLVbrJzYM7bpf08us-RzZHrUHK6kBvC1Xv4EEGyDR3nEEgb1yZwDsz-o7kHgM2tV56VBpfkaY6AzNdBZQaKar5SruS4QxGd4NPF3go_D8z6SJjoOkmL_jSneQELDqVQnQ05JuypuoPlWpirJr4ahJWcqVsTY9sD7DdJOhcUupYIHoammu7VZUgiAejhVd0-AqwD0IDo5UoTj1Gd9QtDX5yTd2hd5YKUKp4zvTX6yaLANNUbLoFp9hpHg2e36qdqE5LDxsFpkSCqBlYRlqWfBVFbAIaJLXN809Sh8gonAGY0fG8ChUeU6y_5MyjXu28c3gHo0zIeXptsXwOp8Dwga2-n_KQJ5hvQhWLm9ioNAHWLRMADOC903y2zoljR6MqXQPOjPxqNzNOg=w590-h488-no"><br />
<br />
<em class="filename">/WEB-INF/views/bbs/view.jsp</em>
<pre class="prettyprint">
&lt;!-- 중간 생략 --&gt;

<strong>&lt;%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %&gt;</strong>

&lt;!-- 중간 생략 --&gt;

&lt;div id="gul-content"&gt;
    &lt;span id="date-writer-hit"&gt;edited ${regdate } by ${name } hit ${hit }&lt;/span&gt;
    &lt;p&gt;${content }&lt;/p&gt;
    &lt;p id="file-list" style="text-align: right;"&gt;
        &lt;c:forEach var="file" items="${attachFileList }" varStatus="status"&gt;
        &lt;a href="javascript:download('${file.filename }')"&gt;${file.filename }&lt;/a&gt;
        <strong>&lt;security:authorize access="#email == principal.username or hasRole('ROLE_ADMIN')"&gt;</strong>
            &lt;a href="javascript:deleteAttachFile('${file.attachFileNo }')"&gt;x&lt;/a&gt;
        <strong>&lt;/security:authorize&gt;</strong>
        &lt;br /&gt;
        &lt;/c:forEach&gt;	
    &lt;/p&gt;		
&lt;/div&gt;

&lt;!--  댓글 반복 시작 --&gt;
&lt;c:forEach var="comment" items="${commentList }" varStatus="status"&gt;	
&lt;div class="comments"&gt;
    &lt;span class="writer"&gt;${comment.name }&lt;/span&gt;
    &lt;span class="date"&gt;${comment.regdate }&lt;/span&gt;
    <strong>&lt;security:authorize access="#comment.email == principal.username or hasRole('ROLE_ADMIN')"&gt;</strong>
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:updateComment('${comment.commentNo }')"&gt;수정&lt;/a&gt; |
        &lt;a href="javascript:deleteComment('${comment.commentNo }')"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
    <strong>&lt;/security:authorize&gt;</strong>

&lt;!-- 중간 생략 --&gt;

&lt;div id="view-menu"&gt;
    <strong>&lt;security:authorize access="#email == principal.username or hasRole('ROLE_ADMIN')"&gt;</strong>
    &lt;div class="fl"&gt;
        &lt;input type="button" value="수정" onclick="goModify();" /&gt;
        &lt;input type="button" value="삭제" onclick="goDelete()" /&gt;
    &lt;/div&gt;
    <strong>&lt;/security:authorize&gt;</strong>

&lt;!-- 중간 생략 --&gt;
</pre>

이미 수정한 header.jsp 파일 역시 스프링 시큐리티 태그를 사용하여 뷰가 선별적으로 랜더링된다.<br />
<em class="filename">/WEB-INF/views/inc/header.jsp</em>
<pre class="prettyprint">
&lt;!-- 중간 생략 --&gt;

<strong>&lt;%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %&gt;</strong>

&lt;!-- 중간 생략 --&gt;

<strong>&lt;security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')"&gt;
    &lt;security:authentication property="principal.username" var="<strong>check</strong>" /&gt;
&lt;/security:authorize&gt;</strong>
&lt;c:choose&gt;
    &lt;c:when test="${empty check}"&gt;
        &lt;input type="button" value="로그인" onclick="location.href='../users/login'" /&gt;
        &lt;input type="button" value="회원가입" onclick="location.href='../users/signUp'" /&gt;
    &lt;/c:when&gt;
    &lt;c:otherwise&gt;
        &lt;input type="button" value="로그아웃" onclick="location.href='../j_spring_security_logout'" /&gt;
        &lt;input type="button" value="내정보수정" onclick="location.href='../users/editAccount'" /&gt;
    &lt;/c:otherwise&gt;
&lt;/c:choose&gt;
&lt;/div&gt;
</pre>



<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://dhappy.net/?p=260">Error creating bean with name 'sqlSessionFactory' 구글 검색(spring-mybatis 1.1.1로 교체)</a></li>
	<li><a href="http://stackoverflow.com/questions/10421588/spring-security-not-working-what-am-i-doing-wrong">시큐리티가 작동하지 않을 때는 web.xml 파일에 스프링 시큐리티에 대한 설정을 검사해야 한다.</a></li>
	<li><a href="http://static.springsource.org/spring-security/site/faq/faq.html#faq-method-security-in-web-context">컨트롤러보다는 서비스에 시큐리티 적용 권고</a></li>
	<li><a href="http://stackoverflow.com/questions/3087548/can-spring-security-use-preauthorize-on-spring-controllers-methods">컨트롤러에 시큐리티 적용-테스트 실패</a></li>
	<li><a href="http://www.hanb.co.kr/book/look.html?isbn=978-89-7914-887-9#binfo5">예제로 쉽게 배우는 스프링 프레임워크 3.0(한빛미디어) - 사카타 코이치</a></li>
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
</ul>

