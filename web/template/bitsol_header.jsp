<%@page import="kr.urimal365.dao.CssDAO"%>
<%@page import="kr.urimal365.dto.CssDB"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="kr.urimal365.dto.Contents" %>
<%@ page import="kr.urimal365.dao.ContentsDAO" %>
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
		<script type="text/javascript" src="js/popup.js"></script>
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
					<a href="/">
						<img src="images/logo_w.png" alt="logo">
						<img src="images/logo_b.png" alt="logo">
					</a>
					<div class="icon_search"></div>
				</h1>

				<% Date nowDate = new Date();
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM");
				//원하는 데이터 포맷 지정 String
				String strNowDate = simpleDateFormat.format(nowDate);
				%>

				<!-- --연도-- -->
				<p id="month" class="mt25"><%= strNowDate %></p>
				<!-- --search-- -->
				<form method="get" action="index.jsp">
					<div class="search mt10">
						<input type="hidden" name="control" value="page">
						<input type="hidden" name="part" value="serch">
						<input type="text" class="search_term" title="" value="" name="searchTxt" placeholder="검색어를 입력하세요" />
						<button type="submit" class="search_btn">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>
				<% List<NewsCategory> category = NewsCategoryDAO.getDAO().getHeadCategoryList(); %>
				<!-- --nav-- -->
				<nav class="mt20">
					<ul>
				<% for(int i = 0; i < category.size(); i++) { %>
						<li>
							<a href="<%=category.get(i).getLink() %>">
					<% String str = category.get(i).getName();
			   	       String res[] = str.split(" ");
				    for(int j = 0; j < res.length; j++) {
						if(j == 1) { %>
								<span class="bold"><%=res[j] %></span>
						<% }
						else { %>
							<%= res[j] %>
						<% } %>
					<% } %>
							</a>
						</li>
				<% } %>
					</ul>
				</nav>
				<ul id="mobile_gnb">
					<% for(int i = 0; i < category.size(); i++) { %>
					<li>
						<p>
							<% String str = category.get(i).getName();
								String res[] = str.split(" ");
								for(int j = 0; j < res.length; j++) {
									if(j == 1) { %>
							<span class="bold"><%=res[j] %></span>
							<% }
							else { %>
							<%= res[j] %>
							<% } %>
							<% } %>
						</p>
						<ul>
							<% List<NewsCategory> categoryDetail = NewsCategoryDAO.getDAO().getDepthCategoryList(category.get(i).getIdx());
							for(int j = 0; j < categoryDetail.size(); j++) { %>
								<li><a href="<%=categoryDetail.get(j).getLink() %>" class="item1">
									<%=categoryDetail.get(j).getName() %>
								</a></li>
							<% } %>
						</ul>
					</li>
					<% } %>
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
					<li><a id="popupOpen">소식지 신청하기</a></li>
					<li><a href="#">이전 소식지 보기</a></li>
				</ul>
			</div>
		</div>
		<img src="images/bg_main2.png" alt="moon">
		<p class="scroll_down"><span>아래로 내려주세요.</span><img src="images/ico_scroll_w.png" alt="아래로 내리시오"></p>
	</header>

	<!-- 소식지팝업 -->
	<div id="popupBack" class="popup_back" style="display: none;"></div>
	<div id="newslettersPoppup" class="newsletters_poppup" style="display: none;">
		<div>
			<ul class="popup_tabmenu">
				<li id="popup1" class="current"><a>수신 신청</a></li>
				<li id="popup2"><a>수신 거부</a></li>
			</ul>
			<div class="popup_tabcont_wrap">
				<!-- 수신 신청 -->
				<div id="newsletter_tab01" class="popup_tab_content">
					<form name="reception5_1" method="POST">
						<input type="hidden" name="gbn" value="5-1" />
						<input type="hidden" name="receipt_gbn" value="Y" />
						<div class="popup_section">
							<div class="popup_tit"><span class="bold">쉼표, 마침표.</span> 수신 신청</div>
							<div class="popup_form_layout">
								<div class="half">
									<label for="">이름</label>
									<input type="text" name="name" placeholder="이름을 입력해 주세요" />
								</div>
								<div class="half">
									<label for="">전자우편</label>
									<input type="text" name="email" placeholder="전자 우편 주소를 입력해 주세요" />
								</div>
							</div>
							<p><label for="">국립국어원 온라인 소식지 ≪쉼표, 마침표.≫ 수신을 신청합니다.</label>  <input type="checkbox" name="check1" value="Y" /></p>
							<p><label for="">온라인 소식지 외에 국어(원) 관련 소식 수신을 신청합니다.</label>  <input type="checkbox" name="check2" value="Y" /></p>
							<div class="popup_btns">
								<a href="javascript:submitReception5_1();" class="black"><i class="fa fa-check" aria-hidden="true"></i> <span>신청</span></a>
								<a href="javascript:hideReception();" class="white">취소</a>
							</div>
						</div>
					</form>
				</div>
				<!-- 수신 거부 -->
				<div id="newsletter_tab02" class="popup_tab_content" style="display:none;">
					<form name="reception5_2" method="POST">
						<input type="hidden" name="gbn" value="5-2" />
						<input type="hidden" name="receipt_gbn" value="N" />
						<div class="popup_section">
							<div class="popup_tit"><span class="bold">쉼표, 마침표.</span> 수신 거부 신청</div>
							<div class="popup_form_layout">
								<div class="half">
									<label for="">이름</label>
									<input type="text" name="name" placeholder="이름을 입력해 주세요" />
								</div>
								<div class="half">
									<label for="">전자우편</label>
									<input type="text" name="email" placeholder="전자 우편 주소를 입력해 주세요" />
								</div>
							</div>
							<p><label for="">국립국어원 온라인 소식지 ≪쉼표, 마침표.≫ 수신을 거부합니다.</label> <input type="checkbox" name="check1" value="Y" /></p>
							<p><label for="">온라인 소식지 외에 국어(원) 관련 소식 수신을 거부합니다.</label> <input type="checkbox" name="check2" value="Y" /></p>
							<div class="popup_btns">
								<a href="javascript:submitReception5_2();" class="black"><i class="fa fa-check" aria-hidden="true"></i> <span>확인</span></a>
								<a href="javascript:hideReception();" class="white">취소</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>