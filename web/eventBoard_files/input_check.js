/**
 * comma(x), uncomma(x)
 *
 * 숫자 표시 (3자리마다 콤마찍기)
 *
 * @Usage	var money = 1000;
 *			money = comma(money);
 *			alert(money);
 *			alert(uncomma(money));
 */

function comma(x)
{
	var temp = "";
	var x = String(uncomma(x));

	num_len = x.length;
	co = 3;
	while (num_len>0){
		num_len = num_len - co;
		if (num_len<0){
			co = num_len + co;
			num_len = 0;
		}
		temp = ","+x.substr(num_len,co)+temp;
	}
	return temp.substr(1);
}

function uncomma(x)
{
	var reg = /(,)*/g;
	x = parseInt(String(x).replace(reg,""));
	return (isNaN(x)) ? 0 : x;
}

function btn_overInput(f) {
    f.className = "onbox";
}

function btn_outInput(f) {
    f.className = "offbox";
}


//플래쉬 IE패치에 따른 테두리 없애기
function MakeFlash(Url,Width,Height,Vars){                 
  document.writeln("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"" + Width + "\" height=\"" + Height + "\">"); 
  document.writeln("<param name=\"movie\" value=\"" + Url + "\">"); 
  document.writeln("<param name=\"quality\" value=\"high\" />");     
  document.writeln("<param name=\"wmode\" value=\"transparent\">"); 
  document.writeln("<param name=\"FlashVars\" value=\""+ Vars +"\">"); 
  document.writeln("<embed src=\"" + Url + "\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"" + Width + "\"  height=\"" + Height + "\" wmode=\"transparent\">"); 
  document.writeln("</object>");     
} 

//윈도우하단 밑줄 텍스트
/*
var scrmsg = "열대과일 전문브랜드 _♡아이러브망고스틴♡_망고스틴_두리안_람부탄_리치_롱간_아보카도 등 전화주문가능 T.0505-233-2322                                               "; 
var scrspacer = " "; 
var scrpos = 0; 
function ScrollMessage() 
{ 
	window.status = scrmsg.substring(scrpos, scrmsg.length) + scrspacer + 
		scrmsg.substring(0,scrpos); 
	scrpos++; 
	if (scrpos > scrmsg.length) scrpos = 0; 
	window.setTimeout("ScrollMessage()", 500); 
} 

ScrollMessage(); 
*/

//길이 체크 함수(같은 경우=true, 같지 않은 경우=false)
function len_check(val, len_val){
	if(val.length!=len_val) return false;
	return true;
}


//숫자 검사
function num_check(val){
	if (isNaN(val)) return false;
	return true;
}

// 공백이 있는지 check
function empty_check(data) {
   for ( var i = 0 ; i < data.length ; i++ )    {
	  if ( data.substring( i, i+1 ) == " " )
		 return false;
   }
   return true;
}


// 한글으로 구성이 되어 있는지 Check
function han_check(val){
	var result = true;
	for(var i=0; i < val.length;i++){
		var ch=val.charCodeAt(i);
		if(ch > 255) continue;
		else{
			if(ch == 32) continue;
			result = false;
			break;
		}
	}
  return result;
}

// 영문이나 숫자로 이루어져 있는지 check
function eng_check(str) {
  for (i=0; i <= str.length -1 ; i++){
	ch = str.substring(i,i+1);
	if ((ch >= "0" && ch <= "9") || (ch >= "a"  && ch <= "z") ||(ch >= "A"  && ch <= "Z")){
		chk=true;
	}
	else{
		chk=false;
		break;
	}	
  }
  return chk;
}


// 날짜함수
function date_check(val){
	//입력값이 숫자인지 체크
	if (!num_check(val)) {
		alert("입력하신 날짜는 숫자가 아닙니다.");
		return false;
	}

	if (!len_check(val,8)) {
		alert("입력하신 날짜는 자릿수가 맞지 않습니다.");
		return false;
	}
	return true;
}

//url check
function url_check(val){
	if(val.length > 7){
		if ((  val.indexOf('http', 0) == -1) || val.indexOf('.') == -1) return true;
		else return false;
	}
	else return false;
}

