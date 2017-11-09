/*****************************************************
	�Է�:���ڿ�
	���ϰ�:(���� ���ڿ��� �����̸�)true , (���ڰ� �ƴϸ�) false
******************************************************/
function isNumber(str) {
	var len = str.length;
	var check = true;
	if ( len == 0 ) {
		return false;
	}
	for ( var i = 0;i < len;i++ ) {
		if ( (str.charAt(i) < "0" ) || ( str.charAt(i) > "9") ) {
			check = false;
			break;
		}
	}

	return check
}

/*************************************
	�Է�: ���ڿ�
	���ϰ�: ������ ������ ���ڿ�
**************************************/
function remove_space(str) {
	var len,index;
	while ( true ) {
		index = str.indexOf(" ");
		if ( index == -1 ) {
			break;
		}
		len = str.length;
		str = str.substring(0, index) + str.substring( index+1, len);
	}

	return str;
}

/**************************************
	�Է� : ���ڿ�
	���ϰ� : ��ȿ�� �̸����̸� true �ƴϸ� false
***************************************/
function email_chk(email) {
	if (beAllowStr(email,"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@.-_") == false) {
    	alert("e-mail���� ������ ���� - _ . @�� ����� �� �ֽ��ϴ�.");
		return false;
	}
	var golbang = 0; // @ ������ ������ �����ϱ� ���� ����
	var dot = 0;     // . ������ ������ �����ϱ� ���� ����
	if ( email.length < 1 ) {
		return false;
	}
	if ( email.indexOf("@") == -1 ) {
		return false;
	}
	if ( email.indexOf(".") == -1 ) {
		return false;
	}
	if ( email.indexOf(" ") != -1 ) {
		return false;
	}
	for ( var i = 0;i < email.length;i++ ) {
		if ( email.charAt(i) == "@" ) {
			golbang++;
		}
		if ( email.charAt(i) == "." ) {
			dot++;
		}
	}
	if ( golbang != 1 || dot > 3 ) {
		return false;
	}
	if ( email.indexOf("@") > email.indexOf(".") ) {
		return false;
	}
	if ( (email.indexOf("@") == 0 ) || ( email.indexOf(".") == email.length - 1 ) ) {
		return false;
	}
	return true;
}

/*******************************************
	�Է� : �ֹι�ȣ���ڸ�, �ֹι�ȣ���ڸ�
	���ϰ� : �ֹι�ȣ�� ������ true, Ʋ���� false
********************************************/
function jumin_chk( jumin1, jumin2 ) {
	if ( jumin1 == null || jumin1 == "" || isNaN(jumin1) ) {
		return false;
	}
	if ( jumin2 == null || jumin2 == "" || isNaN(jumin2) ) {
		return false;
	}
	var hap = 0;
	for( var i=0;i < 6;i++){
		var temp = jumin1.charAt(i) * (i+2);
		hap += temp;
	}
	var n1 = jumin2.charAt(0);
	var n2 = jumin2.charAt(1);
	var n3 = jumin2.charAt(2);
	var n4 = jumin2.charAt(3);
	var n5 = jumin2.charAt(4);
	var n6 = jumin2.charAt(5);
	var n7 = jumin2.charAt(6);
	hap += n1*8+n2*9+n3*2+n4*3+n5*4+n6*5;
	hap %= 11;
	hap = 11-hap;
	hap %= 10;
	if(hap == n7) {
		return true;
	} else {
		return false;
	}
}

/*******************************************
	�Է� : ���ڿ�
	���ϰ� : ���ڿ��� ��� ���ĺ��̶�� true, �ϳ��� ���ĺ��� �ƴ϶�� false
********************************************/
function IsAlphabet(string) {
	var tmptxt = string;
	for ( var i=0; i < tmptxt.length; i++ ) {
		var ch = tmptxt.substring(i, i+1);

		if ( ch < "a" || ch > "z" ) {
			return false;
		}
	}
	return true;
}

