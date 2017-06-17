$(document).ready(function() {
	$('#file-list a.download').click(function() {
		var $filename = this.title;
		$('#downForm input[name*=filename]').val($filename);
		$('#downForm').submit();
		return false;
	});

	$('#file-list a:not(.download)').click(function() {
		var msg = $('#delete-confirm').attr('title');
		var chk = confirm(msg);

		if (chk == true) {
			var $attachFileNo = this.title;
			$('#deleteAttachFileForm input[name*=attachFileNo]').val($attachFileNo);
			$('#deleteAttachFileForm').submit();
		}

		return false;
	});

	//Comments
	$('.comments').click(function(e) {
		if ($(e.target).is('.comment-toggle')) {
			var $form = $(e.target).parent().parent().find('.modify-comment');
			var $p = $(e.target).parent().parent().find('.view-comment');

			if ($form.is(':hidden') == true) {
				$form.show();
				$p.hide();
			} else {
				$form.hide();
				$p.show();
			}
			return false;
		} else if ($(e.target).is('.comment-delete')) {
			var msg = $('#delete-confirm').attr('title');
			var chk = confirm(msg);
			if (chk == true) {
				var $commentNo = $(e.target).attr('title');
				$('#deleteCommentForm input[name*=commentNo]').val($commentNo);
				$('#deleteCommentForm').submit();
			}
			return false;
		}
	});

	//Modify Link in form
	$('.modify-comment a.comments-modify-submit').click(function(e) {
		$(e.target).parent().parent().submit();
		return false;
	});

	//Cancel Link in form
	$('.modify-comment a.comments-modify-cancel').click(function(e) {
		var $form = $(e.target).parent().parent();
		var $p = $(e.target).parent().parent().parent().find('.view-comment');

		if ($form.is(':hidden') == true) {
			$form.show();
			$p.hide();
		} else {
			$form.hide();
			$p.show();
		}

		return false;

	});

	$('.next-prev a').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
		return false;
	});

	//Modify Button
	$('.goModify').click(function() {
		$('#modifyForm').submit();
	});

	//Del Button
	$('.goDelete').click(function() {
		var msg = $('#delete-confirm').attr('title');
		var chk = confirm(msg);
		if (chk == true) {
			$('#delForm').submit();
		}
	});

	//Next Article Button
	$('.next-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});

	//Prev Article Button
	$('.prev-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});

	//List Button
	$('.goList').click(function() {
		$('#listForm').submit();
	});

	//Write Button
	$('.goWrite').click(function() {
		$('#writeForm').submit();
	});

	//Title Link in view.jsp
	$('#list-table a').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
		return false;
	});

	//Paging
	$('#paging a').click(function() {
		var $page = this.title;
		goList($page);
		return false;
	});

	//Write Button on Search Button
	$('#list-menu input').click(function() {
		$('#writeForm').submit();
	});

});

function goView(articleNo) {
	var form = document.getElementById("viewForm");
	form.action += articleNo;
	form.submit();
}

function goList(page) {
	$('#listForm input[name*=page]').val(page);
	$('#listForm').submit();
}