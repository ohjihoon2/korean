
//* check browser
var isie=navigator.userAgent.toLowerCase().indexOf('msie')!=-1 ? 1 : 0;
var isie6=navigator.userAgent.toLowerCase().indexOf('6.0')!=-1 ? 1 : 0;
var isie7=navigator.userAgent.toLowerCase().indexOf('7.0')!=-1 ? 1 : 0;
var isff=navigator.userAgent.toLowerCase().indexOf('firefox')!=-1 ? 1 : 0;
var isopera=navigator.userAgent.toLowerCase().indexOf('opera')!=-1 ? 1 : 0;
var issafari=navigator.userAgent.toLowerCase().indexOf('safari')!=-1 ? 1 : 0;
var defaultTime = 20;
var getBrowser = function() {
	if(navigator.userAgent.toLowerCase().indexOf("msie")>=0) {
		return "ie";
	}else if (navigator.userAgent.toLowerCase().indexOf("firefox")>=0) {
		return "ff";
	}else if (navigator.userAgent.toLowerCase().indexOf("opera")>=0) {
		return "op";
	}else if (navigator.userAgent.toLowerCase().indexOf("safari")>=0) {
		return "sf";
	}
}

if(isie6){
	try {document.execCommand('BackgroundImageCache', false, true)} catch(e) {}
}

/* minimum_kr_code. by _Kim kr_ */

function addLoadEvent(func){
	var oldonload = window.onload;
	
	if(typeof window.onload != 'function'){
		window.onload = func;
		
	}else{
		window.onload = function(){
			oldonload();
			eval(func)();
		}
	}
}
var KR = function(obj){
	if(obj.constructor==Array){
		for(var i=0,max=obj.length,returnvalue=[]; i<max; i++) returnvalue.push(obj[i]);
		return lib.extend(returnvalue);
	}
	if(typeof(obj)=='string') obj=document.getElementById(obj);
	if(obj) return lib.extend(obj);
};

