/*
	UPDATE : 2009-12-16 ���� 3:11:19	
*/


///////////////////////////////////////////////////////
// ���ڿ� Prototype
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
// Check �Լ�

/*
	���ڿ��� Ư�� ���ڵ��� ���ԵǾ����� Ȯ���ϴ� �Լ�
	
	Parameters :
		input : ���� ���ڿ�
		chars : ���ԵǾ� �ִ��� Ȯ���ϴ� ���ڵ�� ������ ���ڿ�
		
	Returns : 
		���ԵǾ� ������ true 
		
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
// Form ��� Validateion

/*
	Form ����� ���� ����ִ��� Ȯ�� 
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )		
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
	Form ����� ���� ����ִ��� Ȯ�� 
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )		
	return :
		üũ�� �� ����� ���� �����Ѵ�.
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
	Form ����� ���� ����ִ��� Ȯ�� 
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )		
	return :
		üũ�� �� ����� ���� �����Ѵ�.
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
	Form ����� ���� ����ִ��� Ȯ�� 
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )		
	return :
		üũ�� �� ����� ���� �����Ѵ�.
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
	�������� Ȯ�� 
	
	Parameters :
		_frm : ���ڿ�( ���ڰ� ���Ե� )
	
*/
function IsNumber( _frm )
{
	var chars="0123456789";
	
	return containsCharsOnly( _frm, chars );
	
}



/*
	Form ����� ���� �������� Ȯ�� 
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
	Form ����� ���� �������� Ȯ�� ( CheckNumber�� ��������� '-'�� ���ڷ� ����Ѵ�. )
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
	Form ����� ���� �������� Ȯ�� ( CheckInteger�� ��������� ','�� ���ڷ� ����Ѵ�. , ','�� ���� ��� ��ȿ�ϴٰ� �Ǵ��ϴµ�, ','�� ���Ǹ� ���Ŀ� �¾ƾ� �Ѵ�.)
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
	���ڿ��ε� 3�ڸ� ���ڵ鿡 �ĸ��� �߰����ִ� �Լ�
	
	Parameters :
		obj : ���ڿ�
		
	EX 1)
		formatCurrency( "-1234" ) -> "-1,234"
		
	EX 2) - TEXT ��Ŀ��� ����� ��� ( �����Է��ϸ鼭 �ĸ� ���϶� )
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
	���ڿ��ε� 3�ڸ� ���ڵ鿡 �ĸ��� �߰����ִ� �Լ�
	
	Parameters :
		obj : ���ڿ�
		
	EX )
		formatCurrency( "-1234" ) -> "-1,234"
*/
function trimComma( obj ){
	var returnVal = String( obj );
	
	return returnVal.replace( /,/g, "" );
}




/*
	Form ����� ���� ID�� ��ȣ�� �ɼ� �ִ��� ( ���� �� ���� ) �˻�
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
	Form ����� ���� ID�� ��ȣ�� �ɼ� �ִ��� ( ���� �� ���� �������� ) �˻� 
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
	���ڿ��� Date ��ü�� ��ȯ
	
	Parameters :
		ymd : ��¥���� ���ڿ�
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
	Date ��ü�� ���ڿ��� ��ȯ
	
	Parameters :
		_date : Date ��ü
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
	Form ����� ���� ��¥(YYYY-MM-DD) �������� Ȯ�� 
	
	Parameters :
		_frm : �����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
  //�μ��� ���� ����ϰ� ������ Date��ü�� ������� ��ġ�ϸ� true
  if ( !(dateVar.getFullYear()==yy && dateVar.getMonth()==mm && dateVar.getDate()==dd) )
	{
		if( msg != "" ) alert( msg );
		_frm.focus();		
		return true;
	}
	
	return false;
}


/*
	Form ����� ���� ��¥(YYYY-MM-DD) �������� Ȯ�� 
	
	Parameters :
		_str : ��¥ ���ڿ�
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
  //�μ��� ���� ����ϰ� ������ Date��ü�� ������� ��ġ�ϸ� true
  if ( !(dateVar.getFullYear()==yy && dateVar.getMonth()==mm && dateVar.getDate()==dd) )
	{
		if( msg != "" ) alert( msg );		
		return true;
	}
	
	return false;
}


/*
	Form ����� ���ڿ� ���̸� Ȯ��
	
	Parameters :
		_frm : ���ڿ� ���� Form ���
		_len : ���ڿ� ����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
	Form ����� ���ڿ� ������ ������ Ȯ��
	
	Parameters :
		_frm : ���ڿ� ���� Form ���
		_len1 : ���ڿ� �ּ� ����
		_len2 : ���ڿ� �ִ� ����
		msg  : ����� ���� ���� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
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
	Form ����� ���� ���۽� ���� Ȯ���ڷ� ���� �Ұ����� ������ Ȯ��
	
	Parameters :
		_frm : ���� Form ���		
		msg  : ���� ����� ���ϸ��� ���ε� �Ұ��� �� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
*/

function CheckUploadFilename ( _frm, msg ) {
	
	var filename = _frm.value.trim();
	
	if( filename == "" ) return false;  //���ϸ��� ���� ��� ����
	
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
// SELECT Form ����� Option ����

/*
	SELECT �� ��� OPTIONS ����
	
	Parameters : 
		_sel : SELECT �� ���
		startIndex : �����Ϸ��� OPTIONS�� ���� �ε���
*/
function ClearSelectOptions( _sel, startIndex )
{
	var opts = _sel.options;
  var opts_len = opts.length
  for( var i=startIndex; i < opts_len ; i++ ) opts[startIndex] = null;
}


/*
	SELECT �� Ư�� OPTIONS ����
	
	Parameters : 
		_sel : SELECT �� ���
		_rem_idx : �����Ϸ��� OPTIONS�� �ε���
*/
function RemoveSelectOptions( _sel, _rem_idx  )
{
	var opts = _sel.options;  
  opts[_rem_idx] = null;
}


/*
	SELECT �� ��� OPTIONS ���� �߰�
	
	Parameters : 
		_sel : SELECT �� ���
		_data : �߰��� OPTION�� ���ڿ�
		_code : �߰��� OPTION�� value ��
*/
function AddSelectOptions( _sel, _data, _code )
{
	var opts = _sel.options;	
	opts[opts.length] = new Option( _data, _code );
  
}

//////////////////////////////////////////////////////////////////////////////
// Option ��İ���
/*
	Radio ��Ŀ� ���õ� ���� �����մϴ�.
	
	Parameters : 
		_frm : Input.Radio �� ���		
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
* �Է°��� ����Ʈ ���̸� ����

* ex) if (getByteLength(form.title) > 100) {
* alert("������ �ѱ� 50��(���� 100��) �̻� �Է��� �� �����ϴ�.");
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
	Form ����� ���� ���۽� ���� Ȯ���ڷ� ���� �Ұ����� ������ Ȯ��
	
	Parameters :
		_frm : ���� Form ���		
		msg  : ���� ����� ���ϸ��� ���ε� �Ұ��� �� ��� ��µ� �޽��� ( ���ڿ� ���� �� ����̸� ���â ��µ��� ���� )
*/

function CheckUploadFilename ( _frm, msg ) {
	
	var filename = _frm.value.trim();
	
	if( filename == "" ) return false;  //���ϸ��� ���� ��� ����
	
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