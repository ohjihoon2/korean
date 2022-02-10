<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@page import="kr.urimal365.dao.ContentsDAO"%>
<%@page import="kr.urimal365.dto.Contents"%>
<%@page import="kr.urimal365.dao.NewsViewDAO"%>
<%@page import="kr.urimal365.dto.NewsView"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xml:lang="ko" lang="ko">
<body>
<div class="contentWrap">
	<div class="slider">
		<%
			String banner_preview_file = request.getParameter("banner_preview_file");
			if (banner_preview_file != null) {
				for(int i=0; i<5; i++) {
		%>
		<div class="">
			<div class="visual">
				<img src="<%=banner_preview_file %>" alt=""/>
				<p class="txt">
					<span class="t1">분류명</span>
					<a href="#" style="text-decoration:none"><strong class="t3">제목</strong></a>
				</p>
			</div>
		</div>
		<% } %>
		<%} else {
			List<NewsView> mainBannerList = NewsViewDAO.getDAO().mainBannerList();
			for (NewsView mainBanner : mainBannerList) {
		%>	
		<!--
		<div class="">
			<div class="visual">
				<img src="<%=mainBanner.getBannerFile() %>" alt=""/>
				<p class="txt">
					<span class="t1"><%=mainBanner.getCategoryName() %></span>
					<a href="index.jsp?control=page&part=view&idx=<%=mainBanner.getIdx()%>" style="text-decoration:none"><strong class="t3"><%=mainBanner.getTitle() %></strong></a>
				</p>
			</div>
		</div>
		-->
		<div class="">
			<div class="visual">
			<a href="index.jsp?control=page&part=view&idx=<%=mainBanner.getIdx()%>" style="text-decoration:none">
				<img src="<%=mainBanner.getBannerFile() %>" alt=""/>
				<span class="txt">
					<span class="t1"><%=mainBanner.getCategoryName() %></span>
					<strong class="t3"><%=mainBanner.getTitle() %></strong>
				</span>
				</a>
			</div>
		</div>
			<%}%>
		<%}%>
	</div>
	
	<div class="slider-nav">
		<%
			List<NewsCategory> categoryList = NewsCategoryDAO.getDAO().getHeadCategoryList();
			for (NewsCategory category : categoryList) {  
				String name = category.getName();
				name = UtilFunction.removeTag(name);
		%>
		<div class="">
			<a href="javascript:;" class="tab<%=category.getIdx()%>"><%=name %></a>
		</div>
		<%	} %>
	</div>

	<div class="contents">
		<div class="left">
			<div class="conArea">
				<%
					
						int size = 18;
						int num = 1;
						for (int i = 1; i < 5; i++) {
								num = 1;
								List<NewsView> recentNewsList1 = NewsViewDAO.getDAO().recentNewsList(i);
					%>
					<div class="">
						<ul class="">
					<%  
					
								for (NewsView news : recentNewsList1) {
									if (num == 1) { size = 28;} else { size = 17;}
					%>
								<li class="lis_<%=num%>">
								<a href="index.jsp?control=page&part=view&idx=<%=news.getIdx()%>">
								<img src="<%=news.getDefaultThumbnailFile() %>" alt=""/>
								<% if (num == 1) {  %><span class="tit"><%=news.getCategoryName() %></span><% } %>
								<span class="txt"><%=UtilFunction.titleCut(news.getTitle(),size) %></span>
								</a>
								</li>
					<% 				
								num++;}
					%>
						</ul>
					</div>
					<%
						}
					%>
			</div>
			<div class="conAreaBt">
				<a href="#" class="txtSlider_prev">이전</a>
				<a href="#" class="txtSlider_next">다음</a>
			</div>
		</div>
		<div class="right">
			<div class="txtSlide">
				<p class="tit">
					<strong>인기 있는 글</strong>
					<span>
						<a href="#" class="prev3"><img src="img/main/prev3.png" alt=""/></a>
						<a href="#" class="next3"><img src="img/main/next3.png" alt=""/></a>
					</span>
				</p>
				<div class="txtSlider">
				<%
					List<NewsView> bestNewsList = NewsViewDAO.getDAO().bestNewsList();
					int i = 0;
					for(NewsView bestNews : bestNewsList) {
						if (i % 3 == 0) { 
				%>
					<div class="">
					<ul class="">
					<%	}  %> 
					<li>
						<a href="index.jsp?control=page&part=view&idx=<%=bestNews.getIdx()%>">
							<img src="<%=bestNews.getDefaultThumbnailFile() %>" alt=""/>
							<strong><%=bestNews.getCategoryName() %></strong>
							<span><%=UtilFunction.titleCut(bestNews.getTitle(),18) %></span>
						</a>
					</li>
					<% if (i % 3 == 2) { %>
					</ul>
					</div>
					<% } %>									
				<%	 i++; 
					} %>
					
				</div>
			</div>
			<p class="eventBanner">
			<a href="/quiz.jsp">
			<% 
				String quizContents = ContentsDAO.getDAO().getBanner("3-1").getContents();
			%>
			<%= quizContents %>
			</a>
			</p>
		</div>
	</div>
</div>

<%
	Contents event = ContentsDAO.getDAO().getFooter("3-2");
	if (event != null) {
%>
	<div class="botCon">
		<div class="inner">
			<%=event.getContents()%>
<%	} else { %>
	<div class="botCon2">
		<div class="inner">
<%	} %>
			<div class="ask">
				<p class="left">
					<strong>소식지 신청하기</strong>
					<span>국어원 전자책 소식지 쉼표, 마침표를<br/>이메일로 받아보고 싶다면?</span>
					<a href="#newsletters_poppup" class="default_popup">신청하러 가기 &gt;</a>
				</p>
				<p class="right">
					<strong>소식지 다시보기</strong>
					<span>지난 소식지 글을 편리하게<br/>모아 보세요.</span>
					<a href="index.jsp?control=page&part=replay">지난 소식지 보러 가기 &gt;</a>
				</p>
			</div>
		</div>
	</div>

<script language="javascript" type="text/javascript">
//<![CDATA[
	$('.slider').slick({
		autoplay: true,
		autoplaySpeed: 6000,
		centerPadding: '0',
		centerMode: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		asNavFor: '.slider-nav, .conArea'
	});
	$('.slider-nav').slick({
		slidesToShow: 4,
		asNavFor: '.slider, .conArea',
		arrows: false,
		focusOnSelect: true
	});
	$('.conArea').slick({
		slidesToShow: 1,
		asNavFor: '.slider, .slider-nav',
		prevArrow: $('.txtSlider_prev'),
		nextArrow: $('.txtSlider_next')
	});
	$('.txtSlider').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		prevArrow: $('.prev3'),
		nextArrow: $('.next3')
	});
//]]>
</script>


</body>
</html>
