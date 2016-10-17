<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>게시판 - 파일 다운로드</h1>

<em class="filename">/WEB-INF/jsp/inc/download.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.io.File" %&gt;
&lt;%@ page import="java.net.URLEncoder" %&gt;
&lt;%@ page import="java.io.OutputStream" %&gt;
&lt;%@ page import="java.io.FileInputStream" %&gt;
&lt;%@ page import="java.io.IOException" %&gt;
&lt;%@ page import="org.springframework.util.FileCopyUtils" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%
//request.setCharacterEncoding("UTF-8");//필터가 이 작업을 한다.
String filename = request.getParameter("filename");

File file = new File(WebContants.UPLOAD_PATH + filename);

String filetype = 
    filename.substring(filename.indexOf(".") + 1, filename.length());

if (filetype.trim().equalsIgnoreCase("txt")) {
	response.setContentType("text/plain");
} else {
	response.setContentType("application/octet-stream");
}

response.setContentLength((int) file.length());

boolean ie = request.getHeader("User-Agent").indexOf("MSIE") != -1;
if (ie) {
	filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
} else {
	filename = new String(filename.getBytes("UTF-8"), "8859_1");
}

response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

OutputStream outputStream = response.getOutputStream();
FileInputStream fis = null;

try {
	fis = new FileInputStream(file);
	FileCopyUtils.copy(fis, outputStream);
} finally {
	if (fis != null) {
		try {
			fis.close();
		} catch (IOException e) {}
	}
}

out.flush();
%&gt;
</pre>

<em class="filename">BbsController.java</em> 
<pre class="prettyprint">
@RequestMapping(value="/download", method=RequestMethod.POST)
public String download(String filename, Model model) {
	model.addAttribute("filename", filename);
	return "inc/download";
}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.hanb.co.kr/book/look.html?isbn=978-89-7914-887-9#binfo5">예제로 쉽게 배우는 스프링 프레임워크 3.0(한빛미디어) - 사카타 코이치</a></li>
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
</ul>

