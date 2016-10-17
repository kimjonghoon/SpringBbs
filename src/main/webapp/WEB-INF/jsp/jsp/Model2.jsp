<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.7.22</div>

			
<h1>모델 2</h1>

모델 1은 JSP 에서 자바빈즈를 사용하는 구조를 말한다.<br />
모델 2는 모델 1에 컨트롤러가 추가된다.<br />
컨트롤러는 뷰(JSP)와 비즈니스 로직을 담당하는 모델(자바빈즈) 사이에서 다리 역할을 한다.<br />
모델 2의 프로세스를 정리하면 다음과 같다.
<ol>
	<li>모든 요청은 컨트롤러에 전달된다.</li>
	<li>컨트롤러는 모델에 작업을 위임한다.(여기서 모델이란 비즈니스 로직을 담당하는 자바빈즈를 말한다.
	작업을 위임할 때 요청객체를 모델에 전달하는데 여기에 클라이언트가 보낸 정보가 있기 때문이다.)</li>
	<li>모델은 작업을 완료한 다음 컨트롤러에게 결과를 전달한다.(모델은 결과를 요청객체에 저장하는 것으로 이 역할을 수행한다.)</li>
	<li>컨트롤러는 결과물을 JSP 전달하여 최종적으로 클라이언트의 요청에 서버스하도록 한다.(컨트롤러는 forward() 메소드를 사용하여 이 역할을 수행한다.)</li>
</ol>
다음 소스는 컨트롤러에 대한 힌트를 제공한다.

<em class="filename">ControllerServlet.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class ControllerServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
    	throws ServletException, IOException {
		doPost(req,resp);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
    	throws ServletException, IOException {
    
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = null;
		command = uri.substring(contextPath.length());
		
		PrintWriter out = resp.getWriter();
		out.println(command);
		out.close();
	}
	
}
</pre>

새로운 서블릿을 만들었으니 web.xml 에 등록한다.

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
   &lt;servlet-name&gt;Controller&lt;/servlet-name&gt;
   &lt;servlet-class&gt;net.java_school.board.ControllerServlet&lt;/servlet-class&gt;
   &lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
   &lt;servlet-name&gt;Controller&lt;/servlet-name&gt;
   &lt;url-pattern&gt;*.do&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

톰캣를 재시작한 다음<br />
http://localhost:8989/list.do,<br />
http://localhost:8989/board/list.do,<br />
http://localhost:8989/board/view.do,<br />
http://localhost:8989/write_form.do,<br />
http://localhost:8989/modify_form.do를 차례로 방문하여 테스트한다.<br />

<h3>모델 만들기</h3>
모델에 해당하는 클래스는 Action 으로 이름이 끝나도록 한다.<br />
(Struts2 프레임워크가 모델에 이런 이름을 사용한다.)<br />
게시판을 모델 2 게시판으로 수정할 것인데 여기서는 목록만 구현할 것이다.<br />
나머지는 여러분의 몫이다.<br />

게시판 목록에 대해서 모델이 해야 할 일은 
페이지의 레코드에 프로그래밍적으로 붙여지는 번호,
페이지에서 보일 결과셋과 [이전]에 해당하는 번호, 첫번째 페이지 번호, 마지막 페이지 번호, [다음]에 해당하는 번호를 구하는 것이다.<br />

목록액션 클래스가 목록과 관련된 데이터를 구하는 메소드의 이름을 execute()라고 하겠다. 이 역시 Struts2 에서 액션 클래스에서 사용하는 이름이다.<br />

<em class="filename">ListAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

public class ListAction {
	public void execute(HttpServletRequest request) {
		//TODO
	}
}
</pre>

execute()메소드의 구현부는 우리가 이미 구현한 소스를 참조하여 //TODO 를 완료한다.<br />

<em class="filename">ListAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.java_school.commons.PagingHelper;

