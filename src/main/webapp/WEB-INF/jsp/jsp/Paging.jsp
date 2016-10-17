<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.7.15</div>


<h1>페이징 로직 재사용</h1>

자바 프로그래머는 자신이 만든 클래스가 재사용될 수 있도록 만들어야 한다.<br />
웹 프로그램에서 가장 많이 사용되는 로직이 페이징 처리이다.<br />
이번 글에서는 페이징 처리 로직 재사용이 "좀더" 편리하도록 시도해 본다.<br />
이제까지 사용했던 PagingHelper 클래스는 버린다.<br />

<em class="filename">Paginator.java</em>
<pre class="prettyprint">
package net.java_school.commons;

import java.util.List;

public class Paginator&lt;T&gt; {
	private int prevLink;
	private int firstPage;
	private int lastPage;
	private int nextLink;
	private int totalPage;
	private int listNo;
	private List&lt;T&gt; list;
	
	public Paginator(int totalRecord, 
			int curPage, 
			int numPerPage, 
			int pagePerBlock) {
		
		if (totalRecord % numPerPage == 0) {
			this.totalPage = totalRecord / numPerPage;
		} else {
			this.totalPage = totalRecord / numPerPage + 1;
		}
		int totalBlock = 1;
		if (totalPage % pagePerBlock == 0) {
			totalBlock = totalPage / pagePerBlock; 
		} else {
			totalBlock = totalPage / pagePerBlock + 1;
		}
		int block = 1;
		if (curPage % pagePerBlock == 0) {
			block = curPage / pagePerBlock;
		} else {
			block = curPage / pagePerBlock + 1;
		}
		
		this.firstPage = (block - 1) * pagePerBlock + 1;
		this.lastPage = block * pagePerBlock;
		
		if (block &gt;= totalBlock) {
			this.lastPage = totalPage;
		}
		
		if (block &gt; 1) {
			this.prevLink = firstPage - 1;
		}
		
		if (block &lt; totalBlock) {
			this.nextLink = lastPage + 1;
		}
		
		this.listNo = totalRecord - (curPage - 1) * numPerPage;
	}
	
	public int getPrevLink() {
		return prevLink;
	}
	public int getFirstPage() {
		return firstPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public int getNextLink() {
		return nextLink;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getListNo() {
		return listNo;
	}
	public List&lt;T&gt; getList() {
		return list;
	}
	public void setList(List&lt;T&gt; list) {
		this.list = list;
	}

}
</pre>

아래는 위에서 소개한 페이징 처리 재사용을 위한 클래스와 인터페이스를 사용하는 서비스 클래스이다.<br />

<em class="filename">BoardService.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.ArrayList;

import net.java_school.commons.Paginator;

public class BoardService {
	
	private BoardDao dao = new BoardDao();
	
	public Paginator&lt;Article&gt; getPaginator(int curPage, 
					String keyword, 
					int numPerPage, 
					int pagePerBlock) {
			
		int start = (curPage - 1) * numPerPage + 1;
		int end = curPage * numPerPage;
		ArrayList&lt;Article&gt; list = dao.getBoardList(start, end, keyword);
		int totalRecord = dao.getTotalRecord(keyword);
		Paginator&lt;Article&gt; paginator = 
			new Paginator&lt;Article&gt;(totalRecord, curPage, numPerPage, pagePerBlock);
		paginator.setList(list);
		
		return paginator;
	}
	
	public void write(Article article) {
		dao.insert(article);
	}
	public Article getArticle(int no) {
		return dao.selectOne(no);
	}
	public void modify(Article article) {
		dao.update(article);
	}
	public void delete(int articleNo) {
		dao.delete(articleNo);
	}
	public void reply(Article article) {
		dao.reply(article);
	}
	
}	
</pre>

<em class="filename">ListAction 수정</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;
import net.java_school.commons.Paginator;

public class ListAction implements Action {
	@Override
	public void execute(HttpServletRequest request) {
		int curPage = (request.getParameter("curPage") == null  ? 1 : 
			Integer.parseInt(request.getParameter("curPage")));
			
		String keyword = request.getParameter("keyword");
		if (keyword == null) keyword = "";
		
		BoardService service = new BoardService();

		// numPerPage 를 10, pagePerBlock 를 5 로 설정한다면
		Paginator&lt;Article&gt; paginator = service.getPaginator(curPage, keyword, 10, 5);
		
		ArrayList&lt;Article&gt; list = (ArrayList&lt;Article&gt;) paginator.getList();
		int listNo = paginator.getListNo();
		int prevLink = paginator.getPrevLink();
		int firstPage = paginator.getFirstPage();
		int lastPage = paginator.getLastPage();
		int nextLink = paginator.getNextLink();
		
		ListVo vo = new ListVo();
		vo.setList(list);
		vo.setListNo(listNo);
		vo.setPrevLink(prevLink);
		vo.setNextLink(nextLink);
		vo.setFirstPage(firstPage);
		vo.setLastPage(lastPage);
		
		request.setAttribute("listVo", vo);
		
	}
}
</pre>

/model2/list.jsp 파일은 바꿀 필요가 없다.<br />
재사용에 어는 것이 더 좋은지 판단의 각자의 몫이다.<br />
좀더 재사용에 좋은 페이징 소스를 만드는 시도는 좋은 공부가 될 것이다.<br />
