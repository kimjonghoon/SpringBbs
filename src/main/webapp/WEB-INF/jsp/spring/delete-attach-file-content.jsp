<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>게시판 - 첨부파일 삭제</h1>

BbsController.java 에 첨부파일 삭제를 위한 메소드를 아래와 같이 추가한다.<br />

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/deleteAttachFile", method=RequestMethod.POST)
public String deleteAttachFile(Integer attachFileNo, 
		Integer articleNo, 
		String boardCd, 
		Integer curPage, 
		String searchWord) throws Exception {
	
	AttachFile attachFile = boardService.getAttachFile(attachFileNo);
	boardService.removeAttachFile(attachFile);
	
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