public class ListAction {
	public void execute(HttpServletRequest request) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		int curPage = (request.getParameter("curPage") == null  ? 1 : 
			Integer.parseInt(request.getParameter("curPage")));
		String keyword = request.getParameter("keyword");
		if (keyword == null) keyword = "";
		BoardDao dao = new BoardDao();
		int totalRecord = dao.getTotalRecord(keyword);
		PagingHelper pagingHelper = new PagingHelper(totalRecord,curPage,10,5);
		int startRecord = pagingHelper.getStartRecord();
		int endRecord = pagingHelper.getEndRecord();
		ArrayList&lt;Article&gt; list = dao.getBoardList(startRecord, endRecord, keyword);
		request.setAttribute("pagingHelper", pagingHelper);
		request.setAttribute("list", list);
	}
}
</pre>

request.setCharacterEncoding("UTF-8"); 이 부분의 코드는 컨트롤러에서 요청을 받은 다음에 수행하도록 하면 ListAction과 컨트롤러는 다음과 같이 변경된다.

<em class="filename">ListAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.java_school.commons.PagingHelper;

public class ListAction {
	public void execute(HttpServletRequest request) {
		int curPage = (request.getParameter("curPage") == null  ? 1 : 
			Integer.parseInt(request.getParameter("curPage")));
		String keyword = request.getParameter("keyword");
		if (keyword == null) keyword = "";
		BoardDao dao = new BoardDao();
		int totalRecord = dao.getTotalRecord(keyword);
		PagingHelper pagingHelper = new PagingHelper(totalRecord,curPage,10,5);
		int startRecord = pagingHelper.getStartRecord();
		int endRecord = pagingHelper.getEndRecord();
		ArrayList&lt;Article&gt; list = dao.getBoardList(startRecord, endRecord, keyword);
		request.setAttribute("pagingHelper", pagingHelper);
		request.setAttribute("list", list);
	}
}
</pre>

<em class="filename">ControllerServlet.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class ControllerServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		doPost(req,resp);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
		throws ServletException, IOException {
		
		<strong>req.setCharacterEncoding("UTF-8");</strong>
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = null;
		command = uri.substring(contextPath.length());
		
		PrintWriter out = resp.getWriter();
		out.println(command);
		out.close();
	}
	
}
</pre>

서블릿이 클라이언트의 게시판에 대한 목록 요청과 관련된 코드를 구현한다.

<em class="filename">ControllerServlet.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class ControllerServlet extends HttpServlet {

	private static final long serialVersionUID = 4024375917229853991L;

	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		doPost(req,resp);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
    
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = null;
		command = uri.substring(contextPath.length());
		<strong>
		String view = null; //JSP
		boolean isRedirect = false; //리다이렉트 또는 포워딩 여부
		if (command.equals("/model2/list.do")) {
			ListAction listAction = new ListAction();
			listAction.execute(req);
			view = "/model2/list.jsp";
		}
		if (isRedirect == false) {
			ServletContext sc = this.getServletContext();
			RequestDispatcher rd = sc.getRequestDispatcher(view);
			rd.forward(req, resp);
		} else {
			resp.sendRedirect(view);
		}
		</strong>
	}
	
}
</pre>

/model2 디렉토리를 만들고 /model1 디렉토리에 있는 모든 JSP 파일을  복사하여 붙여넣는다.

/model2/list.jsp 파일을 변경한다.

