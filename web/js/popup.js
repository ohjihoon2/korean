/*
 * name - js/popup.js
 * developer - (주)빛솔커뮤니케이션 개발팀 김보검
 * create - 2022-02-25
 * update - 2022-02-25
 */


$(document).ready(function(){
	$('#popupOpen').click(function() {
		$('#popupBack').show();
		$('#newslettersPoppup').show();
	});

	$('#popup1').click(function() {
		if($('#newsletter_tab01').css("display") == "none") {
			$('#newsletter_tab02').hide();
			$('#newsletter_tab01').show();
			$('.popup_tabmenu li').removeClass('current');
			$(this).addClass('current');
			$(".popup_section input[type='text']").val("");
			$(".popup_section input[type='checkbox']").prop("checked", false);
		}
	});

	$('#popup2').click(function() {
		if($('#newsletter_tab02').css("display") == "none") {
			$('#newsletter_tab01').hide();
			$('#newsletter_tab02').show();
			$('.popup_tabmenu li').removeClass('current');
			$(this).addClass('current');
			$(".popup_section input[type='text']").val("");
			$(".popup_section input[type='checkbox']").prop("checked", false);
		}
	});
})


function submitReception5_1() {
	var f = document.reception5_1;

	if (CheckEmpty(f.name, "이름을 입력해 주세요.")) return;
	if (CheckEmpty(f.email, "전자 우편 주소를 입력해 주세요.")) return;
	if (CheckCount(f.check1, "수신 동의 체크란에 체크 해 주시기 바랍니다.")) return;

	f.action = "/page/newsletter_receipt_pro.jsp";
	f.submit();
}

function submitReception5_2() {


	var f = document.reception5_2;
	if (CheckEmpty(f.email, "전자 우편 주소를 입력해 주세요.")) return;
	if (CheckCount(f.check1, "수신 거부 체크란에 체크 해 주시기 바랍니다.")) return;
	f.action = "/page/newsletter_receipt_pro.jsp";
	f.submit();
}

function hideReception() {
	$('#popupBack').hide();
	$('#newslettersPoppup').hide();

	$(".popup_section input[type='text']").val("");
	$(".popup_section input[type='checkbox']").prop("checked", false);
}
