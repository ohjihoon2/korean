/*
	UPDATE : 2009-12-16 오후 3:11:19	
*/



///////////////////////////////////////////////////////
// 문자열 Prototype
String.prototype.trim = function() {
  return this.replace(/^\s+|\s+$/g,"");
}

String.prototype.ltrim = function() {
    return this.replace(/^\s+/,"");
}

String.prototype.rtrim = function() {
    return this.replace(/\s+$/,"");
}



///////////////////////////////////////////////////////////
// Check 함수

/*
	문자열에 특정 문자들이 포함되었는지 확안하는 함수
	
	Parameters :
		input : 원본 문자열
		chars : 포함되어 있는지 확인하는 문자들록 구성된 문자열
		
	Returns : 
		포함되어 있으면 true 
		
	Ex)
		containsCharsOnly( 'abc' ,'0123456789' ) => false
		containsCharsOnly( '1234' ,'0123456789' ) => true
		
*/
function containsCharsOnly( input, chars )
{
	for( var inx = 0; inx < input.length; inx++ )
	{
		if( chars.indexOf( input.charAt( inx ) ) == -1 )
			return false;
	}
	return true;
}


///////////////////////////////////////////////////////////
// Form 양식 Validateion

/*
	Form 양식의 값이 비어있는지 확인 
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )		
*/
function CheckEmpty( _frm, msg )
{
	if( _frm.value.trim() == "" ) {
		if( msg != "" ) alert( msg );
		_frm.focus();
		return true;
	}
	return false;
}


/*
	Form 양식의 값이 비어있는지 확인 
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )		
	return :
		체크가 된 양식의 수를 리턴한다.
*/
function GetCheckedCount( _frm )
{
	var chk_count = 0;	
	
	if( _frm.length == undefined ){
		if( _frm.checked ) chk_count++;
	
	} else{
		for( var i=0; i < _frm.length; i++ )
		{
			if( _frm[i].checked ) chk_count++;		
		}	
	}	
	
	
	return chk_count;
}

/*
	Form 양식의 값이 비어있는지 확인 
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )		
	return :
		체크가 된 양식의 수를 리턴한다.
*/
function CheckCount( _frm, msg, count )
{
	if( count == undefined ) count = 1;
	
	
	var chk_count = 0;	
	var first_frm;
	if( _frm.length == undefined ){
		if( _frm.checked ) chk_count++;
		first_frm = _frm;
	} else{
		for( var i=0; i < _frm.length; i++ )
		{
			if( _frm[i].checked ) chk_count++;		
		}
		first_frm = _frm[0];
	}	
	
	if( chk_count < count )
	{
		if( msg != "" ) alert( msg );
		first_frm.focus();
		return true;
	}
	
	return false;
}



/*
	Form 양식의 값이 비어있는지 확인 
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )		
	return :
		체크가 된 양식의 수를 리턴한다.
*/
function CheckCountRange( _frm, msg, st, ed )
{
	if( st == undefined ) st = 1;
	if( ed == undefined ) ed = 1;
	
	var chk_count = 0;	
	var first_frm;
	if( _frm.length == undefined ){
		if( _frm.checked ) chk_count++;
		first_frm = _frm;
	} else{
		for( var i=0; i < _frm.length; i++ )
		{
			if( _frm[i].checked ) chk_count++;		
		}
		first_frm = _frm[0];
	}	
	

	if( chk_count < st || chk_count > ed )
	{
		if( msg != "" ) alert( msg );
		first_frm.focus();
		return true;
	}
	
	return false;
}




/*
	숫자인지 확인 
	
	Parameters :
		_frm : 문자열( 숫자가 포함된 )
	
*/
function IsNumber( _frm )
{
	var chars="0123456789";
	
	return containsCharsOnly( _frm, chars );
	
}



/*
	Form 양식의 값이 숫자인지 확인 
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/
function CheckNumber( _frm, msg )
{
	var chars="0123456789";
	
	if( ! containsCharsOnly( _frm.value, chars )  )
	{
		if( msg != "" ) alert( msg );
		_frm.focus();		
		return true;
	}
	return false;
	
}


/*
	Form 양식의 값이 숫자인지 확인 ( CheckNumber와 비슷하지만 '-'도 숫자로 고려한다. )
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/
function CheckInteger( _frm, msg )
{
	
	if( ! _frm.value.match( /^(-?)(\d+)(.\d+)?$/ )  )
	{
		if( msg != "" ) alert( msg );
		_frm.focus();		
		return true;
	}
	return false;
	
}


/*
	Form 양식의 값이 숫자인지 확인 ( CheckInteger와 비슷하지만 ','도 숫자로 고려한다. , ','가 전혀 없어도 유효하다고 판단하는데, ','가 사용되면 형식에 맞아야 한다.)
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/

function CheckIntegerComma( _frm, msg )
{
	
	if( ! _frm.value.match( /^(-?)(\d{1,3})(,?\d{3})*(.\d+)?$/ )  )
	{
		if( msg != "" ) alert( msg );
		_frm.focus();		
		return true;
	}
	return false;
	
}



/*
	문자열로된 3자리 숫자들에 컴마를 추가해주는 함수
	
	Parameters :
		obj : 문자열
		
	EX 1)
		formatCurrency( "-1234" ) -> "-1,234"
		
	EX 2) - TEXT 양식에서 사용할 경우 ( 숫자입력하면서 컴마 붙일때 )
		onkeyup="this.value = formatCurrency( trimComma(this.value) ); " 
		
*/
function formatCurrency( obj ){
	var returnVal = String( obj );
	
	while( returnVal.match( /^(-?\d+)(\d{3})/ ) ) {
		returnVal = returnVal.replace( /^(-?\d+)(\d{3})/, '$1,$2' );
	}
	
	return returnVal;
}