<em class="filename">/model2/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;
&lt;%
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");
int bbsNo = (Integer) request.getAttribute("listNo");
ArrayList&lt;Article&gt; list = (ArrayList&lt;Article&gt;) request.getAttribute("list");
int prevLink = (Integer) request.getAttribute("prevLink");
int nextLink = (Integer) request.getAttribute("nextLink");
int firstPage = (Integer) request.getAttribute("firstPage");
int lastPage = (Integer) request.getAttribute("lastPage");
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;목록&lt;/title&gt;
&lt;/head&gt;
&lt;body style="font-size: 11px;"&gt;
&lt;h1&gt;목록&lt;/h1&gt;
&lt;%
//int bbsNo = service.getListNo();
for (int i = 0; i &lt; list.size(); i++) {
	Article article = list.get(i);
	int indent = article.getIndent();
	for (int j = 0; j &lt; indent; j++) {
		out.println("&nbsp;&nbsp;");
	}
	if(indent != 0) {
		out.println("ㄴ");
	}
%&gt;
&lt;%=bbsNo %&gt;
&lt;a href="view.do?no=&lt;%=article.getNo() %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;&lt;%=article.getTitle() %&gt;&lt;/a&gt;
&lt;%=article.getWriteDate() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
bbsNo--;
}
//int prevLink = service.getPrevLink();
if (prevLink != 0) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=prevLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[이전]&lt;/a&gt;
&lt;%
}
//int firstPage = service.getFirstPage();
//int lastPage = service.getLastPage();
for (int i = firstPage; i &lt;= lastPage; i++) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=i %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
&lt;%
}
//int nextLink = service.getNextLink();
if (nextLink != 0) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=nextLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[다음]&lt;/a&gt;
&lt;%
}
%&gt;				
&lt;p&gt;
&lt;a href="write_form.do?curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;글쓰기&lt;/a&gt;
&lt;/p&gt;
&lt;form action="list.do" method="post"&gt;
	&lt;input type="text" size="10" maxlength="30" name="keyword" /&gt;
	&lt;input type="submit" value="Search" /&gt;
&lt;/form&gt;	
&lt;/body&gt;
&lt;/html&gt;
</pre>

http://localhost:8989/model2/list.do를 방문하여 테스트한다.<br />

먼저 만족스러운 코드가 되도록 수정해 보자.<br />
list.jsp 코드는 이제 자신이 보여줄 결과물만을 전달받는다.<br />
그런데 list.jsp 아래 부분의 코드가 마음에 들지 않는다.<br />

<pre class="prettyprint">
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");
int bbsNo = (Integer) request.getAttribute("listNo");
ArrayList&lt;Article&gt; list = (ArrayList&lt;Article&gt;) request.getAttribute("list");
int prevLink = (Integer) request.getAttribute("prevLink");
int nextLink = (Integer) request.getAttribute("nextLink");
int firstPage = (Integer) request.getAttribute("firstPage");
int lastPage = (Integer) request.getAttribute("lastPage");
</pre>

형변환도 까다롭다.
그래서 모델은 결과 데이터를 저장하는 Value Object(VO) 나 Data Transter Object(DTO) 라고 불리는 패턴을 사용한다.

<em class="filename">ListVo</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.ArrayList;

public class ListVo {	
	private ArrayList&lt;Article&gt; list;
	private int listNo;
	private int prevLink;
	private int firstPage;
	private int lastPage;
	private int nextLink;
	
	public ArrayList&lt;Article&gt; getList() {
		return list;
	}
	public void setList(ArrayList&lt;Article&gt; list) {
		this.list = list;
	}
	public int getListNo() {
		return listNo;
	}
	public void setListNo(int listNo) {
		this.listNo = listNo;
	}
	public int getPrevLink() {
		return prevLink;
	}
	public void setPrevLink(int prevLink) {
		this.prevLink = prevLink;
	}
	public int getFirstPage() {
		return firstPage;
	}
	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getNextLink() {
		return nextLink;
	}
	public void setNextLink(int nextLink) {
		this.nextLink = nextLink;
	}
	
}
</pre>

ListAction이 방금 생성한 VO 를 사용하도록 코드를 수정한다.

<em class="filename">ListAction</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

