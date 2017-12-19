$(document).ready(function() {
	$('pre.prettyprint').each(function(index) {
		var $result = "";
		function println(str) {
			$result += str + "\n";
		}
		var $convert = $(this).text().replace(/alert/g,"println");
		eval($convert);
		$(this).after('<pre class="result">' + $result + '</pre>');
	});
});