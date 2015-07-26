/*window.onload = initPage;

function initPage() {
  //첨부파일 다운로드, 첨부파일 삭제
  var file_list = document.getElementById("file-list");
  var fileLinks = file_list.getElementsByTagName("a");
  
  for (var i = 0; i < fileLinks.length; i++) {
    var fileLink = fileLinks[i];
    
    if (fileLink.className == "download") {
      fileLink.onclick = function() {
        var filename = this.title;
        var form = document.getElementById("downForm");
        form.filename.value = filename;
        form.submit();
        return false;
      };
    } else {
      fileLink.onclick = function() {
        var attachFileNo = this.title;
        var chk = confirm("정말로 삭제하시겠습니까?");
        if (chk == true) {
          var form = document.getElementById("deleteAttachFileForm");
          form.attachFileNo.value = attachFileNo;
          form.submit();
          return false;
        }
      };
    }
    
  }

  
//덧글
  var bbs = document.getElementById("bbs");
  var divs = bbs.getElementsByTagName("div");

  for (i = 0; i < divs.length; i++) {
    if (divs[i].className == "comments") {
      var comments = divs[i];
      var spans = comments.getElementsByTagName("span");
      for (var j = 0; j < spans.length; j++) {
      if (spans[j].className == "modify-del") {
        var md = spans[j];
        var commentModifyLink = md.getElementsByTagName("a")[0];//수정 링크
        commentModifyLink.onclick = modifyCommentToggle;
        var commentDelLink = md.getElementsByTagName("a")[1];//삭제 링크
        commentDelLink.onclick =  function() {
          var commentNo = this.title;
          var chk = confirm("정말로 삭제하시겠습니까?");
          if (chk == true) {
            var form = document.getElementById("deleteCommentForm");
            form.commentNo.value = commentNo;
            form.submit();
            return false;
          }
        };
      }
     
      //form 태그안의 수정하기 링크
      var form = comments.getElementsByTagName("form")[0];
      var div = form.getElementsByTagName("div")[0];
      commentModifyLink = div.getElementsByTagName("a")[0];
      commentModifyLink.onclick = commentUpdate;
      //form 태그안의 취소링크
      var cancelLink = div.getElementsByTagName("a")[1];
      cancelLink.onclick = modifyCommentToggle;
    }

  }
  }

  //다음글,이전글 링크
	var nextPrev = document.getElementById("next-prev");
	links = nextPrev.getElementsByTagName("a");
	for (i = 0; i < links.length; i++) {
		links[i].onclick = goView;
	}
	
	//수정버튼
	var modifyBtn = document.getElementById("goModify");
	if (modifyBtn) {
	  modifyBtn.onclick = function() {
	    var form = document.getElementById("modifyForm");
	    form.submit();
	  };
	  
	}

	//삭제버튼
	var deleteBtn = document.getElementById("goDelete");
	if (deleteBtn) {
	  deleteBtn.onclick = function() {
	    var chk = confirm('정말로 삭제하시겠습니까?');
	    if (chk == true) {
	      var form = document.getElementById("delForm");
	      form.submit();
	    }
	  };
	  
	}

	//다음글 버튼
	var nextArticle = document.getElementById("next-article");
	if (nextArticle) {
	  nextArticle.onclick = goView;
	}

	//이전글 버튼
	var prevArticle = document.getElementById("prev-article");
	if (prevArticle) {
	  prevArticle.onclick = goView;
	}

	//목록버튼
	var listBtn = document.getElementById("goList");
	listBtn.onclick = function() {
	  var form = document.getElementById("listForm");
	  form.submit();
	};

	//새글쓰기 버튼
	var writeBtn = document.getElementById("goWrite");
	writeBtn.onclick = function() {
	  var form = document.getElementById("writeForm");
	  form.submit();
	};

	//상세보기 안의 목록의 제목링크
	var listTable = document.getElementById("list-table");
	links = listTable.getElementsByTagName("a");

	for (i = 0; i < links.length; i++) {
	  links[i].onclick = goView;
	}

	//페이징처리
	var paging = document.getElementById("paging");
	links = paging.getElementsByTagName("a");

	for (i = 0; i < links.length; i++) {
	  links[i].onclick = goList;
	}

	//검색 버튼 위의 새글쓰기 버튼
	var listMenu = document.getElementById("list-menu");
	writeBtn = listMenu.getElementsByTagName("input")[0];

	writeBtn.onclick = function() {
	  var form = document.getElementById("writeForm");
	  form.submit();
	};
	
}//initPage 함수끝


function commentUpdate(e) {
  var me = getActivatedObject(e);
  var form = me.parentNode;
  
  while (form.className != "modify-comment") {
    form = form.parentNode;
  }
  
  form.submit();
  return false;
}

function modifyCommentToggle(e) {
  var me = getActivatedObject(e);
  var comments = me.parentNode;
    
  while (comments.className != "comments") {
    comments = comments.parentNode;
  }
    
  var p = comments.getElementsByTagName("p")[0];//덧글 p
  var form = comments.getElementsByTagName("form")[0];//덧글 form
    
  if (p.style.display) {
    p.style.display = '';
    form.style.display = 'none';
  } else {
    p.style.display = 'none';
    form.style.display = '';
  }
    
  return false; 
}


 Head First Ajax 참조 

function getActivatedObject(e) {
  var obj;

  if (!e) {
    //IE 옛버전
    obj = window.event.srcElement;
  } else if (e.srcElement) {
    //IE 7 이상
    obj = e.srcElement;
  } else {
    //DOM 레벨 2 브라우저
    obj = e.target;
  }

  return obj;
}

function goView() {
  var form = document.getElementById("viewForm");
  form.articleNo.value = this.title;
  form.submit();
  return false;
}

function goList() {
  var form = document.getElementById("listForm");
  form.curPage.value = this.title;
  form.submit();
  return false;
}*/


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

//덧글반복
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

//수정 버튼
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