public class ListAction {
	public void execute(HttpServletRequest request) {
		int curPage = (request.getParameter("curPage") == null  ? 1 : 
			Integer.parseInt(request.getParameter("curPage")));
		String keyword = request.getParameter("keyword");
		if (keyword == null) keyword = "";
		BoardService service = new BoardService(curPage, keyword, 10, 5);
		
		ArrayList&lt;Article&gt; list = service.getBoardList();
		int listNo = service.getListNo();
		int prevLink = service.getPrevLink();
		int firstPage = service.getFirstPage();
		int lastPage = service.getLastPage();
		int nextLink = service.getNextLink();
		
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

list.jsp 파일을 수정한다.

<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;
&lt;%
String curPage = request.getParameter("curPage");
<strong>if (curPage == null) curPage = "1";</strong>
String keyword = request.getParameter("keyword");
ListVo vo = (ListVo)request.getAttribute("listVo");
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;목록&lt;/title&gt;
&lt;/head&gt;
&lt;body style="font-size: 11px;"&gt;
&lt;h1&gt;목록&lt;/h1&gt;
&lt;%
//int bbsNo = service.getListNo();
int bbsNo = vo.getListNo();
ArrayList&lt;Article&gt; list = vo.getList();
for (int i = 0; i &lt; list.size(); i++) {
	Article article = list.get(i);
	int indent = article.getIndent();
	for (int j = 0; j &lt; indent; j++) {
		out.println("&nbsp;&nbsp;");
	}
	if(indent != 0) {
		out.println("ㄴ");
	}
%&gt;
&lt;%=bbsNo %&gt;
&lt;a href="view.do?no=&lt;%=article.getNo() %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;&lt;%=article.getTitle() %&gt;&lt;/a&gt;
&lt;%=article.getWriteDate() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
bbsNo--;
}
//int prevLink = service.getPrevLink();
int prevLink = vo.getPrevLink();
if (prevLink != 0) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=prevLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[이전]&lt;/a&gt;
&lt;%
}
//int firstPage = service.getFirstPage();
//int lastPage = service.getLastPage();
int firstPage = vo.getFirstPage();
int lastPage = vo.getLastPage();
for (int i = firstPage; i &lt;= lastPage; i++) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=i %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
&lt;%
}
//int nextLink = service.getNextLink();
int nextLink = vo.getNextLink();
if (nextLink != 0) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=nextLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[다음]&lt;/a&gt;
&lt;%
}
%&gt;				
&lt;p&gt;
&lt;a href="write_form.do?curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;글쓰기&lt;/a&gt;
&lt;/p&gt;
&lt;form action="list.do" method="post"&gt;
	&lt;input type="text" size="10" maxlength="30" name="keyword" /&gt;
	&lt;input type="submit" value="Search" /&gt;
&lt;/form&gt;	
&lt;/body&gt;
&lt;/html&gt;
</pre>

액션 인터페이스를 만들어서 액션 적용시키면 컨트롤러에서의 코드가 우아해 진다.

<em class="filename">Action.java</em>
<pre class="prettyprint">
package net.java_school.action;

import javax.servlet.http.HttpServletRequest;

public interface Action {
	public void execute(HttpServletRequest request);
}
</pre>

액션 인터페이스를 구현하도록 ListAction 을 수정한다.

<em class="filename">ListAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class ListAction implements Action {
	@Override
	public void execute(HttpServletRequest request) {
	
	//이하 코드는 이전과 같다.
	
	}
}
</pre>

컨트롤러를 수정한다.

<em class="filename">ControllerServlet.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.*;
import javax.servlet.http.*;

import net.java_school.action.Action;

import java.io.*;

public class ControllerServlet extends HttpServlet {

	private static final long serialVersionUID = 4024375917229853991L;
	private ServletContext sc;
	
	@Override
	public void init() throws ServletException {
		sc = this.getServletContext();
	}

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
			
		req.setCharacterEncoding("UTF-8");//요청 캐릭터셋을 UTF-8로 설정하는 필터 예제가 동작한다면 주석처리한다.
		String uri = req.getRequestURI();	
		String contextPath = req.getContextPath();
		String command = null;
		command = uri.substring(contextPath.length());
		
