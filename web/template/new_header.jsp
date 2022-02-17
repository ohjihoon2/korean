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
	<title>쉼표,마침표.</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<script src="js/slick.js" language="javascript" type="text/javascript" charset="utf-8"></script>
	<script src="js/common.js?var=2" language="javascript" type="text/javascript" charset="utf-8"></script>
	<%
		List<CssDB> allCssList = CssDAO.getDAO().getCssList("8-1");
		for (CssDB css:allCssList) {
	%>
	<%=css.getContents() %>
	<% } %>
	<% if (request.getParameter("part").equals("main")) { %>
	<!-- <link href="http://urimal.fzst.kr/css/main.css" type="text/css" rel="stylesheet"  />-->
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
	<!-- 기존 페이지 css  -->
	<link rel="shortcut icon" href="/images/common/KR_icon.png" />
	<link rel="apple-touch-icon" href="/images/common/KR_icon.png" />
	<link rel="stylesheet" type="text/css" href="/css/wordpress.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
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
	<%
	Contents cont = ContentsDAO.getDAO().getBanner("3-5");
	if (cont != null) {

%>
	<%=cont.getContents()%>
	<% } %>
<div class="headerWrap">
	<div class="header">
		<div class="menuBt">
			<a href="#" class="nopc"><img src="img/common/kr_search_mo_off.png" alt="" onclick="searchToggle()" id="search_btn"></a>
			<a href="#" class="js-mgnb default_popup" href="#newsletters_poppup"><img src="img/common/mobMenuBt_off.png" alt="" onclick="gnbToggle()" id="GNB_m_btn"></a>
		</div>
		<div class="kr-month"><img src="_userfiles/2021_2/month.png" alt=""></div>
		<div class="kr-logo">
			<h1 class="logo">
				<a href="index.jsp">
					<span>국립국어원 온라인 소식지</span>
					<strong>쉼표, 마침표.</strong>
				</a>
			</h1>
		</div>
		<div class="search">
			<form method="get" action="index.jsp">
				<div class="itBox">
					<input type="hidden" name="control" value="page">
					<input type="hidden" name="part" value="serch">
					<input type="text" class="it" title="" value="" name="searchTxt" placeholder="검색어를 입력하세요" />
					<button class="searchBt">검색</button>
				</div>
			</form>
		</div>
	</div>

	<div class="mgnbwrap">
		<div class="mgnb nopc">
			<% List<NewsCategory> category = NewsCategoryDAO.getDAO().getHeadCategoryList();
				for(int i = 0; i < category.size(); i++) { %>
			<div class="mg<%=i%>">
				<p>
					<a href="index.jsp?control=page&amp;part=list&amp;category=<%=category.get(i).getIdx() %>">
						<%=category.get(i).getName() %>
					</a>
				</p>
				<ul>
					<%
						List<NewsCategory> categoryDetail = NewsCategoryDAO.getDAO().getDepthCategoryList(category.get(i).getIdx());
						for(int j = 0; j < categoryDetail.size(); j++) { %>
					<li><a href="<%=categoryDetail.get(j).getLink() %>" class="item1">
						<%=categoryDetail.get(j).getName() %>
					</a></li>
					<% } %>
				</ul>
			</div>
			<% } %>
			<!-- 한글날특별호 -->
			<div class="mg5">
				<p><a href="index.jsp?control=page&amp;part=list&amp;category=50">한글날 특별호</a></p>
				<ul>
					<li><a href="index.jsp?control=page&part=view&idx=13076" class="item11">축사</a></li>
					<li><a href="index.jsp?control=page&part=view&idx=13077" class="item12">세계 한국어 한마당 안내</a></li>
					<li><a href="index.jsp?control=page&part=view&idx=13075" class="item13">전 세계가 인정한 한글</a></li>
					<li><a href="index.jsp?control=page&part=view&idx=13080" class="item14">세계로 뻗어 가는 한국어</a></li>
					<li><a href="index.jsp?control=page&part=view&idx=13074" class="item15">폴란드의 한국어 열풍</a></li>
					<li><a href="index.jsp?control=page&part=view&idx=13073" class="item16">돌민정음으로 바라본 한류</a></li>
					<li><a href="index.jsp?control=page&part=view&idx=13079" class="item17">한글을 사랑한 헐버트</a></li>
					<li><a href="index.jsp?control=page&part=view&idx=13078" class="item18">한글날맞이 참여 행사</a></li>
				</ul>
			</div>
			<div class="btn-news">
				<ul>
					<li><a href="#newsletters_poppup" class="default_popup"><img src="img/common/btn_newsletter.jpg" alt="소식지 신청하기"></a></li>
					<li><a href="/index.jsp?control=page&part=replay"><img src="img/common/btn_replay.jpg" alt="소식지 다시보기"></a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<iframe src="/template/google.html" style="display:none;"></iframe>