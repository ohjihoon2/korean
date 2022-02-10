<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>쉼표,마침표. 오류페이지</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="format-detection" content="telephone=no">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!--[if lt IE 9]>
			<script src="/asset/js/html5shiv.min.js"></script>
			<link rel="stylesheet" href="/asset/css/font/notosanskr-eot.min.css">
		<![endif]-->
		<link rel="shortcut icon" href="/images/common/KR_icon.png" />
		<link rel="apple-touch-icon" href="/images/common/KR_icon.png" />
	</head>

<style type="text/css">

/* basic set */

a{text-decoration:none}

.heading-depth01 .title {
	width: 100%;
	color: #222;
	font-size: 36px;
	font-weight: 600;
}

.heading-depth01 .desc {
	margin-top: 10px;
	color: #666;
	font-size: 18px;
	font-weight: 600;
}

.etc .logo {display: block;
	width: 120px;
    height: 48px;
	background: url(../img/common/logoBg.png) 0 28px no-repeat;
	background-size: 69px 67px;
	padding: 52px 0 0 73px;
}

.etc .logo span {
	font-family: "NanumSquareR";
    font-size: 10px;
    color: #666;
    display: block;
    padding: 0 0 5px;
}

.etc .logo strong {
	font-family: "NanumSquareR";
    font-size: 19px;
    color: #121212;
    display: block;
}

.etc .logo a{
    /*position:absolute;*/
    overflow:hidden;
    border:0;
    width:1px;
    height:1px;
    clip: rect(1px, 1px, 1px, 1px);
    clip-path:inset(50%);
}

/* Button */
.button {
	display: inline-block;
	vertical-align: middle;
	height: 40px;
	padding: 0 30px;
	border: 1px solid #ccc;
	border-radius: 2px;
	color: #666;
	font-size: 14px;
	font-weight: 400;
	text-align: center;
	line-height: 38px;
	background-color: #fff;
	cursor: pointer;
}

/* Button color */

[class*=button-color] {
	border-color: transparent;
	color: #fff;
	font-weight:600
}

.button-color01 {
	background-color: #003964;
}

/* Button Type */
.button-type01 {
	height: 50px;
	border-radius: 4px;
	font-size: 16px;
	line-height: 48px;
}

.heading-depth01 + .btnWrap {
	margin-top: -20px;
	text-align:center;
	margin-top:50px
}


/* etc */
.etc {
	width: 1200px;
	margin: 0 auto;
}
.etc .logo {
	/*margin: 65px 0 20px;*/
}

.etc .box.box-type02 {
	padding: 320px 20px 160px;
}
.etc .ico-error {
	background:url(/images/common/ico_error.png) center 160px no-repeat
}
.etc .heading {
	text-align: center;
}
.etc .time {
	width: 490px;
	margin: 0 auto;
	padding: 30px;
	color: #fff;
	text-align: center;
	background-color: #003964;
}
.etc .time strong {
	display: block;
	margin-bottom: 20px;
	font-size: 20px;
	font-weight: 400;
}
.etc .time span {
	font-size: 14px;
}




/* box type02 */
.box.box-type02 {
	padding: 30px;
	border: 0;
	text-align: left;
	background-color: #f2f5f8;
}


/* Skip To Content */
.skipToContent {
	position: absolute;
	top: -120px;
	right: 0;
	left: 0;
	z-index: 1000;
	min-width: 320px;
	height: 120px;
	color: #666;
	font-size: 1.875em;
	text-align: center;
	letter-spacing: -1.5px;
	line-height: 120px;
	background-color: #003964;
	background-color: rgba(0, 57, 100, .8);
	transition: .1s ease-in-out;
}

._S .skipToContent {
	top: -51px;
	height: 51px;
	font-size: 1.5em;
	line-height: 51px;
}
.skipToContent:focus,
.skipToContent:hover {
	top: 0;
	color: #fff;
	text-decoration: none;
}


/* responsive media css */


@media (min-width: 768px) and (max-width: 1024px) {

.etc{width:100%}
.etc .logo{margin:0;padding-bottom:10px}
.etc .ico-error {background-size: 30%}
.etc .box.box-type02{padding:400px 20px 160px}
.heading-depth01 .title {width: 100%;color: #222;font-size: 25px;font-weight: 600;padding-top:20px}
.heading-depth01 .desc {font-size: 14px}
.button-type01 {font-size: 13px}

}


@media (min-width: 481px) and (max-width: 767px) {

.etc{width:100%}
.etc .logo{margin:0;padding-bottom:10px}
.etc .ico-error {background-size: 30%}
.etc .box.box-type02{padding:255px 20px 160px}
.heading-depth01 .title {width: 100%;color: #222;font-size: 25px;font-weight: 600;padding-top:20px}
.heading-depth01 .desc {font-size: 14px}
.button-type01 {font-size: 13px}

}


@media (min-width: 320px) and (max-width: 480px) {

.etc{width:100%}
.etc .logo{margin:0;padding-bottom:10px}
.etc .ico-error {background-size: 30%}
.etc .box.box-type02{padding:220px 20px 160px}
.heading-depth01 .title {width: 100%;color: #222;font-size: 25px;font-weight: 600;padding-top:20px}
.heading-depth01 .desc {font-size: 14px}
.button-type01 {font-size: 13px}

}

</style>


<body>

<div id="wrap" class="wrap">
			<!-- skipToContent -->
			<a href="#content" class="skipToContent">본문으로 바로가기</a>
			<!-- //skipToContent -->
				<!-- content -->
				<div class="etc" id="content">
					<div class="kr-logo">
						<h1 class="logo">
							<a href="/index.jsp">
								<span>국립국어원 온라인 소식지</span>
								<strong>쉼표, 마침표.</strong>
							</a>
						</h1>
					</div>
					<div class="box box-type02 ico-error">
						<div class="heading heading-depth01">
							<h2 class="title">오류가 발생했습니다.
							</h2>
							<p class="desc">서비스 이용에 불편을 드려 죄송합니다. 오류가 발생하여 해당 페이지를 열람할 수 없습니다.<br>자세한 사항은 홈페이지 관리자에게 문의 바랍니다.</p>
						</div>
						<div class="btnWrap">
							<a href="/index.jsp" class="button button-type01 button-color01 button-sizeFull">메인으로 돌아가기</a>
						</div>
					</div>
				</div>
				<!-- content -->
		<div class="dimmedLayer"></div></div>
        
        
</body>
</html>
