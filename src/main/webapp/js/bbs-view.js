$(document).ready(function() {
	$('#file-list a.download').click(function() {
		var $filename = this.title;
		$('#downForm input[name*=filename]').val($filename);
		$('#downForm').submit();
		return false;
	});

	$('#file-list a:not(.download)').click(function() {
		var chk = confirm("정말로 삭제하시겠습니까?");

		if (chk == true) {
			var $attachFileNo = this.title;
			$('#deleteAttachFileForm input[name*=attachFileNo]').val($attachFileNo);
			$('#deleteAttachFileForm').submit();
		}

		return false;
	});

//	덧글반복
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
			var chk = confirm("정말로 삭제하시겠습니까?");
			if (chk == true) {
				var $commentNo = $(e.target).attr('title');
				$('#deleteCommentForm input[name*=commentNo]').val($commentNo);
				$('#deleteCommentForm').submit();
			}
			return false;
		}
	});

	//form 안의 수정하기 링크
	$('.modify-comment a.comments-modify-submit').click(function(e) {
		$(e.target).parent().parent().submit();
		return false;
	});

	//form 안의 취소 링크
	$('.modify-comment a:contains("취소")').click(function(e) {
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

//	수정 버튼
	$('.goModify').click(function() {
		$('#modifyForm').submit();
	});

	//삭제 버튼
	$('.goDelete').click(function() {
		var chk = confirm('정말로 삭제하시겠습니까?');
		if (chk == true) {
			$('#delForm').submit();
		}
	});

	//다음글 버튼
	$('.next-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});

	//이전글 버튼
	$('.prev-article').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
	});

	//목록버튼
	$('.goList').click(function() {
		$('#listForm').submit();
	});

	//새글쓰기 버튼
	$('.goWrite').click(function() {
		$('#writeForm').submit();
	});

	//상세보기 안의 목록의 제목링크
	$('#list-table a').click(function() {
		var $articleNo = this.title;
		goView($articleNo);
		return false;
	});

	//페이징 처리
	$('#paging a').click(function() {
		var $curPage = this.title;
		goList($curPage);
		return false;
	});

	//검색 버튼 위의 새글쓰기 버튼
	$('#list-menu input').click(function() {
		$('#writeForm').submit();
	});

});

function goView(articleNo) {
	$('#viewForm input[name*=articleNo]').val(articleNo);
	$('#viewForm').submit();
}

function goList(curPage) {
	$('#listForm input[name*=curPage]').val(curPage);
	$('#listForm').submit();
}