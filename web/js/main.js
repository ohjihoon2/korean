$(document).ready(function() {

	//--메인 슬라이드--
	$('.one-time').slick({
		dots: true,
		infinite: true,
		speed: 600,
		arrows : true,
		autoplay : true,
		autoplaySpeed : 5000,
		slidesToShow: 1,
		adaptiveHeight: true,
		pauseOnHover: true,
		pauseOnFocus: true
	});


	//--반응형 4개 슬라이드--

	$('.responsive').slick({
		dots: true,
		infinite: false,
		speed: 300,
		slidesToShow: 4,
		slidesToScroll: 4,
		responsive: [
			{
				breakpoint: 1440,
				settings: {
					slidesToShow: 3,
					slidesToScroll: 3,
					infinite: true,
					dots: true
				}
			},
			{
				breakpoint: 600,
				settings: {
					slidesToShow: 2,
					slidesToScroll: 2
				}
			},
			{
				breakpoint: 480,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1
				}
			}
		]
	});

});