/*******************************************
	�Է� : ID �ĺ���
	���ϰ� : ID�� �ùٸ� ID��� true, �ƴϸ� false
********************************************/
function IsValidID(UserID,min,max) {
	var tmptxt = UserID;
	first = tmptxt.charAt(0); // ID �� ù��° ���ڸ� �����´�.
	
	// ID ù���ڿ��� Ư�����ڸ� �� �� ����.
	for ( var i = 0;i < tmptxt.length; i++ ) {
		var ch = tmptxt.substring(i, i+1);

		if(ch == "~" || ch == "`" || ch == "!" || ch == "@" || ch == "#" ||
		   ch == "$" || ch == "%" || ch == "^" || ch == "&" || ch == "*" ||
		   ch == "(" || ch == ")" || ch == "+" || ch == "=" || ch == "{" ||
		   ch == "}" || ch == "[" || ch == "]" || ch == ":" || ch == ";" ||
		   ch == "<" || ch == ">" || ch == "," || ch == "." || ch == "?" || 
		   ch == "/" || ch == "\\" || ch == "|" || ch == "'" || ch == "\"" || ch == " ") {
			return false; 
		}
	}
	// ID ù���ڿ��� ���ڳ� - �Ǵ� _ �� �� �� ����.
	if ( IsNum(first) || first == "-" || first == "_" ) {
		return false; 
	}
	
	// ID �� �ѱ��� �Է��� �� ����.
	if ( IsKoreanChar(tmptxt) ) {
		return false;
	} else {
		// ID �� ���̴� min<= ID ���� <= max �̾�� �Ѵ�.
		if ( tmptxt.length < min || tmptxt.length > max ) {
			return false; 
		}
	}
	
	return true;
}

/*******************************************
	�Է� : PW �ĺ���
	���ϰ� : PW�� �ùٸ� PW��� true, �ƴϸ� false
********************************************/
function isPw(pw,min,max) {
	// PW�� ���̰� �ùٸ��� �˻�
	if ( pw.length < min || pw.length > max ) {
		return false;
	}
	
	// PW�� �����̰ų� ���ĺ��̾�� �Ѵ�.(��ҹ��� �Բ� �ᵵ ����)
	for ( var i = 0;i < pw.length;i++ ) {
		var chr = pw.substr(i,1);
		if ( (chr < '0' || chr > '9') && (chr < 'a' || chr >'z') && (chr < 'A' || chr > 'Z') ) {
			return false;
		}
	}
	
	return true;
}

/*******************************************
	�Է� : �̸� �ĺ���
	���ϰ� : �̸��� �ùٸ� �̸����̶�� true, �ƴϸ� false
********************************************/
function IsValidUserName(UserName) {
	var tmptxt = UserName;

	for(var i=0;i < tmptxt.length; i++)	{
		var ch = tmptxt.substring(i, i+1);

		if(ch == "~" || ch == "`" || ch == "!" || ch == "@" || ch == "#" ||
		   ch == "$" || ch == "%" || ch == "^" || ch == "&" || ch == "*" ||
		   ch == "(" || ch == ")" || ch == "+" || ch == "=" || ch == "{" ||
		   ch == "}" || ch == "[" || ch == "]" || ch == ":" || ch == ";" ||
		   ch == "<" || ch == ">" || ch == "," || ch == "." || ch == "?" || 
		   ch == "/" || ch == "\\" || ch == "|" || ch == "'" || ch == "\"") {
			return false; 
		}
	}
	
	// �̸��� �ѱ��� �ƴ϶�� false ����
	if (!IsKoreanChar(tmptxt)) {
		return false;
	}
	
	return true;
}

/*******************************************
	�Է� : ���ڿ�
	���ϰ� : ���ڿ��� �ѱ��̸� true, �ƴϸ� false
********************************************/
function IsKoreanChar(strkor) {
	var tmptxt = strkor.toLowerCase();
	for ( var i=0;i < tmptxt.length; i++) {
		var ch = tmptxt.substring(i, i+1);
		if ( (ch > "0" && ch < "9" ) ||( ch > "a" && ch < "z" ) || (ch ="-") || (ch ="_")) {
			return false;
		}
	}

	return true;
}

/*******************************************
	�Է� : ���� �ش��ϴ� ���� (007 �� �ȴ�.)
	���ϰ� : ���� �ùٸ� �����̸� true, �ƴϸ� false
********************************************/
function IsNum(txt) {
	var tmptxt = txt;
	for ( var i=0;i < tmptxt.length; i++ ) {
		var ch = tmptxt.substring(i,i+1);
		if ( ch < "0" || ch > "9" ) {
			return false;
		}
	}

	return true;
}

/*******************************************
	�Է� : �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�
	���ϰ� : �ֹι�ȣ�� �ùٸ��� true, �ƴϸ� false
********************************************/
function IsValidResNo(ssn1,ssn2) {
	var jumin = ssn1 + ssn2;
	if ((ssn1.length != "6") || (ssn2.length != "7")) {
		return false;
	}
	ch1	= jumin.charAt(0);
	ch2	= jumin.charAt(1);
	ch3	= jumin.charAt(2);
	ch4	= jumin.charAt(3);
	ch5	= jumin.charAt(4);
	ch6	= jumin.charAt(5);
	ch7	= jumin.charAt(6);
	ch8	= jumin.charAt(7);
	ch9	= jumin.charAt(8);
	ch10= jumin.charAt(9);
	ch11= jumin.charAt(10);
	ch12= jumin.charAt(11);
	ch13= jumin.charAt(12);

	tot = (ch1*2)+(ch2*3)+(ch3*4)+(ch4*5)+(ch5*6)+(ch6*7)+(ch7*8)+(ch8*9)+(ch9*2)+(ch10*3)+(ch11*4)+(ch12*5);
	modvalue = 11 - (tot % 11);
	lastvalue = modvalue % 10 ;

	if (ch13 == lastvalue) {
		return true;
	} else {
        return false; 
	}
}

