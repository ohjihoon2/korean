$(document).ready(function() {
	//날짜수정
	dateReset();

	$(window).resize(function (){
		var width_size = window.outerWidth;
		if (width_size <= 768) {
			$('.con4>ul').removeClass('con_flex')
		}else{
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


	// --모바일 lnb--

	$('.icon_menu').click(function(){
		$('h1').toggleClass('menu_x');
		$('h1').removeClass('search_x');
		$('#mobile_gnb').toggleClass('on');
		$('#modal').addClass('on');
		$('.search').removeClass('on');
	});

	$('#mobile_gnb>li').click(function(){
		$('#mobile_gnb>li>ul').slideUp(250);
		$(this).children('ul').slideToggle(250);
	});

	// --모바일 search--

	$('.icon_search').click(function(){
		$('h1').toggleClass('search_x');
		$('h1').removeClass('menu_x');
		$('.search').toggleClass('on');
		$('#modal').addClass('on');
		$('#mobile_gnb').removeClass('on');
	});
});

function dateReset() {
	var date = new Date();

	var year = date.getFullYear(); // 년도
	var month = date.getMonth() + 1;  // 월

	if(month < 10) {
		month = '0' + String(month);
	}

	var dateStr = year + "." + month;

	$('#month').text(dateStr);
}