		String view = null; //JSP
		Action action = null;
		boolean isRedirect = false; //true 면 리다이렉트, false 면 포워딩
		if (command.equals("/model2/list.do")) {
			action = new ListAction();
			action.execute(req);
			view = "/model2/list.jsp";
		} else if (command.equals("/model2/write_form.do")) {
			//TODO 1
		} else if (command.equals("/model2/write.do")) {
			//TODO 2
		} else if (command.equals("/model2/view.do")) {
			//TODO 3
		} else if (command.equals("/model2/modify_form.do")) {
			//TODO 4
		} else if (command.equals("/model2/modify.do")) {
			//TODO 5 
		} else if (command.equals("/model2/del.do")) {
			//TODO 6
		} else if (command.equals("/model2/reply_form.do")) {
			//TODO 7
		} else if (command.equals("/model2/reply.do")) {
			//TODO 8
		}
		if (isRedirect == false) {
			RequestDispatcher rd = sc.getRequestDispatcher(view);
			rd.forward(req, resp);
		} else {
			resp.sendRedirect(view);
		}
		
	}
	
}
</pre>

//TODO 를 작성한다.

<h3>//TODO 1</h3>
이 부분은 다음과 같이 구현한다.<br />

<pre class="prettyprint">
view = "/model2/write_form.jsp";
</pre>

글쓰기 화면인 write_form.jsp 로 단순히 포워딩하면 된다.<br />
왜냐하면 write_form.jsp 포워딩하기 전에 전처리하여 전달하여야 할 데이터가 없기 때문이다.<br />
write_form.jsp 파일을 열고 코드에 .jsp 를 모두 .do 로 수정한다.<br />
목록을 방문한 후 글쓰기를 클릭하여 글쓰기 화면으로 이동하는지 확인한다.<br />

<h3>//TODO 2</h3>
이 부분은 다음과 같이 구현한다.<br />

<pre class="prettyprint">
action = new WriteAction();
action.execute(req);
view = "/model2/list.do";
isRedirect = true;
</pre>

WriteAction.java 를 작성해야 한다.<br />
이 모델은 글쓰기를 처리하는 로직을 담당해야 한다.<br />
기존의 write.jsp 파일을 참고하여 만들면 된다.<br />

<em class="filename">WriteAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class WriteAction implements Action{

	@Override
	public void execute(HttpServletRequest request) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		Article article = new Article();
		article.setTitle(title);
		article.setContent(content);
		
		BoardService service= new BoardService();
		service.write(article);
	}

}
</pre>

글쓰기를 테스트한다.<br />
테스트 후에 모델1에서 글쓰기 처리를 담당했던 write.jsp 파일은 필요없으니 /model2 디렉토리에서 삭제한다.<br />


<h3>//TODO 3</h3>
이 부분은 다음과 같이 구현한다.<br />

<pre class="prettyprint">
action = new ViewAction();
action.execute(req);
view = "/model2/view.jsp";
</pre>

ViewAction.java 는 상세보기 로직을 담당해야 한다.<br />

<em class="filename">ViewAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class ViewAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {
		int no = Integer.parseInt(request.getParameter("no"));
		BoardService service = new BoardService();
		
		Article article = service.getArticle(no);
		
		request.setAttribute("article", article);
		
	}

}
</pre>

이제 뷰에 해당하는 view.jsp 를 수정한다.<br />
뷰는 모델이 전처리한 후 전달한 데이터를 보여주는 역할만 하도록 수정해야 한다.<br />
view.jsp 파일을 열고 코드에 있는 .jsp 를 모두 .do 로 수정한다.<br />
또한 강조된 부분을 참고하여 수정한다.<br />

<em class="filename">view.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");
if (keyword == null) keyword = "";
<strong>Article article = (Article) request.getAttribute("article");</strong>
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;상세보기&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no,curPage,keyword) {
	location.href="modify_form.do?no=" + no + "&amp;curPage=" + curPage + "&amp;keyword=" + keyword;
}