/*******************************************
	�Է� : ����Ʈ�ڽ� ��ü, ��
	���ϰ� : ����Ʈ �ڽ��� option��ҿ� ������ ���� ���ڷ� �Էµ� ���� ������ �ش� option ����� index ���� ����, ���� ���� ���ٸ� -1 ����
	���� : ���ڷ� �ԷµǴ� ����Ʈ�ڽ��� �Ӽ��� multiple �� �ƴϾ�� �Ѵ�.
********************************************/
function Search_Index(selcombo,value) {
	var tmpvalue;
	for ( var i = 0;i < selcombo.length;i++ ) {
		tmpvalue = selcombo.options[i].value;
		if (tmpvalue == value) {
			return i;
		}
	}
	return -1;
}

/*******************************************
	�Է� : ������ü, ��
	���ϰ� : ���� �׷��� �����ư��ҿ� ������ ���� ���ڷ� �Էµ� ���� ������ �ش� ������ư����� index ���� ���� ���� ���� ���ٸ� -1 ����
********************************************/
function Search_RadioIndex(form_name)
{
	for(var i=0;i<form_name.length;i++)
	{
		if (form_name[i].checked)
			return i;
	}
	return -1;
}

/*******************************************
	�Է� : ȸ������ ��Ŀ����� ���� �޽��� �ڵ�
	���ϰ� : ȸ������ ��Ŀ��� ���� �޽��� �ڵ忡 �ش��ϴ� �޽���
********************************************/
function ErrCode(code) {
	if (code == 1) {
		ErrStr = "ID�� ������,����,-,_ �� ������ ���ڴ� �Է��� �Ұ��� �մϴ�!";
	}
	else if(code == 2) {
		ErrStr = "ID�� ù���ڴ� �ݵ�� �����ڿ��� �մϴ�! ";
	}
	else if(code == 3) {
		ErrStr = "ID�� 4-12�ڸ��� ����,����,����+���� ���ո��� �����մϴ�!";
	}
	else if(code == 4) {
		ErrStr = "ID�� 4-12�ڸ��� �Է��ϼž� �մϴ�!";
	}
	else if(code == 5) {
		ErrStr = "�̸��� Ư������ �Ǵ� �����ڴ� ���Ե� �� �����ϴ�!";
	}
	else if(code == 6) {
		ErrStr = "�ֹε�Ϲ�ȣ�� ��Ȯ�ϰ� �Է��ϼ���!";
	}
	else if(code == 7) {
		ErrStr = "Password�� #,&,%,\\,\" ���ڴ� ���Ե� �� �����ϴ�!";
	}
	else {
		ErrStr = "���ܻ�Ȳ!";
	}

	return ErrStr;
}

/*******************************************
	�Է� : �˻��� ���ڿ�, ���Ǵ� ���ڿ�
	���ϰ� : �˻��� ���ڿ��� ���Ǵ� ���ڿ��� �����Ǿ��ٸ� true, �ƴϸ� false
********************************************/
function beAllowStr(str, allowStr) {
    var i;
    var ch;
    for ( i = 0;i < str.length;i++ ) {
        ch = str.charAt(i);
        if (allowStr.indexOf(ch) < 0) {
            return false;
        }
    }
    return true;
}

/*******************************************
	�Է� : �˻��� ���ڿ�
	���ϰ� : �˻��� ���ڿ��� ���ڳ� �ҹ��ھ��ĺ����� �����Ǿ��ٸ� true, �ƴϸ� false
********************************************/
function AllowNum(str){
	var len = 0;
	var code = "1234567890abcdefghijklmnopqrstuvwxyz";
	for (var i = 0; i < str.value.length; i++) {
		var ch = str.value.charAt(i);
		if ( code.indexOf(ch) < 0 ) {
			return false;
		}
	}
	return true;
}

/*******************************************
	�Է� : �ؽ�Ʈ�ʵ尴ü, �ּ� ���ڿ��� ����
	���ϰ� : �ؽ�Ʈ�ʵ忡 �Է��� ���� �ּ� ���ڿ��� ���� �̻��̸� true, �ƴϸ� false
********************************************/
function checkLength (theField, Length)  {
	if (theField.value.length < Length  ) {
		theField.select();
		return false;
	}
	return true;
}