//주민등록번호 체크하기
  function check_jumin(jumin) {
    var weight = "234567892345"; // 자리수 weight 지정
    var val = jumin.replace("-",""); // "-"(하이픈) 제거
    var sum = 0;

    if(val.length != 13) { return false; }

    for(i=0;i<12;i++) {
        sum += parseInt(val.charAt(i)) * parseInt(weight.charAt(i));
    }

    var result = (11 - (sum % 11)) % 10;
    var check_val = parseInt(val.charAt(12));

    if(result != check_val) { return false; }
    return true;
  }

//주민 번호 체크 함수
function jumin_check(jumin1,jumin2){
	if (!num_check(jumin1)){
		alert("입력하신 주민등록번호는 숫자가 아닙니다.");
		return false;
	}
	if (!num_check(jumin2)){
		alert("입력하신 주민등록번호는 숫자가 아닙니다.");
		return false;
	}

	if (!len_check(jumin1,6)){
		alert("입력하신 주민등록번호의 자릿수가 맞지 않습니다.");
		return false;
	}

	if (!len_check(jumin2,7)){
		alert("입력하신 주민등록번호의 자릿수가 맞지 않습니다.");
		return false;
	}

	var jumin = jumin1 + jumin2;
	var check_sum = parseInt(jumin.charAt(0))*2 + parseInt(jumin.charAt(1))*3
               	  + parseInt(jumin.charAt(2))*4 + parseInt(jumin.charAt(3))*5
               	  + parseInt(jumin.charAt(4))*6 + parseInt(jumin.charAt(5))*7
               	  + parseInt(jumin.charAt(6))*8 + parseInt(jumin.charAt(7))*9
               	  + parseInt(jumin.charAt(8))*2 + parseInt(jumin.charAt(9))*3
               	  + parseInt(jumin.charAt(10))*4 + parseInt(jumin.charAt(11))*5;
 	check_sum = check_sum % 11;
 	check_sum = 11 - check_sum;
 	var check_digit = parseInt(jumin.charAt(12));

 	if (check_sum >= 10) check_sum = check_sum - 10;
 	if (check_digit != check_sum){
		alert("옳지 않은 주민등록번호입니다.");
		return false;
	}
 	return true;
}


//다음우표제 관련 한메일 체크... 
function hanmail_check(val){
  if (val.match("@hanmail.net") == null && val.match("@daum.net") == null) return true;
  else return false;
}