function goDelete(no,curPage,keyword) {
	var check = confirm("정말로 삭제하겠습니까?");
	if (check) {
		location.href="del.do?no=" + no + "&amp;curPage=" + curPage + "&amp;keyword=" + keyword;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;상세보기&lt;/h1&gt;
&lt;h2&gt;제목: &lt;%=article.getTitle() %&gt;, 작성일: &lt;%=article.getWriteDate() %&gt;&lt;/h2&gt;
&lt;p&gt;
&lt;%=article.getHtmlContent() %&gt;
&lt;/p&gt;
&lt;a href="list.do?curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;목록&lt;/a&gt;
&lt;input type="button" value="수정" onclick="javascript:goModify('&lt;%=no %&gt;','&lt;%=curPage %&gt;','&lt;%=keyword %&gt;')"&gt;
&lt;input type="button" value="삭제" onclick="javascript:goDelete('&lt;%=no %&gt;','&lt;%=curPage %&gt;','&lt;%=keyword %&gt;')"&gt;
&lt;a href="reply_form.do?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;답변쓰기&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>//TODO 4</h3>
이부분은 다음과 같이 구현한다.<br />

<pre class="prettyprint">
action = new ModifyFormAction();
action.execute(req);
view = "/model2/modify_form.jsp";
</pre>

ModifyFormAction.java 를 만든다.<br />
modify_form.jsp 를 참고하여 만든다.<br />

<em class="filename">ModifyFormAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class ModifyFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {
		int no = Integer.parseInt(request.getParameter("no"));
		BoardService service = new BoardService();
		Article article = service.getArticle(no);
		request.setAttribute("article", article);
	}

}
</pre>

modify_form.jsp 파일을 열고 .jsp 를 모두 .do 로 수정한다.<br />
그리고 강조된 부분을 참고하여 수정한다.<br />

<em class="filename">modify_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");
<strong>Article article = (Article) request.getAttribute("article");</strong>
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;수정&lt;/h1&gt;
&lt;form action="modify.do" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;"&gt;
&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=article.getTitle() %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=article.getContent() %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="view.do?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;상세보기&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h5>//TODO 5</h5>
이 부분은 다음가 같이 구현한다.<br />

<pre class="prettyprint">
action = new ModifyAction();
action.execute(req);
String no = req.getParameter("no");
String curPage = req.getParameter("curPage");
String keyword = req.getParameter("keyword");
if (keyword == null) keyword = "";
keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
view = "/model2/view.do?no=" + no + "&amp;curPage=" + curPage + "&amp;keyword=" + keyword;
isRedirect = true;
</pre>

ModifyAction.java 를 만든다.<br />
modify.jsp 파일을 참고한다.<br />

<em class="filename">ModifyAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class ModifyAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {

		int no = Integer.parseInt(request.getParameter("no"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		Article article = new Article();
		article.setNo(no);
		article.setTitle(title);
		article.setContent(content);

		BoardService service= new BoardService();
		service.modify(article);
		
	}

}
</pre>

수정을 테스트한다.<br />
이젠 모델1의 modify.jsp 파일을 필요없으니 삭제한다.<br />

<h3>//TODO 6</h3>
이 부분은 다음과 같이 구현한다.<br />

<pre class="prettyprint">
action = new DeleteAction();
action.execute(req);
String curPage = req.getParameter("curPage");
String keyword = req.getParameter("keyword");
if (keyword == null) keyword = "";
keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
view = "/model2/list.do?curPage=" + curPage + "&amp;keyword=" + keyword;
isRedirect = true;
</pre>

del.jsp 파일을 참고하여 DeleteAction.java 를 만든다.<br />

<em class="filename">DeleteAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class DeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {
		int no = Integer.parseInt(request.getParameter("no"));
		BoardService service= new BoardService();	
		service.delete(no);
	}

}
</pre>

삭제를 테스트한다.<br />
모델1의 del.jsp 파일은 필요없으니 삭제한다.<br />

<h3>//TODO 7</h3>
이 부분은 다음과 같이 구현한다.<br />

<pre class="prettyprint">
action = new ReplyFormAction();
action.execute(req);
view = "/model2/reply_form.jsp";
</pre>

reply_form.jsp 파일을 참고하여 ReplyFormAction.java 를 만든다.<br />

<em class="filename">ReplyFormAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class ReplyFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {

		int no = Integer.parseInt(request.getParameter("no"));

		BoardService service = new BoardService();
		Article article = service.getArticle(no);	
		String content = article.getContent();

		//부모글을  구별하기 위해 부모글의 각 행마다 &gt;가 추가되도록 한다.
		content = content.replaceAll(Article.LINE_SEPARATOR, Article.LINE_SEPARATOR + "&gt;");
		content = Article.LINE_SEPARATOR + Article.LINE_SEPARATOR + "&gt;" + content;
		
		article.setContent(content);
		request.setAttribute("article", article);
	}

}
</pre>