var lib = {
	extend : function(obj){  
		var lib = KR;
		obj.child = function(){	
			var childnodes=this.childNodes,returnvalue=lib([]);
			for(var i=0,max=childnodes.length; i<max; i++) if(childnodes[i].nodeType==1) returnvalue.push(lib(childnodes[i]));
			return returnvalue ;
		};
		obj.first = function(el) {
			var a = this;
			if(a.length){
				var arr=[];
				for(i=0 ; i<a.length ; i++)
					if(el){
						var elem = a[i].getElementsByTagName(el)[0] ? a[i].getElementsByTagName(el)[0] : null&& a[i];
						elem = elem ? lib(elem) : null && a[i];
						arr.push(elem)
					}else{
						var elem = a[i];
						elem = elem.firstChild;
						var elel =  elem && elem.nodeType != 1 ? elem.nextSibling : elem ;
						arr.push(lib(elem))
					}
				return lib(arr);
			}else{
				if(el){
					var elem = this.getElementsByTagName(el)[0] ?this.getElementsByTagName(el)[0] : null&& this;
					elem = elem ? lib(elem) : null&& this;
					return elem
				}else{
					var elem = this;
					elem = elem.firstChild;
					var elel =  elem && elem.nodeType != 1 ? elem.nextSibling : elem ;
					return lib(elel);
				}
			}
		};
		obj.childsFirst = function(el){
			var childnodes=this.childNodes,returnvalue=[];
			for(var i=0,max=childnodes.length; i<max; i++) 
					if(childnodes[i].nodeType==1) {
						var elem = childnodes[i].getElementsByTagName(el)[0] ? childnodes[i].getElementsByTagName(el)[0] : null && childnodes[i];
						elem = elem ? lib(elem) : null && childnodes[i];
						returnvalue.push(elem)
					}
			return returnvalue ;
		}
		obj.parent=function(num){ 
			var elem = this;
			num = num || 1;
			for ( var i = 0; i < num; i++ )
				if ( elem != null ) elem = elem.parentNode;
			return lib(elem);
		};
		obj.elementsName=function(name){ 
			var elem = this;
			nodes = elem.getElementsByTagName(name)
			for ( var i = 0; i < nodes.length ; i++ )
				lib(nodes[i]);
			return lib(nodes);
		};
		obj.getElements=function(name){ 
			var elem = this;
			nodes = elem.getElementsByTagName(name)
			for ( var i = 0; i < nodes.length ; i++ )
				lib(nodes[i])
			return lib(nodes);
		};
		obj.parentName=function(name){ 
			var elem = this;
			for ( var i = 0; i < 1; i++ ){
				if ( elem != null ) elem = elem.parentNode;
				if(name){
					if(!elem.parentNode){
						elem = null;
						return elem;
					}
					if(elem.nodeName.toLowerCase()  != name)
						if(elem.nodeName.toUpperCase()  != name)
							i--;
				}
			}	
			return lib(elem);
		};
		obj.getElementsByClassName=function(classname,nodeName){
			var parent = this;
			if(!nodeName) nodeName="*";
			var children = parent.getElementsByTagName(nodeName),returnvalue=[];
			for(var i=0,max=children.length; i<max; i++) {
				if(children[i].className!='' && (children[i].className.indexOf(classname)>=0)) 
					returnvalue.push(lib(children[i]));
			}
			return lib(returnvalue);
		};
		obj.hide=function(){
			var a = this;
			try{
				if(a.length){
					for(i=0;i<a.length;i++)
						a[i].style.display='none';
				}else{
					a.style.display='none';
				}
			}catch(e){

			}
			return a;
		};
		obj.show=function(display){
			this.style.display=(!display)? '' : display;
			return this;
		};
		obj.togle=function(display){
			this.style.display=(this.style.display == 'none')? '' : 'none';
			return this;
		};
		obj.over=function(){
			var imgs = this.getElementsByTagName('img');
			for( i=0 ; i < imgs.length ; i++){
				var o = imgs[i];
				o.i = i;
				o.onmouseover = function(){ 
					if(this.src.indexOf('_on')>0) return false;					
					this.src = this.src.replace('_off','_on');
					this.onmouseout  = function(){
						this.src = this.src.replace('_on','_off');
					}
				}
				/*
				if(o.parentNode.nodeName.toLowerCase() == "a"){
					var link = o.parentNode;
					link.img = o;
					link.onfocus = function(){
						this.img.over()
					}
				}*/
			}
			return this;
		};
		obj.even=function(){
			var tr  = obj.getElementsByTagName('tr')
			for(i=0;i<tr.length;i++) if(i%2 == 1) tr[i].className = "even";
			return this;
		};
		obj.odd=function(){
			var tr  = obj.getElementsByTagName('tr')
			for(i=0;i<tr.length;i++) if(i%2 == 0) tr[i].className = "odd";
			return this;
		};
		obj.addClass=function(val){
			this.className = this.className+" "+val;
			return this;
		};
		obj.removeClass=function(val){
			if(this.className.indexOf(val) >0)
				this.className = this.className.replace(val,'');
			return this;
		};
		obj.checkElem = function(){ 
			var r = [],a = this;
			if ( a.constructor != Array ) a = [ a ];
			for ( var i = 0; i < a.length; i++ ) {
				if ( a[i].constructor == String ) {
					var div = document.createElement("div");
					div.innerHTML = a[i];
					 for ( var j = 0; j < div.childNodes.length; j++ )
						 r[r.length] = div.childNodes[j];
				} else if ( a[i].length ) { 
					for ( var j = 0; j < a[i].length; j++ )
						r[r.length] = a[i][j];
				} else {
					r[r.length] = a[i];
				}
			}
			return r;
		};
		obj.evtStop = function() {
			var event=window.event;
			try {
				if (!event.stopPropagation) {
					event.cancelBubble=true;
				} else {
					event.stopPropagation();
				}
			} catch(e) {}
		};
		obj.setPosition=function(left,top){
			this.style.left=left+'px';
			this.style.top=top+'px';
		};
		obj.setOpacity=function(value){
			if(isie) this.style.filter='alpha(opacity='+value+')';
			else this.style.opacity=value/100;
		};
		obj.getOpacity=function(){
			if(isie){
				if(this.style.filter!='') var returnvalue=parseInt(this.style.filter.match(/alpha\(opacity=([0-9]+)\)/)[1]);
			}else var returnvalue=this.style.opacity*100;
			return (returnvalue || returnvalue===0)? returnvalue : 100;
		};
		obj.opacityAni=function(value,speed,afterfunction){			// 투명도 조절 스크립트 ==> $('wrap').opacityani(30)  
			var opacity,speed=(!speed)? 5 : speed,obj=this;
			clearTimeout(this.opacityact);
			var action=function(){
				clearTimeout(obj.opacityact);
				opacity=obj.getOpacity();
				if(opacity===null || opacity==value){
					//'dfdf'.result();
					if(afterfunction) eval(afterfunction)();
				}else{
					obj.setOpacity((opacity<value)? opacity+Math.ceil((value-opacity)/speed) : opacity-Math.ceil((opacity-value)/speed));
					obj.opacityact=setTimeout(action,defaultTime);
				}
			};
			action();
		};

		/* 2010 new  */
		obj.each = function(func){	
			for(i=0;i<this.length;i++){this[i].func = func;this[i].n = i; this[i].func(this[i],this[i].n);}
		};
		obj.replaceSrc=function(a,b){ 
			var img = this;
			if(img.nodeName.toLowerCase() != "img"){
				img = this.getElementsByTagName('img')[0];
			};
			if(!img){ alert('img not found \n id = ' + this.id + ' tag = ' + this.nodeName); return this; }
			img.src = img.src.replace(a,b);
			return this;
		};
		obj.getNode=function(val){
			alert(this.nodeName);
			return this;
		};

		return obj;
	}
};




