/*****************************************************
	�α���, �α׾ƿ� ����� �����ϴ� ��ũ��Ʈ ����
******************************************************/
/*****************************************************
	�Է�:���ڿ�
	���ϰ�:������ ���� ���ڿ�
	% common.js �� �ִ� remove_space �� �ߺ����� �ʰ� �ϱ� ���� �̸��� removeSpace�� ���� %
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
	�α׾ƿ� ��ũ��Ʈ ����
******************************************************/
function Logout() {
	var form = document.getElementById('frm_logout');
	form.submit();
}

/*****************************************************
	�α��� ��ũ��Ʈ ����
******************************************************/
function Login() {
	var form = document.getElementById('frm_login');
	
	if ( form.id.value.length == 0 ) {
		alert( 'ID�� �Է��ϼ���!' );
		form.id.focus();
		return;
	} else {
		var tmpid = removeSpace( form.id.value );
		if ( tmpid.length == 0 ) {
			alert( 'ID�� �Է��ϼ���!' );
			form.id.value = '';
			form.id.focus();
			return;
		}
	}
	
	if ( form.passwd.value.length == 0 ) {
		alert( 'Password�� �Է��ϼ���!' );
		form.passwd.focus();
		return;
	} else {
		var tmppw = removeSpace( form.passwd.value );
		if ( tmppw.length == 0 ) {
			alert( 'Password�� �Է��ϼ���!' );
			form.passwd.value = '';
			form.passwd.focus();
			return;
		}
	}

	form.submit();
}