reply_form.jsp 파일을 열고 .jsp 를 .do 로 수정한다.<br />
그다음 아래 강조된 부분을 참고하여 수정한다.<br />

<em class="filename">reply_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");

<strong>Article article = (Article) request.getAttribute("article");</strong>
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;h1&gt;답변쓰기&lt;/h1&gt;

&lt;form action="reply.do" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;
&lt;input type="hidden" name="family" value="&lt;%=article.getFamily() %&gt;" /&gt;
&lt;input type="hidden" name="indent" value="&lt;%=article.getIndent() %&gt;" /&gt;
&lt;input type="hidden" name="depth" value="&lt;%=article.getDepth() %&gt;" /&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;" /&gt;
&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;" /&gt;
제목 : &lt;input type="text" name="title" size="45" value="&lt;%=article.getTitle() %&gt;" /&gt;&lt;br /&gt;
&lt;textarea name="content" rows="10" cols="60"&gt;&lt;%=<strong>article.getContent()</strong> %&gt;&lt;/textarea&gt;&lt;br /&gt;
&lt;input type="submit" value="전송" /&gt;
&lt;input type="reset" value="취소" /&gt;&lt;br /&gt;
&lt;/form&gt;
&lt;a href="view.do?no=&lt;%=no %&gt;&amp;curPage=&lt;%=curPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;상세보기&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>//TODO 8</h3>
이 부분은 아래처럼 구현될 것이다.<br />

<pre class="prettyprint">
action = new ReplyAction();
action.execute(req);
String curPage = req.getParameter("curPage");
String keyword = req.getParameter("keyword");
if (keyword == null) keyword = "";
keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
view = "/model2/list.do?curPage=" + curPage + "&amp;keyword=" + keyword;
isRedirect = true;
</pre>

reply.jsp 파일을 참고하여 ReplyAction.java 를 만든다.<br />

<em class="filename">ReplyAction.java</em>
<pre class="prettyprint">
package net.java_school.board;

import javax.servlet.http.HttpServletRequest;

import net.java_school.action.Action;

public class ReplyAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {
		// 파라미터를 받는다.
		int parent = Integer.parseInt(request.getParameter("no"));
		int family = Integer.parseInt(request.getParameter("family"));
		int depth = Integer.parseInt(request.getParameter("depth"));
		int indent = Integer.parseInt(request.getParameter("indent")) + 1;
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		Article article = new Article();
		article.setParent(parent);
		article.setFamily(family);
		article.setDepth(depth);
		article.setIndent(indent);
		article.setTitle(title);
		article.setContent(content);

		BoardService service= new BoardService();
		service.reply(article);
	}

}
</pre>

답변글을 작성해 본다.<br />
reply.jsp 는 필요없으니 삭제한다.<br />