/*******************************************
	�Է� : �˻����ڿ�
	���ϰ� : �˻����ڿ��� ������ ���ڷθ� �����Ǿ��ٸ� true, �ƴϸ� false
	Ư¡ : ����ǥ���� ����Ͽ� �˻�
********************************************/
function check(str) {
	var p_id   = str.value;
	
	if(/[0-9]+/.test(p_id) == false ){
		alert("������ ���ڸ� ȥ���Ͽ� �ֽʽÿ�.");
 		str.focus();
		return false;
	}
	
	if(/[a-zA-Z]+/.test(p_id) == false ){
		alert("������ ���ڸ� ȥ���Ͽ� �ֽʽÿ�.");
		str.focus();
		return false;
	}
	
	if(/[\s]+/.test(p_id) == true){
		alert("��ĭ�� �ֽ��ϴ�.");
		str.focus();
		return false;
	}
	
	return true;
}

/*******************************************
	�Է� : ID��, �н����尪
	���ϰ� : ID���� �н����� ���� ���� ���ؼ� ���Ȼ� �°� �����Ǿ��ٸ� true, �ƴϸ� false
********************************************/
function  passChk( p_id, p_pass) {
	var cnt = 0, cnt2 = 1, cnt3 = 1;
	var temp = "";
	for ( i=0;i < p_id.length; i++ ) {
		temp_id = p_id.charAt(i);
		
		for ( j=0; j < p_pass.length; j++ ) {
			if ( cnt > 0 ) j = tmp_pass_no + 1;
			if ( temp == "r" ) {
				j = 0;
				temp = "";
			}
			temp_pass = p_pass.charAt(j);
			if ( temp_id == temp_pass ) {
				cnt = cnt + 1;
				tmp_pass_no = j;
				break;
			} else if ( cnt > 0 && j > 0) {
				temp = "r";
				cnt = 0;
			} else
				cnt = 0;
			}
    		if (cnt > 3) break;
    	}
    	
		if (cnt > 3) {
			alert("��й�ȣ�� ID�� 4�� �̻� �ߺ��ǰų�, \n���ӵ� ���̳� �������� ���ڸ� 4���̻� ����ؼ��� �ȵ˴ϴ�.");
			return  false;
    	}
    	
		for(i=0;i < p_pass.length;i++){
    		temp_pass1 = p_pass.charAt(i);
    		next_pass = (parseInt(temp_pass1.charCodeAt(0)))+1;
    		temp_p = p_pass.charAt(i+1);
    		temp_pass2 = (parseInt(temp_p.charCodeAt(0)));
    	
			if (temp_pass2 == next_pass)
    		    cnt2 = cnt2 + 1;
    		else
    		    cnt2 = 1;
    		if (temp_pass1 == temp_p)
    		    cnt3 = cnt3 + 1;
    		else
    		    cnt3 = 1;
    		if (cnt2 > 3) break;
    		if (cnt3 > 3) break;
    	}
    	
		if (cnt2 > 3) {
			alert("��й�ȣ�� ���ӵ� ���̳� �������� ���ڸ� 4���̻� ����ؼ��� �ȵ˴ϴ�.");
			return  false;
    	}
    	
		if (cnt3 > 3){
			alert("��й�ȣ�� �ݺ��� ����/���ڸ� 4���̻� ����ؼ��� �ȵ˴ϴ�.");
			return  false;
    	}
    	
		return true;
}

function gv_date_check(iYear,iMonth,iDay) {                             
	var l_iYear  = parseInt(iYear, 10);      
	var l_iMonth = parseInt(iMonth, 10);
	var l_iDay   = parseInt(iDay, 10);

	var l_sLeapYear = (((l_iYear%4 == 0) && (l_iYear%100 != 0)) || (l_iYear%400 == 0));
	var monthDays  = new gn_ArrayOfDay(l_sLeapYear);

	if (l_iYear < 1900)	{
		return false;
	}
	else if (l_iMonth > 12) {            
		return false;
	}
	else if((parseInt(l_iDay) < 1) || (l_iDay > monthDays[l_iMonth])) {  
		return false;
	}

	return true;
}

function gn_ArrayOfDay(l_sLeapYear)
{
   this[0]=0;  // <- �ƹ��� �ǹ̰� ���� ����. �����ص� ����.
   this[1]=31;
   this[2]=28;
   if (l_sLeapYear) // ������ �ƴϸ�...
       this[2]=29;
   this[3]=31;
   this[4]=30;
   this[5]=31;
   this[6]=30;
   this[7]=31;
   this[8]=31;
   this[9]=30;
   this[10]=31;
   this[11]=30;
   this[12]=31;
}