//메일 체크... 
function email_check(emailval){
	var checkTLD=1;
	var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
	var emailPat=/^(.+)@(.+)$/;		
	var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";		
	var validChars="\[^\\s" + specialChars + "\]";		
	var quotedUser="(\"[^\"]*\")";		
	var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;		
	var atom=validChars + '+';		
	var word="(" + atom + "|" + quotedUser + ")";		
	var userPat=new RegExp("^" + word + "(\\." + word + ")*$");		
	var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
	var matchArray=emailval.match(emailPat);
	if (matchArray==null)	return false;
	var user=matchArray[1];
	var domain=matchArray[2];

	for (i=0; i<user.length; i++){
		if (user.charCodeAt(i)>127)	return false;
	}
	for (i=0; i<domain.length; i++){
		if (domain.charCodeAt(i)>127)	return false;
	}
	if (user.match(userPat)==null) return false;

	var IPArray=domain.match(ipDomainPat);
	if (IPArray!=null){
		for (var i=1;i<=4;i++){
			if (IPArray[i]>255)	return false;
		}
		return true;
	}
	
	var atomPat=new RegExp("^" + atom + "$");
	var domArr=domain.split(".");
	var len=domArr.length;
		
	for (i=0;i<len;i++){
		if (domArr[i].search(atomPat)==-1) return false;
	}
	
	if (checkTLD&&domArr[domArr.length-1].length!=2&&domArr[domArr.length-1].search(knownDomsPat)==-1) return false;
	if (len<2) return false;
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////
// String 길이를 구하는 Script By Moon
//
//      * CheckStrLen(obj, MaxLen, ErrorMessage)
//	    - obj : text or textarea object
//		--> MaxLen 보다 문자열이 짧으면 true, 길면 false 리턴
//        - 필드명 : Error가 발생한 필드의 이름
//		--> "" 로 넣으면..Alert 띄우지 않음. (비우면 안됨..)
//////////////////////////////////////////////////////////////////////////////////////////////
function CheckStrLen(obj, MaxLen, FieldName) {
	var i, len=0;
// added by ayasiee
	if (typeof obj == "undefined") {
		return true
	}
// added by ayasiee
	var s = obj.value;

	// String 길이를 구하는 부분..
	for(i=0;i < s.length; i++) (s.charCodeAt(i) > 255)? len+=2:len++;

	// 길이 확인.
	if (MaxLen < len) {
		if (FieldName != "") alert(FieldName + "은(는) " + MaxLen + "자를 넘을 수 없습니다(한글은 글자당 2자로 계산됩니다.)");
		obj.focus();
		return false;
	}
	return true;
}


//오픈윈도우창 처리
function open_window(mypage,myname,w,h,scroll){
  var win= null;
  var winl = (screen.width-w)/2;
  var wint = (screen.height-h)/2;
  var settings = 'status=yes,';
	  settings +='height='+h+',';
      settings +='width='+w+',';
      settings +='top='+wint+',';
      settings +='left='+winl+',';
      settings +='scrollbars='+scroll+',';
      settings +='resizable=yes';
  win=window.open(mypage,myname,settings);
  if(parseInt(navigator.appVersion) >= 4){win.window.focus();}
}
// 테이블 모서리 둥글게 처리
/*
//사용법 
아래의 테이블시작에 태크를 삽입한 후
<table id="ta" radius="3" rborder="#CC66FF" rbgcolor="ffffff" width="550" border="0" cellspacing="1" cellpadding="3">
끝나는 지점에 아래와 같이 태그를 삽입하면 끝
<script>roundTable("ta");</script>
*/
function roundTable(objID) {
       var obj = document.getElementById(objID);
       var Parent, objTmp, Table, TBody, TR, TD;
       var bdcolor, bgcolor, Space;
       var trIDX, tdIDX, MAX;
       var styleWidth, styleHeight;

       // get parent node
       Parent = obj.parentNode;
       objTmp = document.createElement('SPAN');
       Parent.insertBefore(objTmp, obj);
       Parent.removeChild(obj);

       // get attribute
       bdcolor = obj.getAttribute('rborder');
       bgcolor = obj.getAttribute('rbgcolor');
       radius = parseInt(obj.getAttribute('radius'));
       if (radius == null || radius < 1) radius = 1;
       else if (radius > 6) radius = 6;

       MAX = radius * 2 + 1;
       
       /*
              create table {{
       */
       Table = document.createElement('TABLE');
       TBody = document.createElement('TBODY');

       Table.cellSpacing = 0;
       Table.cellPadding = 0;

       for (trIDX=0; trIDX < MAX; trIDX++) {
              TR = document.createElement('TR');
              Space = Math.abs(trIDX - parseInt(radius));
              for (tdIDX=0; tdIDX < MAX; tdIDX++) {
                     TD = document.createElement('TD');
                     
                     styleWidth = '1px'; styleHeight = '1px';
                     if (tdIDX == 0 || tdIDX == MAX - 1) styleHeight = null;
                     else if (trIDX == 0 || trIDX == MAX - 1) styleWidth = null;
                     else if (radius > 2) {
                            if (Math.abs(tdIDX - radius) == 1) styleWidth = '2px';
                            if (Math.abs(trIDX - radius) == 1) styleHeight = '2px';
                     }

                     if (styleWidth != null) TD.style.width = styleWidth;
                     if (styleHeight != null) TD.style.height = styleHeight;

                     if (Space == tdIDX || Space == MAX - tdIDX - 1) TD.style.backgroundColor = bdcolor;
                     else if (tdIDX > Space && Space < MAX - tdIDX - 1)  TD.style.backgroundColor = bgcolor;
                     
                     if (Space == 0 && tdIDX == radius) TD.appendChild(obj);
                     TR.appendChild(TD);
              }
              TBody.appendChild(TR);
       }

       /*
              }}
       */

       Table.appendChild(TBody);
       
       // insert table and remove original table
       Parent.insertBefore(Table, objTmp);
}


function gourl(url) {
	document.location.replace(url);
}

function msg_gourl(msg,url) {
	if(confirm(msg)) document.location.replace(url);
}

function closemsg(url,msg) {
	alert(msg);
	document.location.replace(url);
	window.close();
}

function openclose_nomsg(url) {
	opener.document.location.replace(url);
	window.close();
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}



