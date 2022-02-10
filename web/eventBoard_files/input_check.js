/**
 * comma(x), uncomma(x)
 *
 * ���� ǥ�� (3�ڸ����� �޸����)
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


//�÷��� IE��ġ�� ���� �׵θ� ���ֱ�
function MakeFlash(Url,Width,Height,Vars){                 
  document.writeln("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"" + Width + "\" height=\"" + Height + "\">"); 
  document.writeln("<param name=\"movie\" value=\"" + Url + "\">"); 
  document.writeln("<param name=\"quality\" value=\"high\" />");     
  document.writeln("<param name=\"wmode\" value=\"transparent\">"); 
  document.writeln("<param name=\"FlashVars\" value=\""+ Vars +"\">"); 
  document.writeln("<embed src=\"" + Url + "\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"" + Width + "\"  height=\"" + Height + "\" wmode=\"transparent\">"); 
  document.writeln("</object>");     
} 

//�������ϴ� ���� �ؽ�Ʈ
/*
var scrmsg = "������� �����귣�� _�����̷������ƾ��_����ƾ_�θ���_����ź_��ġ_�հ�_�ƺ�ī�� �� ��ȭ�ֹ����� T.0505-233-2322                                               "; 
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

//���� üũ �Լ�(���� ���=true, ���� ���� ���=false)
function len_check(val, len_val){
	if(val.length!=len_val) return false;
	return true;
}


//���� �˻�
function num_check(val){
	if (isNaN(val)) return false;
	return true;
}

// ������ �ִ��� check
function empty_check(data) {
   for ( var i = 0 ; i < data.length ; i++ )    {
	  if ( data.substring( i, i+1 ) == " " )
		 return false;
   }
   return true;
}


// �ѱ����� ������ �Ǿ� �ִ��� Check
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

// �����̳� ���ڷ� �̷���� �ִ��� check
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


// ��¥�Լ�
function date_check(val){
	//�Է°��� �������� üũ
	if (!num_check(val)) {
		alert("�Է��Ͻ� ��¥�� ���ڰ� �ƴմϴ�.");
		return false;
	}

	if (!len_check(val,8)) {
		alert("�Է��Ͻ� ��¥�� �ڸ����� ���� �ʽ��ϴ�.");
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

//�ֹε�Ϲ�ȣ üũ�ϱ�
  function check_jumin(jumin) {
    var weight = "234567892345"; // �ڸ��� weight ����
    var val = jumin.replace("-",""); // "-"(������) ����
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

//�ֹ� ��ȣ üũ �Լ�
function jumin_check(jumin1,jumin2){
	if (!num_check(jumin1)){
		alert("�Է��Ͻ� �ֹε�Ϲ�ȣ�� ���ڰ� �ƴմϴ�.");
		return false;
	}
	if (!num_check(jumin2)){
		alert("�Է��Ͻ� �ֹε�Ϲ�ȣ�� ���ڰ� �ƴմϴ�.");
		return false;
	}

	if (!len_check(jumin1,6)){
		alert("�Է��Ͻ� �ֹε�Ϲ�ȣ�� �ڸ����� ���� �ʽ��ϴ�.");
		return false;
	}

	if (!len_check(jumin2,7)){
		alert("�Է��Ͻ� �ֹε�Ϲ�ȣ�� �ڸ����� ���� �ʽ��ϴ�.");
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
		alert("���� ���� �ֹε�Ϲ�ȣ�Դϴ�.");
		return false;
	}
 	return true;
}


//������ǥ�� ���� �Ѹ��� üũ... 
function hanmail_check(val){
  if (val.match("@hanmail.net") == null && val.match("@daum.net") == null) return true;
  else return false;
}


//���� üũ... 
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
// String ���̸� ���ϴ� Script By Moon
//
//      * CheckStrLen(obj, MaxLen, ErrorMessage)
//	    - obj : text or textarea object
//		--> MaxLen ���� ���ڿ��� ª���� true, ��� false ����
//        - �ʵ�� : Error�� �߻��� �ʵ��� �̸�
//		--> "" �� ������..Alert ����� ����. (���� �ȵ�..)
//////////////////////////////////////////////////////////////////////////////////////////////
function CheckStrLen(obj, MaxLen, FieldName) {
	var i, len=0;
// added by ayasiee
	if (typeof obj == "undefined") {
		return true
	}
// added by ayasiee
	var s = obj.value;

	// String ���̸� ���ϴ� �κ�..
	for(i=0;i < s.length; i++) (s.charCodeAt(i) > 255)? len+=2:len++;

	// ���� Ȯ��.
	if (MaxLen < len) {
		if (FieldName != "") alert(FieldName + "��(��) " + MaxLen + "�ڸ� ���� �� �����ϴ�(�ѱ��� ���ڴ� 2�ڷ� ���˴ϴ�.)");
		obj.focus();
		return false;
	}
	return true;
}


//����������â ó��
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
// ���̺� �𼭸� �ձ۰� ó��
/*
//���� 
�Ʒ��� ���̺���ۿ� ��ũ�� ������ ��
<table id="ta" radius="3" rborder="#CC66FF" rbgcolor="ffffff" width="550" border="0" cellspacing="1" cellpadding="3">
������ ������ �Ʒ��� ���� �±׸� �����ϸ� ��
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



