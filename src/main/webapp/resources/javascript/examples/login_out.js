/*****************************************************
	로그인, 로그아웃 기능을 수행하는 스크립트 공통
******************************************************/
/*****************************************************
	입력:문자열
	리턴값:공백을 없앤 문자열
	% common.js 에 있는 remove_space 와 중복되지 않게 하기 위해 이름을 removeSpace로 변경 %
******************************************************/
function removeSpace( str ) {
	var len,index;
	while( true ) {
		index=str.indexOf(" ");
		if ( index == -1 ) break;
		len = str.length;
		str = str.substring( 0, index ) + str.substring( index+1, len );
	}
	
	return str;
}

/*****************************************************
	로그아웃 스크립트 실행
******************************************************/
function Logout() {
	var form = document.getElementById('frm_logout');
	form.submit();
}

/*****************************************************
	로그인 스크립트 실행
******************************************************/
function Login() {
	var form = document.getElementById('frm_login');
	
	if ( form.id.value.length == 0 ) {
		alert( 'ID를 입력하세요!' );
		form.id.focus();
		return;
	} else {
		var tmpid = removeSpace( form.id.value );
		if ( tmpid.length == 0 ) {
			alert( 'ID를 입력하세요!' );
			form.id.value = '';
			form.id.focus();
			return;
		}
	}
	
	if ( form.passwd.value.length == 0 ) {
		alert( 'Password를 입력하세요!' );
		form.passwd.focus();
		return;
	} else {
		var tmppw = removeSpace( form.passwd.value );
		if ( tmppw.length == 0 ) {
			alert( 'Password를 입력하세요!' );
			form.passwd.value = '';
			form.passwd.focus();
			return;
		}
	}

	form.submit();
}