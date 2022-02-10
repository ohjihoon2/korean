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
	<title>��ǥ,��ħǥ.</title>
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
	<!-- ���� ������ css  -->
	<link rel="shortcut icon" href="/images/common/KR_icon.png" />
	<link rel="apple-touch-icon" href="/images/common/KR_icon.png" />
	<link rel="stylesheet" type="text/css" href="/css/wordpress.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
	<!-- ���������(news.korean.go.kr) �α׺м� �ҽ�-->
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
		<div class="kr-logo">
			<h1 class="logo">
				<a href="index.jsp">
					<span>��������� �¶��� �ҽ���</span>
					<strong>��ǥ, ��ħǥ.</strong>
				</a>
			</h1>
			<div class="kr-month"><img src="_userfiles/2020_2/month.png" alt=""></div>
		</div>
		<!-- pc ���� 1���� �޴� -->
		<ul class="gnb okpc">
			<li class="kr-gnb-line1"><a href="index.jsp?control=page&part=list&category=1" name="g1">���� ����</a></li>
			<li class="kr-gnb-line2"><a href="index.jsp?control=page&part=list&category=2" name="g2">���� �˸���</a></li>
			<li class="kr-gnb-line3"><a href="index.jsp?control=page&part=list&category=3" name="g3">����� �ٶ󺸱�</a></li>
			<li class="kr-gnb-line4"><a href="index.jsp?control=page&part=list&category=4" name="g4">����� �Բ��ϱ�</a></li>
		</ul>
		<!-- pc ���� 2���� �޴� -->
		<div class="gnbSub okpc" style="display: none;">
			<div class="inner">
				<ul class="g1">
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=53" class="item1">���� �д� ���� ���</a></li>
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=54" class="item2">ǥ�ؾ� �ٱ��� ����</a></li>
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=52" class="item3">���� ����</a></li>
				</ul>
				<ul class="g2">
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=56" class="item4">����� �ҽ�</a></li>
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=55" class="item5">������å ���</a></li>
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=57" class="item6">�츮�� �ٵ��</a></li>
				</ul>
				<ul class="g3">
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=58" class="item7">����ġ�� �ٶ󺸱�</a></li>
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=60" class="item8">�츮��, �׸��� ���</a></li>
				</ul>
				<ul class="g4">
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=61" class="item9">��ȹ ���</a></li>
					<li><a href="index.jsp?control=page&amp;part=list&amp;category=59" class="item10">�츮�� Ǯ��</a></li>
				</ul>
			</div>
		</div>
		<div class="search">
			<form method="get" action="index.jsp">
				<div class="itBox">
					<input type="hidden" name="control" value="page">
					<input type="hidden" name="part" value="serch">
					<input type="text" class="it " title="" value="" name="searchTxt" />
					<button class="searchBt">�˻�</button>
				</div>
			</form>
		</div>
	</div>

	<!-- mob,tab ���� �޴� -->
	<p class="menuBt nopc">
		<a href="#"><img src="img/common/kr_search_mo_off.png" alt="" onclick="searchToggle()" id="search_btn"></a>
		<a href="#" class="js-mgnb default_popup" href="#newsletters_poppup"><img src="img/common/mobMenuBt_off.png" alt="" onclick="gnbToggle()" id="GNB_m_btn"></a>
	</p>

	<div class="mgnb nopc">
		<div class="mg1">
			<p>���� ����</p>
			<ul>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=53" class="item1">���� �д� ���� ���</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=54" class="item2">ǥ�ؾ� �ٱ��� ����</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=52" class="item3">���� ����</a></li>
			</ul>
		</div>
		<div class="mg2">
			<p>���� �˸���</p>
			<ul>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=56" class="item4">����� �ҽ�</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=55" class="item5">������å ���</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=57" class="item6">�츮�� �ٵ��</a></li>
			</ul>
		</div>
		<div class="mg3">
			<p>����� �ٶ󺸱�</p>
			<ul>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=58" class="item7">����ġ�� �ٶ󺸱�</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=60" class="item8">�츮��, �׸��� ���</a></li>
			</ul>
		</div>
		<div class="mg4">
			<p>����� �Բ��ϱ�</p>
			<ul>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=61" class="item9">��ȹ ���</a></li>
				<li><a href="index.jsp?control=page&amp;part=list&amp;category=59" class="item10">�츮�� Ǯ��</a></li>
			</ul>
		</div>
	</div>
	
</div>
<iframe src="/template/google.html" style="display:none;"></iframe>