<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
article {
	overflow: hidden;
}
</style>
<script type="text/javascript">
$(document).ready(function() {

	$('#jdk-install a').click(function(e) {
		e.preventDefault();
		var url = '/java/jdk-install';
		$.getJSON(url, function(data) {
			$('title').empty();
			$('title').append(data.title);
			$("meta[name='Keywords']").attr("content", data.keywords);
			$("meta[name='Description']").attr("content", data.description);
			$('article').empty();
			$('article').append(data.content);
			console.log(data);
			console.log($("meta[name='Keywords']").attr("content"));
			console.log($("meta[name='Description']").attr("content"));
		});
	}); 

	$('#oracle-jdbc-test a').click(function(e) {
		e.preventDefault();
		var url = '/resources/html/Oracle-JDBC-Test-content.html';//이건 된다.!
		//var url = 'https://java-school.000webhostapp.com/jdbc/html/Oracle-JDBC-Test-content.html';
		$("article").load(url);
	}); 
	
	
});
</script>

<div id="last-modified">Last Modified : 2017.8.2</div>

<h1>REST 테스트</h1>

<ul>
	<li id="jdk-install"><a href="#">JDK 설치</a></li>
	<li id="oracle-jdbc-test"><a href="#">Oracle JDBC Test</a></li>
</ul>

<article>
<pre class="prettyprint">
public class User {
    private String username;
    private String password;
}
</pre>
<object type="text/html" data="https://java-school.000webhostapp.com/jdbc/html/Oracle-JDBC-Test-content.html" style="overflow:hidden; width: 590px; height: 9500px">
</object>
</article>