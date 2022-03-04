$(document).ready(function() {

	$(window).resize(function (){
		var width_size = window.outerWidth;
		if (width_size <= 768) {
			$('.con4>ul').removeClass('con_flex')
		}
		else{
			$('.con4>ul').addClass('con_flex')
		}
	})

	// --모바일 메뉴 고정--
	$(window).scroll(
		function(){
			if(window.pageYOffset >= $('section').offset().top){
				$('header h1').addClass('on');

			}else{
				$('header h1').removeClass('on');
				$('h1').removeClass('menu_x');
				$('h1').removeClass('search_x');
				$('nav').removeClass('on');
				$('#mobile_gnb').removeClass('on');
				$('.search').removeClass('on');
				$('#modal').removeClass('on');
			}
		}
	);

	// --모바일 모달--

	$('#modal').click(function(){
		$('h1').removeClass('menu_x');
		$('h1').removeClass('search_x');
		$('#mobile_gnb').removeClass('on');
		$('.search').removeClass('on');
		$('#modal').removeClass('on');
	});

	// 모바일 lnb 효과
	$('#mobile_gnb>li').click(function(){
		$(this).siblings().children('ul').slideUp(250);
		$(this).children('ul').slideToggle(250);
	});

	// --모바일 lnb btn--

	$('.icon_menu').click(function(){
		if($('h1').hasClass('menu_x')){
			$('h1').removeClass('menu_x');
			$('h1').removeClass('search_x');
			$('#mobile_gnb').removeClass('on');
			$('.search').removeClass('on');
			$('#modal').removeClass('on');
		}else{
			$('h1').toggleClass('menu_x');
			$('h1').removeClass('search_x');
			$('#mobile_gnb').toggleClass('on');
			$('#modal').addClass('on');
			$('.search').removeClass('on');
		}
	});

	// --모바일 search btn--

	$('.icon_search').click(function(){
		if($('h1').hasClass('search_x')){
			$('h1').removeClass('menu_x');
			$('h1').removeClass('search_x');
			$('#mobile_gnb').removeClass('on');
			$('.search').removeClass('on');
			$('#modal').removeClass('on');
		}else{
			$('h1').toggleClass('search_x');
			$('h1').removeClass('menu_x');
			$('.search').toggleClass('on');
			$('#modal').addClass('on');
			$('#mobile_gnb').removeClass('on');

		}
	});
});

//alert 기능
function CheckEmpty( _frm, msg ) {
	if(_frm.value.trim() == "") {
		if( msg != "" ) alert( msg );
		_frm.focus();
		return true;
	}
	return false;
}

function CheckCount( _frm, msg, count ) {
	if(count == undefined) count = 1;

	var chk_count = 0;
	var first_frm;
	if(_frm.length == undefined) {
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
		if(msg != "") alert( msg );
		first_frm.focus();
		return true;
	}
	return false;
}
