<%@page import="kr.urimal365.dao.CssDAO"%>
<%@page import="kr.urimal365.dto.CssDB"%>
<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.ContentsDAO"%>
<%@page import="kr.urimal365.dto.Contents"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xml:lang="ko" lang="ko">
<head>
<title>쉼표,마침표.</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=no" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
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

<!-- 
<link rel="stylesheet" type="text/css" href="/css/desktop.css" />
<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/tablet.css" />
<link rel="stylesheet" type="text/css" href="/css/pablet.css" />
<link rel="stylesheet" type="text/css" href="/css/mobile.css" />
 -->
 
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
	<div class="util">
		<a href="https://www.facebook.com/urimal365k/" target="_blank"><img src="img/common/sns1.png" alt="페이스북"/></a>
		<a href="https://twitter.com/urimal365" target="_blank"><img src="img/common/sns2.png" alt="트위터"/></a>
		<a href="http://blog.naver.com/urimal365" target="_blank"><img src="img/common/sns4.png" alt="네이버블로그"/></a>
	</div>
	<div class="header">
		<h1 class="logo">
			<a href="index.jsp">
				<span>국립국어원 온라인 소식지</span>
				<strong>쉼표, 마침표.</strong>
			</a>
		</h1>

		<div class="search">
			<form method="get" action="index.jsp">
				<div class="itBox">
					<input type="hidden" name="control" value="page">
					<input type="hidden" name="part" value="serch">
					<input type="text" class="it " title="" value="" name="searchTxt"/>
				</div>
				<button class="searchBt">검색</button>
			</form>
		</div>
		
		<!-- pc 버전 1뎁스 메뉴 -->
		<ul class="gnb okpc">
		<%
			List<NewsCategory> headCategoryList = NewsCategoryDAO.getDAO().getHeadCategoryList();
			for (NewsCategory headCategory : headCategoryList) {
				String name = headCategory.getName();
				name = UtilFunction.removeTag(name);
		%>
			
			<li><a href="index.jsp?control=page&part=list&category=<%=headCategory.getIdx() %>" name="g<%=headCategory.getIdx()%>"><%=name %></a></li>
		<% } %>
		</ul>
	</div>

	<!-- pc 버전 2뎁스 메뉴 -->
	<div class="gnbSub okpc">
		<div class="inner">
			<ul class="g1">
				<li class="imgnb"><a href="index.jsp?control=page&amp;part=list&amp;category=38"><img src="img/common/gnbSubMenu1.png" alt="하나 된 열정, 평창!"/></a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=5">안녕! 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=6">전국 방언 말모이</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=39">바른 말 탐구 생활</a></li>
			</ul>
			<ul class="g2">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=35">우리말 친구들</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=9">국외통신원 편지</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=10">국어 교실에서</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=21">한글의 맵시</a></li>
			</ul>
			<ul class="g3">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=13">지혜가 반짝이는 속담</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=14">아름다운 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=22">다채로운 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=37">또 하나의 언어</a></li>
			</ul>
			<ul class="g4">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=36">만화로 보는 우리말</a></li>
				<li><a href="/quiz.jsp">우리말 달인</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=17">단어장</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=18">소리가 예쁜 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=19">우리말 길라잡이</a></li>
			</ul>
			<!--<p class="event">
				<a href="/quiz.jsp"><span>우리말 달인</span> <strong>퀴즈</strong></a>
			</p>-->
		</div>
		<div class="inner2">
			<ul class="g1">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=7">통계로 보는 우리말</a></li>
			</ul>
			<ul class="g2">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=8">한글 위인 열전</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=11">뭐라고 부를까?</a></li>
			</ul>
			<ul class="g3">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=23">길 이름, 알고 보니</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=12">지명, 알고 보니</a></li>
			</ul>
			<ul class="g4">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=15">한글 맞춤법</a></li>
			</ul>
		</div>
	</div>

	<!-- mob,tab 버전 메뉴 -->
	<p class="menuBt nopc"><a href="#"><img src="img/common/mobMenuBt.png" alt=""/></a></p>
	<div class="mgnb nopc">
		<div class="mg1">
			<p>궁금한<br> 우리말</p>
			<ul class="">
				<li class="imgnb"><a href="index.jsp?control=page&amp;part=list&amp;category=38"><img src="img/common/gnbSubMenu1.png" alt="하나 된 열정, 평창!"/></a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=5">안녕! 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=6">전국 방언 말모이</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=39">바른 말 탐구 생활</a></li>
				<li class="grey"><a href="index.jsp?control=page&amp;part=list&amp;category=7">통계로 보는 우리말</a></li>
			</ul>
		</div>
		<div class="mg2">
			<p>놀라운<br> 우리말</p>
			<ul class="">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=35">우리말 친구들</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=9">국외통신원 편지</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=10">국어 교실에서</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=21">한글의 맵시</a></li>
				<li class="grey"><a href="index.jsp?control=page&amp;part=list&amp;category=8">한글 위인 열전</a></li>
				<li class="grey"><a href="index.jsp?control=page&amp;part=list&amp;category=11">뭐라고 부를까?</a></li>
			</ul>
		</div>
		<div class="mg3">
			<p>쉬어 가는<br> 우리말</p>
			<ul class="">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=13">지혜가 반짝이는 속담</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=14">아름다운 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=22">다채로운 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=37">또 하나의 언어</a></li>
				<li class="grey"><a href="index.jsp?control=page&amp;part=list&amp;category=23">길 이름, 알고 보니</a></li>
				<li class="grey"><a href="index.jsp?control=page&amp;part=list&amp;category=12">지명, 알고 보니</a></li>
			</ul>
		</div>
		<div class="mg4">
			<p>갈무리할<br> 우리말</p>
			<ul class="">
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=36">만화로 보는 우리말</a></li>
				<li><a href="/quiz.jsp">우리말 달인</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=17">단어장</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=18">소리가 예쁜 우리말</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=19">우리말 길라잡이</a></li>
				<li class="grey"><a href="index.jsp?control=page&amp;part=list&amp;category=15">한글 맞춤법</a></li>
			</ul>
		</div>
		<!--<p class="event">
			<a href="/quiz.jsp"><span>우리말 달인</span> <strong>퀴즈</strong></a>
		</p>-->
		<a href="#" class="mgnbClose"><img src="img/common/mgnbClose.png" alt=""></a>
	</div>
</div>
<iframe src="/template/google.html" style="display:none;"></iframe>
</body>
</html>