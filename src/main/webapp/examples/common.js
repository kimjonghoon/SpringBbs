/*****************************************************
	입력:문자열
	리턴값:(만약 문자열이 숫자이면)true , (숫자가 아니면) false
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
	입력: 문자열
	리턴값: 공백이 없어진 문자열
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
	입력 : 문자열
	리턴값 : 유효한 이메일이면 true 아니면 false
***************************************/
function email_chk(email) {
	if (beAllowStr(email,"1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@.-_") == false) {
    	alert("e-mail에는 영문과 숫자 - _ . @만 사용할 수 있습니다.");
		return false;
	}
	var golbang = 0; // @ 문자의 갯수를 저장하기 위한 변수
	var dot = 0;     // . 문자의 갯수를 저장하기 위한 변수
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
	입력 : 주민번호앞자리, 주민번호뒷자리
	리턴값 : 주민번호가 맞으면 true, 틀리면 false
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
	입력 : 문자열
	리턴값 : 문자열이 모두 알파벳이라면 true, 하나라도 알파벳이 아니라면 false
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
	입력 : ID 후보값
	리턴값 : ID가 올바른 ID라면 true, 아니면 false
********************************************/
function IsValidID(UserID,min,max) {
	var tmptxt = UserID;
	first = tmptxt.charAt(0); // ID 의 첫번째 문자를 가져온다.
	
	// ID 첫문자에는 특수문자를 쓸 수 없다.
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
	// ID 첫문자에는 숫자나 - 또는 _ 를 쓸 수 없다.
	if ( IsNum(first) || first == "-" || first == "_" ) {
		return false; 
	}
	
	// ID 에 한글을 입력할 수 없다.
	if ( IsKoreanChar(tmptxt) ) {
		return false;
	} else {
		// ID 의 길이는 min<= ID 길이 <= max 이어야 한다.
		if ( tmptxt.length < min || tmptxt.length > max ) {
			return false; 
		}
	}
	
	return true;
}

/*******************************************
	입력 : PW 후보값
	리턴값 : PW가 올바른 PW라면 true, 아니면 false
********************************************/
function isPw(pw,min,max) {
	// PW의 길이가 올바른지 검사
	if ( pw.length < min || pw.length > max ) {
		return false;
	}
	
	// PW는 숫자이거나 알파벳이어야 한다.(대소문자 함께 써도 무방)
	for ( var i = 0;i < pw.length;i++ ) {
		var chr = pw.substr(i,1);
		if ( (chr < '0' || chr > '9') && (chr < 'a' || chr >'z') && (chr < 'A' || chr > 'Z') ) {
			return false;
		}
	}
	
	return true;
}

/*******************************************
	입력 : 이름 후보값
	리턴값 : 이름이 올바른 이름값이라면 true, 아니면 false
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
	
	// 이름이 한글이 아니라면 false 리턴
	if (!IsKoreanChar(tmptxt)) {
		return false;
	}
	
	return true;
}

/*******************************************
	입력 : 문자열
	리턴값 : 문자열이 한글이면 true, 아니면 false
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
	입력 : 수에 해당하는 문자 (007 도 된다.)
	리턴값 : 수가 올바른 숫자이면 true, 아니면 false
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
	입력 : 주민번호 앞자리, 주민번호 뒷자리
	리턴값 : 주민번호가 올바르면 true, 아니면 false
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
	입력 : 셀렉트박스 객체, 값
	리턴값 : 셀렉트 박스의 option요소에 설정된 값과 인자로 입력된 값이 같으면 해당 option 요소의 index 값을 리턴, 같은 값이 없다면 -1 리턴
	주의 : 인자로 입력되는 셀렉트박스의 속성은 multiple 이 아니어야 한다.
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
	입력 : 라디오객체, 값
	리턴값 : 라디오 그룹의 라디어버튼요소에 설정된 값과 인자로 입력된 값이 같으면 해당 라디오버튼요소의 index 값을 리턴 같은 값이 없다면 -1 리턴
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
	입력 : 회원가입 양식에서의 에러 메시지 코드
	리턴값 : 회원가입 양식에서 에러 메시지 코드에 해당하는 메시지
********************************************/
function ErrCode(code) {
	if (code == 1) {
		ErrStr = "ID에 영문자,숫자,-,_ 를 제외한 문자는 입력이 불가능 합니다!";
	}
	else if(code == 2) {
		ErrStr = "ID의 첫글자는 반드시 영문자여야 합니다! ";
	}
	else if(code == 3) {
		ErrStr = "ID는 4-12자리의 영문,숫자,영문+숫자 조합만이 가능합니다!";
	}
	else if(code == 4) {
		ErrStr = "ID는 4-12자리로 입력하셔야 합니다!";
	}
	else if(code == 5) {
		ErrStr = "이름에 특수문자 또는 영문자는 포함될 수 없습니다!";
	}
	else if(code == 6) {
		ErrStr = "주민등록번호를 정확하게 입력하세요!";
	}
	else if(code == 7) {
		ErrStr = "Password에 #,&,%,\\,\" 문자는 포함될 수 없습니다!";
	}
	else {
		ErrStr = "예외상황!";
	}

	return ErrStr;
}

/*******************************************
	입력 : 검사대상 문자열, 허용되는 문자열
	리턴값 : 검사대상 문자열이 허용되는 문자열로 구성되었다면 true, 아니면 false
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
	입력 : 검사대상 문자열
	리턴값 : 검사대상 문자열이 숫자나 소문자알파벳으로 구성되었다면 true, 아니면 false
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
	입력 : 텍스트필드객체, 최소 문자열의 길이
	리턴값 : 텍스트필드에 입력한 값이 최소 문자열의 길이 이상이면 true, 아니면 false
********************************************/
function checkLength (theField, Length)  {
	if (theField.value.length < Length  ) {
		theField.select();
		return false;
	}
	return true;
}

/*******************************************
	입력 : 검사대상문자열
	리턴값 : 검사대상문자열이 영문과 숫자로만 구성되었다면 true, 아니면 false
	특징 : 정규표현식 사용하여 검사
********************************************/
function check(str) {
	var p_id   = str.value;
	
	if(/[0-9]+/.test(p_id) == false ){
		alert("영문과 숫자를 혼용하여 주십시오.");
 		str.focus();
		return false;
	}
	
	if(/[a-zA-Z]+/.test(p_id) == false ){
		alert("영문과 숫자를 혼용하여 주십시오.");
		str.focus();
		return false;
	}
	
	if(/[\s]+/.test(p_id) == true){
		alert("빈칸이 있습니다.");
		str.focus();
		return false;
	}
	
	return true;
}

/*******************************************
	입력 : ID값, 패스워드값
	리턴값 : ID값과 패스워드 값이 서로 비교해서 보안상 맞게 구성되었다면 true, 아니면 false
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
			alert("비밀번호가 ID와 4자 이상 중복되거나, \n연속된 글이나 순차적인 숫자를 4개이상 사용해서는 안됩니다.");
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
			alert("비밀번호에 연속된 글이나 순차적인 숫자를 4개이상 사용해서는 안됩니다.");
			return  false;
    	}
    	
		if (cnt3 > 3){
			alert("비밀번호에 반복된 문자/숫자를 4개이상 사용해서는 안됩니다.");
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
   this[0]=0;  // <- 아무런 의미가 없는 것임. 무시해도 좋음.
   this[1]=31;
   this[2]=28;
   if (l_sLeapYear) // 윤달이 아니면...
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