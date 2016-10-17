<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>게시판 댓글</h1>

<h2>댓글 쓰기</h2>
<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/addCcomment", method=RequestMethod.POST)
public String addComment(Integer articleNo, 
		String boardCd, 
		Integer curPage, 
		String searchWord, 
		String memo) throws Exception {
		
	Comment comment = new Comment();
	comment.setArticleNo(articleNo);
	comment.setEmail("hong@gmail.org");//임시로 지정
	comment.setMemo(memo);
	
	boardService.addComment(comment);
	
	searchWord = URLEncoder.encode(searchWord,"UTF-8");
	
	return "redirect:/bbs/view?articleNo=" + articleNo + 
		"&amp;boardCd=" + boardCd + 
		"&amp;curPage=" + curPage + 
		"&amp;searchWord=" + searchWord;

}	
</pre>

<h2>댓글 수정</h2>

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/updateComment", method=RequestMethod.POST)
public String updateComment(Integer commentNo, 
		Integer articleNo, 
		String boardCd, 
		Integer curPage, 
		String searchWord, 
		String memo) throws Exception {
		
	Comment comment = boardService.getComment(commentNo);
	comment.setMemo(memo);
	boardService.modifyComment(comment);
	
	searchWord = URLEncoder.encode(searchWord,"UTF-8");
	
	return "redirect:/bbs/view?articleNo=" + articleNo + 
		"&amp;boardCd=" + boardCd + 
		"&amp;curPage=" + curPage + 
		"&amp;searchWord=" + searchWord;

}
</pre>

<h2>댓글 삭제</h2>
<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/deleteComment", method=RequestMethod.POST)
public String deleteComment(Integer commentNo, 
		Integer articleNo, 
		String boardCd, 
		Integer curPage, 
		String searchWord) throws Exception {
		
	Comment comment = boardService.getComment(commentNo);
	boardService.removeComment(comment);
	
	searchWord = URLEncoder.encode(searchWord,"UTF-8");
	
	return "redirect:/bbs/view?articleNo=" + articleNo + 
		"&amp;boardCd=" + boardCd + 
		"&amp;curPage=" + curPage + 
		"&amp;searchWord=" + searchWord;

}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
</ul>

