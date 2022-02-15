<%@page import="kr.urimal365.dao.CssDAO"%>
<%@page import="kr.urimal365.dto.CssDB"%>
<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.ContentsDAO"%>
<%@page import="kr.urimal365.dto.Contents"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xml:lang="ko" lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>쉼표, 마침표</title>
		<link rel="shortcut icon" href="/images/common/KR_icon.png" />
		<link rel="apple-touch-icon" href="/images/common/KR_icon.png" />
		<%
			List<Contents> contList = ContentsDAO.getDAO().getBanner("3-2");
			for (int i =0; i < contList.size();i++) {
				if(i == 0){
					System.out.println("list 시작!!! ");
				}
				System.out.println("i = " + i);
				System.out.println(contList.get(i).toString());
			}


			List<CssDB> allCssList = CssDAO.getDAO().getCssList("8-1");
			for (CssDB css:allCssList) {
		%>
		<%=css.getContents() %>
		<% } %>
		<% if (request.getParameter("part").equals("main")) { %>
		<link rel="stylesheet" type="text/css" href="css/slick.css"/>
		<link rel="stylesheet" type="text/css" href="css/slick-theme.css"/>
		<%
			List<CssDB> mainCssList = CssDAO.getDAO().getCssList("8-2");
			for (CssDB css:mainCssList) {
		%>
		<%=css.getContents() %>
		<% } %>
		<% } else { %>
		<%
			List<CssDB> subCssList = CssDAO.getDAO().getCssList("8-3");
			for (CssDB css:subCssList) {
		%>
		<%=css.getContents() %>
		<% } %>
		<% } %>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
		<% if (request.getParameter("part").equals("main")) { %>
		<script type="text/javascript" src="js/main.js"></script>
		<script type="text/javascript" src="js/slick.min.js"></script>
		<% } else { %>
		<script type="text/javascript" src="js/sub.js"></script>
		<% } %>


		<!-- 국립국어원(news.korean.go.kr) 로그분석 소스-->
		<script>
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

		  ga('create', 'UA-96053420-1', 'auto');
		  ga('send', 'pageview');
		</script>
	</head>
<body>
<div id="modal"></div>
<div id="wrap">
	<!-- -------header------- -->
	<header>
		<div>
			<div>
				<!-- --logo-- -->
				<h1 class="clearfix">
					<div class="icon_menu"></div>
					<a>
						<img src="images/logo.png" alt="logo" class="mr20">
						<p>국립국어원 온라인 소식지</p>
						<p>쉼표, 마침표.</p>
					</a>
					<div class="icon_search"></div>
				</h1>
				<!-- --연도-- -->
				<p id="month" class="mt25"></p>
				<!-- --search-- -->
				<div class="search mt10">
					<input type="text" class="search_term" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="search_btn">
						<i class="fa fa-search"></i>
					</button>
				</div>
				<!-- --nav-- -->
				<nav class="mt20">
					<ul>
						<li>
							<a href="#">국어 <span class="bold">배우기</span></a>
						</li>
						<li>
							<a href="#">국어 <span class="bold">알리기</span></a>
						</li>
						<li>
							<a href="#">국어로 <span class="bold">바라보기</span></a>
						</li>
						<li>
							<a href="#">국어로 <span class="bold">함께하기</span></a>
						</li>
						<li>
							<a href="#">한글날 <span class="bold">특별호</span></a>
						</li>
					</ul>
				</nav>
				<ul id="mobile_gnb">
					<li>
						<p>국어 <span class="bold">배우기</span></p>
						<ul>
							<li><a href="#">뭉치가 알려주는 국어 말뭉치</a></li>
							<li><a href="#">문장 다듬기</a></li>
						</ul>
					</li>
					<li>
						<p>국어 <span class="bold">알리기</span></p>
						<ul>
							<li><a href="#">우리말 다듬기</a></li>
							<li><a href="#">살아 숨 쉬는 지역어</a></li>
							<li><a href="#">이음이가 전하는 국어 소식</a></li>
						</ul>
					</li>
					<li>
						<p>국어로 <span class="bold">바라보기</span></p>
						<ul>
							<li><a href="#">한국어 교육, 그리고 우리</a></li>
							<li><a href="#">우리말, 그리고 우리</a></li>
						</ul>
					</li>
					<li>
						<p>국어로 <span class="bold">함께하기</span></p>
						<ul>
							<li><a href="#">우리말 풀기</a></li>
							<li><a href="#">기획행사 소개</a></li>
						</ul>
					</li>
					<li>
						<p>한글날 <span class="bold">특별호</span></p>
						<ul>
							<li><a href="#">축사</a></li>
							<li><a href="#">세계 한국어 한마당 안내</a></li>
							<li><a href="#">전 세계가 인정한 한글</a></li>
							<li><a href="#">세계로 뻗어 가는 한국어</a></li>
							<li><a href="#">폴란드의 한국어 열풍</a></li>
							<li><a href="#">돌민정음으로 바라본 한류</a></li>
							<li><a href="#">한글을 사랑한 헐버트</a></li>
							<li><a href="#">한글날맞이 참여 행사</a></li>
						</ul>
					</li>
				</ul>
				<ul class="head_btn mt20">
					<li><a href="#">소식지 신청하기</a></li>
					<li><a href="#">이전 소식지 보기</a></li>
				</ul>
			</div>
		</div>
		<img src="images/bg_main2.png" alt="moon">
		<p class="scroll_down"><span>아래로 내려주세요.</span><img src="images/ico_scroll_w.png" alt="아래로 내리시오"></p>
	</header>