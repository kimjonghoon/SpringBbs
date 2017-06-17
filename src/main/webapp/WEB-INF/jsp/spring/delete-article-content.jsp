<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>게시판 - 게시글 삭제</h1>

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/del", method=RequestMethod.POST)
public String del(Integer articleNo, 
		String boardCd, 
		Integer page, 
		String searchWord) throws Exception {
	
	Article article = boardService.getArticle(articleNo);
	boardService.removeArticle(article);
		
	searchWord = URLEncoder.encode(searchWord, "UTF-8");
	
	return "redirect:/bbs/list?boardCd=" + boardCd + 
		"&amp;page=" + page + 
		"&amp;searchWord=" + searchWord;

}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
</ul>