//비밀번호체크(영대문자+ 영소문자 + 숫자 + 특수문자)
//영대문자, 영소문자, 숫자 및 특수문자 2종류 구성시에 최소 10자리 이상, 3종류 이상 최소 8자리 이상 
//2013. 5. 9 기존 비밀번호 입력시 체크 스크립트 변경요청에 따른 조치
function checkPass(pw, pw_min_len, pw_max_len) {
	var alpha_up = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var alpha_low = "abcdefghijklmnopqrstuvwxyz";
	var number = "1234567890";
	var sChar = "-_=+\|()*&^%$#@!~`?></;,.:[]{}";

	var sCharCheck = false;
	var alphaCheck_up = false;
	var alphaCheck_low = false;
	var numberCheck = false;
	var chkPassCount = 0;


	for(var i=0; i < pw.length; i++) {
		if(sChar.indexOf(pw.charAt(i)) != -1) {
			sCharCheck = true;
		}
		if(alpha_up.indexOf(pw.charAt(i)) != -1) {
			alphaCheck_up = true;
		}
		if(alpha_low.indexOf(pw.charAt(i)) != -1) {
			alphaCheck_low = true;
		}
		if (number.indexOf(pw.charAt(i)) != -1) {
			numberCheck = true;
		}
	}//for


	if(sCharCheck) { chkPassCount++;}
	if(alphaCheck_up) { chkPassCount++; }
	if(alphaCheck_low) { chkPassCount++; }
	if(numberCheck) { chkPassCount++; }


	if(chkPassCount == 2) {
		pw_min_len = 10;
	} else if(chkPassCount > 2) {
		pw_min_len = 8;
	} else {
		pw_min_len = -1; 
	}

	if(pw_min_len == -1) {
		alert("비밀번호는 영대문자, 영소문자, 숫자, 특수문자를 혼용하여야 합니다.");
		return false;
	} else {
		if(pw_min_len <= pw.length && pw.length <= pw_max_len) {
		} else {
			alert("비밀번호는 " + pw_min_len + "~" + pw_max_len + "자 영대문자, 영소문자, 숫자, 특수문자를 혼용하여야 합니다.");
			return false;
		}
	}
	return true;
}