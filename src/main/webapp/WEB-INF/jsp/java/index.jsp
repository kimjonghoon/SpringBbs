<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
$(document).ready(function() {
	var url = '/java/jdk-install';
	$.getJSON(url, function(data) {
		$('article').empty();
		$.each(data, function(i, item) {
			$('article').append(item.contents);
			console.log(item);
		});
		console.log(data);
	});
});
</script>

<div id="last-modified">Last Modified : 2017.8.2</div>

<h1>REST Test</h1>

<ul>
    <li id="jdk-install"><a href="#">JDK Install</a></li>
</ul>

<article>

<pre class="prettyprint">
public class User {
    private String username;
    private String password;
}
</pre>

</article>