var pageNum, pageNum2, pageNum3;

function gnb(){
	var GNB = KR('gnb');
	if(!GNB) return false;
	var one = GNB.child();
	var acTime = 1000;
	var subTag = "div";

	GNB.onmouseover = function(){
		clearTimeout(GNB.act)
		this.state = true;
		this.onmouseout = function(){
			this.state = false;
			start();
		}
	}
	//  img rollover
	// gnb Function
	for(i=0;i<one.length; i++){
		var btn = one[i].first('a');
		btn.n = i;
		btn.onmouseover = btn.onfocus = function(){
			clear();
			var img_1 = this.first('img');
			img_1.src = img_1.src.replace("_off","_on");
			one[this.n].style.zIndex="100";
			if(one[this.n].first(subTag))
				one[this.n].first(subTag).show();
		}
		if(!one[i].first(subTag)) continue;
		if(!one[i].first(subTag).first("ul")) continue;
		var two = one[i].first(subTag).first("ul").child();
		for(j=0;j<two.length; j++){
			var btn2 = two[j].first('a');
			btn2.onmouseover = function(){
				clearTimeout(GNB.act)
				var img = this.first('img'),twoAct = false;;
				if(this.className.indexOf('on')>=0) twoAct = true;
				else{
					if(img)
					img.src = img.src.replace('_off','_on');
					this.parent().addClass('on');
				}
				GNB.state = true;
				this.onmouseout = function(){
					if(!twoAct)
						if(img)
						img.src = img.src.replace('_on','_off');
					this.parent().removeClass('on')
					start();
					GNB.state = false;
				}
			}
			btn2.onfocus = function(){
				clearTimeout(GNB.act)
				var img = this.first('img'), twoAct = false;;
				if(img)
				if(img.src.indexOf('_on')>0) twoAct = true;
				if(img)
				img.src = img.src.replace('_off','_on');
				GNB.state = true;
				this.onblur = function(){
					if(!twoAct)
						if(img)
						img.src = img.src.replace('_on','_off');
					start();
					GNB.state = false;
				}
			}
		}

	}
	var start = function(){
		GNB.act = setTimeout(function(){
			if(!GNB.state) active();
		},acTime)
	}
	var clear = function(){
		for (i=0; i<one.length ; i++ ){
			one[i].style.zIndex="1"
			var img_1 = one[i].first('img');
			if(one[i].first(subTag))
				one[i].first(subTag).hide();
			if(img_1)
				img_1.src = img_1.src.replace("_on","_off")
		}
	}
	var active = function(){
		clear();
		if(subNum && one[subNum-1]){
			one[subNum-1].style.zIndex="100"
			var img_1 = one[subNum-1].first('img');
			img_1.src = img_1.src.replace("_off","_on");

			if(!one[subNum-1] || !one[subNum-1].first(subTag)) return false;
			if(!one[subNum-1] || !one[subNum-1].first(subTag).first("ul")) return false;
			var two = one[subNum-1].first(subTag).first("ul").child();
			one[subNum-1].first(subTag).show();
			if(pageNum && two[pageNum-1]){
				two[pageNum-1].first('a').className = "on";
				var twoIMG = two[pageNum-1].first('img');
				if(twoIMG)
				twoIMG.src = twoIMG.src.replace("_off","_on")
			}
		}
	}
	active();
}

function gm(id){
	var activeGm = 0;
	var Box = KR(id);
	var gmA = Box.childsFirst('a');
	var gmLIst = Box.getElementsByTagName('div');
	var clo = KR('close');
	for (i=0; i<gmLIst.length; i++){
		var btn = gmA[i];
		btn.count = i;
		clo.style.display = "none";
		btn.onclick = btn.onfocus = function (){
			var gmIMG  = this.first('img');
			clo.style.display = "";
			
			for (j=0; j<gmA.length; j++ ){
				try{ gmA[j].first('img').src = gmA[j].first('img').src.replace('_on','_off')
				}catch(e){ gmA[j].className = gmA[j].className.replace('on ','')}
				gmLIst[j].style.display = 'none';
			}
			try{ gmIMG.src = gmIMG.src.replace('_off','_on')
			}catch(e){ this.className = this.className.replace('','on ')}
			gmLIst[this.count].style.display = '';
			activeGm = this.count;
			return false;
		}
		gmLIst[i].style.display = 'none';
		gmLIst[i].style.position = "absolute";
	}
}