/*
	문자열로된 3자리 숫자들에 컴마를 추가해주는 함수
	
	Parameters :
		obj : 문자열
		
	EX )
		formatCurrency( "-1234" ) -> "-1,234"
*/
function trimComma( obj ){
	var returnVal = String( obj );
	
	return returnVal.replace( /,/g, "" );
}




/*
	Form 양식의 값이 ID나 암호가 될수 있는지 ( 영문 및 숫자 ) 검사
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/
function CheckIDPWD( _frm, msg )
{
	var chars="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	if( ! containsCharsOnly( _frm.value, chars )  )
	{
		if( msg != "" ) alert( msg );
		_frm.focus();		
		return true;
	}
	return false;
	
}


/*
	Form 양식의 값이 ID나 암호가 될수 있는지 ( 영문 및 숫자 조합인지 ) 검사 
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/
function CheckIDPWD2( _frm, msg )
{
	var chars1="0123456789";
	var chars2="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	

	if( ! ( containsCharsOnly( _frm.value, chars1 ) && containsCharsOnly( _frm.value, chars2 ) ) )
	{
		if( msg != "" ) alert( msg );
		_frm.focus();		
		return true;
	}
	return false;
	
}


/*
	문자열을 Date 객체로 변환
	
	Parameters :
		ymd : 날짜형의 문자열
*/
function StrToDate(ymd){
	var str_y = ymd.substring( 0,4 );
	var str_m = ymd.substring( 5,7 );
	var str_d = ymd.substring( 8,10 );
	var yy = parseInt( str_y, 10 );
	var mm = parseInt( str_m, 10 );
	var dd = parseInt( str_d, 10 );
	
  --mm;
  return new Date(yy, mm, dd);
}


/*
	Date 객체를 문자열로 변환
	
	Parameters :
		_date : Date 객체
*/
function DateToStr(_date){
	var result = "";
	
	var yy = _date.getFullYear();
	var mm = _date.getMonth()+1;
	var dd = _date.getDate();
	if( mm < 10 ) mm = "0"+mm;
	if( dd < 10 ) dd = "0"+dd;
	
  return yy+"-"+mm+"-"+dd;
}



/*
	Form 양식의 값이 날짜(YYYY-MM-DD) 형태인지 확인 
	
	Parameters :
		_frm : 폼양식
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/
function CheckDate(_frm , msg){
		
	var ymd = _frm.value;
	var str_y = ymd.substring( 0,4 );
	var str_m = ymd.substring( 5,7 );
	var str_d = ymd.substring( 8,10 );
	var yy = parseInt( str_y, 10 );
	var mm = parseInt( str_m, 10 );
	var dd = parseInt( str_d, 10 );
	
  --mm;
  var dateVar = new Date(yy, mm, dd);
  //인수로 받은 년월일과 생성한 Date객체의 년월일이 일치하면 true
  if ( !(dateVar.getFullYear()==yy && dateVar.getMonth()==mm && dateVar.getDate()==dd) )
	{
		if( msg != "" ) alert( msg );
		_frm.focus();		
		return true;
	}
	
	return false;
}


/*
	Form 양식의 값이 날짜(YYYY-MM-DD) 형태인지 확인 
	
	Parameters :
		_str : 날짜 문자열
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/
function CheckStrDate(_str , msg){
		
	var str_y = _str.substring( 0,4 );
	var str_m = _str.substring( 5,7 );
	var str_d = _str.substring( 8,10 );
	var yy = parseInt( str_y, 10 );
	var mm = parseInt( str_m, 10 );
	var dd = parseInt( str_d, 10 );
	
  --mm;
  var dateVar = new Date(yy, mm, dd);
  //인수로 받은 년월일과 생성한 Date객체의 년월일이 일치하면 true
  if ( !(dateVar.getFullYear()==yy && dateVar.getMonth()==mm && dateVar.getDate()==dd) )
	{
		if( msg != "" ) alert( msg );		
		return true;
	}
	
	return false;
}


/*
	Form 양식의 문자열 길이를 확인
	
	Parameters :
		_frm : 문자열 값의 Form 양식
		_len : 문자열 길이
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/

function CheckStrLen( _frm, _len , msg){
		
	if( _frm.value.trim().length != _len ) {
		if( msg != "" ) alert( msg );		
		_frm.focus();
		return true;
	}
	
	return false;
}



/*
	Form 양식의 문자열 길이의 범위를 확인
	
	Parameters :
		_frm : 문자열 값의 Form 양식
		_len1 : 문자열 최소 길이
		_len2 : 문자열 최대 길이
		msg  : 양식의 값이 없는 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/

function CheckStrLenScope( _frm, _len1, _len2 , msg){
		
	if( _frm.value.trim().length < _len1 || _frm.value.trim().length > _len2 ) {
		if( msg != "" ) alert( msg );		
		_frm.focus();
		return true;
	}
	
	return false;
}



/*
	Form 양식의 파일 전송시 파일 확장자로 전송 불가능한 파일을 확인
	
	Parameters :
		_frm : 파일 Form 양식		
		msg  : 파일 양식의 파일명이 업로드 불가능 한 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/

function CheckUploadFilename ( _frm, msg ) {
	
	var filename = _frm.value.trim();
	
	if( filename == "" ) return false;  //파일명이 없는 경우 리텅
	
	var dot_idx = filename.lastIndexOf( '.' );	
	if( dot_idx < 0 ) return false;
			
	var ext = filename.substring( dot_idx );
	var ext = ext.toLowerCase();
	
	if( ext == ".asp" || ext == ".jsp" || ext == ".php" || ext == ".php3" || ext == ".html" || ext == ".phtml" ) {
		if( msg != "" ) alert( msg );		
		_frm.focus();
		return true;
	}
	
	return false;
	
}



///////////////////////////////////////////////////////////
// SELECT Form 양식의 Option 관련

/*
	SELECT 에 모든 OPTIONS 삭제
	
	Parameters : 
		_sel : SELECT 폼 양식
		startIndex : 삭제하려는 OPTIONS의 시작 인덱스
*/
function ClearSelectOptions( _sel, startIndex )
{
	var opts = _sel.options;
  var opts_len = opts.length
  for( var i=startIndex; i < opts_len ; i++ ) opts[startIndex] = null;
}


