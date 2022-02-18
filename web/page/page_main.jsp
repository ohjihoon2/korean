
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.urimal365.dao.ContentsDAO"%>
<%@ page import="kr.urimal365.dto.Contents" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%! public String subject(String str) {
	String res[] = str.split(" ");
	String result = "";
	for(int i = 0; i < res.length; i++) {
		if(i == 1) {
			result = result + "<span class=\"bold\">" + res[i] + "</span>";
		}
		else {
			result = result + res[i];
		}
		if(i != (res.length - 1)) {
			result = result + " ";
		}
	}
	return result;
} %>
	<!-- --슬라이드-- -->
	<div class="slide clearfix">
		<% List<Contents> getBanner = ContentsDAO.getDAO().getBanner("3-2"); %>
		<% if(getBanner.size() != 0) { %>
		<div class="one-time pt50">
			<% for(int i= 0; i < getBanner.size(); i++) { %>
				<%= getBanner.get(i).getContents() %>
			<% } %>
		</div>
		<% } %>
	</div>
	<!-- --새로운 글 모음-- -->

	<div class="con1 mt100 clearfix">
		<h2>새로운 <span class="bold">글 모음</span></h2>
		<div class="responsive mt40">
			<% List<Map<String, Object>> categoryNewList = ContentsDAO.getDAO().getCategoryNewList(); %>
			<% for(int i= 0; i < categoryNewList.size(); i++) { %>
				<div>
					<a href="/index.jsp?control=page&part=view&idx=<%= categoryNewList.get(i).get("idx") %>"><img src="<%= categoryNewList.get(i).get("thumbnail_file") %>" alt="책 그림">
						<ul>
							<li class="tit_color"><%= categoryNewList.get(i).get("category") %></li>
							<li class="tit_bold"><%= categoryNewList.get(i).get("title") %></li>
						</ul>
					</a>
				</div>
			<% } %>
		</div>
	</div>

	<% Map<String, Object> categoryInfo1 = ContentsDAO.getDAO().getCategoryInfo(1); %>
	<!-- --국어 배우기-- -->
	<% if(categoryInfo1.get("is_open").equals("Y")) { %>
	<div class="con2 mt150 clearfix">
		<h2>
			<%= subject((String) categoryInfo1.get("name")) %>
		</h2>
		<% List<Map<String, Object>> contentList1 = ContentsDAO.getDAO().getContentList(1, 4); %>
		<ul class="mt40 con_flex">
			<% for(int i= 0; i < contentList1.size(); i++) { %>
			<li>
				<a href="/index.jsp?control=page&part=view&idx=<%= contentList1.get(i).get("idx") %>">
					<img src="<%= contentList1.get(i).get("banner_file") %>" alt="">
					<ul>
						<li class="tit_date"><%= contentList1.get(i).get("write_date") %></li>
						<li class="tit_color"><%= contentList1.get(i).get("category") %></li>
						<li class="tit_bold"><%= contentList1.get(i).get("title") %></li>
						<li class="tit_sub"><%= contentList1.get(i).get("subtitle") %></li>
					</ul>
				</a>
			</li>
			<% } %>
		</ul>
		<div class="add_btn mt100"><a href="/index.jsp?control=page&part=list&category=1">+ 더 보기</a></div>
	</div>
	<% } %>

	<!-- --국어 알리기-- -->

	<% Map<String, Object> categoryInfo2 = ContentsDAO.getDAO().getCategoryInfo(2); %>
	<% if(categoryInfo2.get("is_open").equals("Y")) { %>
	<div class="con3 mt150 clearfix">
		<h2>
			<%= subject((String) categoryInfo2.get("name")) %>
		</h2>
		<div class="con3_bg"></div>
		<% List<Map<String, Object>> contentList2 = ContentsDAO.getDAO().getContentList(2, 6); %>
		<ul class="con_flex mt40">
			<% for(int i= 0; i < contentList2.size(); i++) { %>
			<li>
				<a href="/index.jsp?control=page&part=view&idx=<%= contentList2.get(i).get("idx") %>">
					<img src="<%= contentList2.get(i).get("banner_file") %>" alt="">
					<ul>
						<li class="tit_color"><%= contentList2.get(i).get("category") %></li>
						<li class="tit_bold" style="font-size: 0.9375em;"><%= contentList2.get(i).get("title") %></li>
						<li class="tit_date"><%= contentList2.get(i).get("write_date") %></li>
						<li class="ico_add"><img src="images/ico_add.png" alt="더 보기 버튼"></li>
					</ul>
				</a>
			</li>
			<% } %>
		</ul>
		<div class="add_btn"><a href="/index.jsp?control=page&part=list&category=2">+ 더 보기</a></div>
	</div>

	<% } %>

	<!-- --국어로 바라보기-- -->
	<% Map<String, Object> categoryInfo3 = ContentsDAO.getDAO().getCategoryInfo(3); %>
	<% if(categoryInfo3.get("is_open").equals("Y")) { %>
	<div class="con4 mt150 clearfix">
		<h2>
			<%= subject((String) categoryInfo3.get("name")) %>
		</h2>
		<% List<Map<String, Object>> contentList3 = ContentsDAO.getDAO().getContentList(3, 2); %>
		<ul class="con_flex mt40">
			<% for(int i= 0; i < contentList3.size(); i++) { %>
			<li>
				<a href="#">
					<img src="images/2022_2/sub31_2list.jpg" alt="장소원 원장님 사진">
					<ul>
						<li class="tit_color">우리말, 그리고 사람</li>
						<li class="tit_bold">국민의 국어능력을<br> 높이겠습니다.</li>
						<li class="line_short"></li>
						<li>국립 국어원 장소원 원장</li>
						<li class="tit_date mt20">2021. 12. 20.</li>
					</ul>
					</img>
				</a>
			</li>
			<% } %>
		</ul>
		<div class="add_btn"><a href="/index.jsp?control=page&part=list&category=3">+ 더 보기</a></div>
	</div>
	<% } %>

	<jsp:include page="../template/bitsol_category.jsp"></jsp:include>

	<!-- --이벤트 배너-- -->

	<% Contents getSelectOneBanner = (Contents) ContentsDAO.getDAO().getSelectOneBanner("3-3"); %>
	<div class="brn_event mt100 clearfix">
		<ul>
			<li><a href="#"><img src="images/bnr_img1.png" alt="우리말 풀기 그림"></a></li>
			<li><a href="#"><img src="images/bnr_img2.png" alt="575돌 한글날 이벤트 당첨자 발표 그림"></a></li>
		</ul>
	</div>