function initToggle(tabContainer) {
	triggers = tabContainer.getElementsByTagName("a");

	for(i = 0; i < triggers.length; i++) {
		if (triggers.item(i).href.split("#")[1])
			triggers.item(i).targetEl = document.getElementById(triggers.item(i).href.split("#")[1]);

		if (!triggers.item(i).targetEl)
			continue;

		triggers.item(i).targetEl.style.display = "none";
		triggers.item(i).onclick = function () {
			if (tabContainer.current == this) {
				this.className = this.className.replace('on','')
				this.targetEl.style.display = "none";
				tabContainer.current = null;
			} else {
				if (tabContainer.current) {
					tabContainer.current.targetEl.style.display = "none";
					tabContainer.current.className = this.className.replace('on','')
				}
				this.className = this.className.replace('','on')
				this.targetEl.style.display = "block";
				tabContainer.current = this;
			}
			return false;
		}
	}
}

function close(id){
	var clo = KR('close');
	var Box = KR(id);
	var gmLIst = Box.getElementsByTagName('div');

	clo.onclick = function (){
		for (i=0;i<gmLIst.length ;i++ ){
			gmLIst[i].style.display = "none";
		}
		clo.style.display = "none";
		return false;
	}
}



var npop_flag = false;

function npop_change(value) { 

	if(value > npop_length) value = 1;
	if(value < 1) value = npop_length;
	current_popup=value;

	var maxSize = 25// + (17 * npop_length) ; 
	for(i=npop_length;i>=1;i--) {
		if(obj = document.getElementById("npop_cont"+i)) {
			if(i==value) {
				obj.style.visibility="";
				obj.style.display="";
				obj.style.zIndex="99";
			} else {
				obj.style.visibility="hidden";
				obj.style.display="none";
				obj.style.zIndex="0";
			}
		}
	} 
	npop_flag = true;
}
function npop_play(value) {
	if(value == 0) popup_play = 0;
	else if(value == 1) popup_play = 1;
	if(popup_play==1) {
	npop_change(current_popup+1);
	setTimeout("npop_play()", 6000);
	}
}

var npop_length;
var current_popup ;
var popup_play ;








var rootHTML = $('html');



function windowResize(){
	if(rootHTML.width() >= 941){
		$('#wrap').removeClass('all small small2');

		$('#wrap2').removeClass('all small small2');
		$('#footerWrap').removeClass('all small small2');
	}else if(rootHTML.width() <= 940 && rootHTML.width() >= 636){

		$('#wrap').addClass('all');
		$('#wrap').removeClass('small small2');

		$('#wrap2').addClass('all');
		$('#wrap2').removeClass('small small2');
		$('#footerWrap').addClass('all');
		$('#footerWrap').removeClass('small small2');
	}else if(rootHTML.width() <= 635 && rootHTML.width() >= 480){

		$('#wrap').addClass('small');

		$('#wrap').removeClass('small2');
		$('#wrap2').addClass('small');
		$('#wrap2').removeClass('small2');
		$('#footerWrap').addClass('small');
		$('#footerWrap').removeClass('small2');

		$('#evnet_iframe').removeClass('all');
	}else if(rootHTML.width() <= 480){

		$('#wrap').addClass('all small small2');
		$('#wrap2').addClass('all small small2');
		$('#footerWrap').addClass('all small small2');

		$('#evnet_iframe').addClass('all');
	}
	$(document).ready(function(){
		var he = $('#npop').height();
		$('#rolling').css('height',(he - 8) + "px")
	});

}
function isMobileBrowser(a){
	return (/android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iphone|iris|kindle|lge |maemo|midp|mmp|o2|opera mini|palm( os)?|plucker|pocket|pre\/|psp|smartphone|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce; (iemobile|ppc)|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))
}
function setIFrameHeight(obj,setTime){
	if(obj.contentDocument){
		if(setTime == "ok") {
			if( isMobileBrowser(navigator.userAgent||navigator.vendor||window.opera)){
				setTimeout( function () { 
				obj.height = obj.contentDocument.body.offsetHeight + 40
				}, 4000);
			}
			else{
				setTimeout( function () { 
				obj.height = obj.contentDocument.body.offsetHeight + 40
				}, 2000);
			}
		}
		else obj.height = obj.contentDocument.body.offsetHeight + 40;
	}
	else {
		obj.height = obj.contentWindow.document.body.scrollHeight;
	}
}