/*
	SELECT 에 특정 OPTIONS 삭제
	
	Parameters : 
		_sel : SELECT 폼 양식
		_rem_idx : 삭제하려는 OPTIONS의 인덱스
*/
function RemoveSelectOptions( _sel, _rem_idx  )
{
	var opts = _sel.options;  
  opts[_rem_idx] = null;
}


/*
	SELECT 에 모든 OPTIONS 값들 추가
	
	Parameters : 
		_sel : SELECT 폼 양식
		_data : 추가될 OPTION의 문자열
		_code : 추가될 OPTION의 value 값
*/
function AddSelectOptions( _sel, _data, _code )
{
	var opts = _sel.options;	
	opts[opts.length] = new Option( _data, _code );
  
}

//////////////////////////////////////////////////////////////////////////////
// Option 양식관련
/*
	Radio 양식에 선택된 값을 리턴합니다.
	
	Parameters : 
		_frm : Input.Radio 폼 양식		
*/
function GetRadioValue( _frm ) {
	var res= "";
	
	if( _frm.length == undefined ){
		if( _frm.checked ) res = _frm.value;		
	} else{
		for( var i=0; i < _frm.length; i++ ) {
			if( _frm[i].checked ) {
				res = _frm[i].value;
				break;
			}
		}		
	}		
	
	return res;
}



///////////////////////////////////////////////////////////////////////////////
//

/**
* 입력값의 바이트 길이를 리턴

* ex) if (getByteLength(form.title) > 100) {
* alert("제목은 한글 50자(영문 100자) 이상 입력할 수 없습니다.");
* }
* Author : Wonyoung Lee
*/
function getByteLength(input) {
	var byteLength = 0;
	for (var inx = 0; inx < input.value.length; inx++) {
	var oneChar = escape(input.value.charAt(inx));
	if ( oneChar.length == 1 ) {
	byteLength ++;
	} else if (oneChar.indexOf("%u") != -1) {
	byteLength += 2;
	} else if (oneChar.indexOf("%") != -1) {
	byteLength += oneChar.length/3;
	}
	}
	return byteLength;
}



/*
	Form 양식의 파일 전송시 파일 확장자로 전송 불가능한 파일을 확인
	
	Parameters :
		_frm : 파일 Form 양식		
		msg  : 파일 양식의 파일명이 업로드 불가능 한 경우 출력될 메시지 ( 문자열 값이 빈 경우이면 경고창 출력되지 않음 )
*/

function CheckUploadFilename ( _frm, msg ) {
	
	var filename = _frm.value.trim();
	
	if( filename == "" ) return false;  //파일명이 없는 경우 리텅
	
	var dot_idx = filename.lastIndexOf( '.' );	
	if( dot_idx < 0 ) return false;
			
	var ext = filename.substring( dot_idx );
	var ext = ext.toLowerCase();
	
	if( ext == ".asp" || ext == ".jsp" || ext == ".php" || ext == ".php3" || ext == ".html" || ext == ".phtml" ) {
		if( msg != "" ) alert( msg );		
		_frm.focus();
		return true;
	}
	
	return false;
	
}