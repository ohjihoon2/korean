<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int category = 0;
	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ) {}

	Calendar currentCalendar = Calendar.getInstance();

	String yyyy = (request.getParameter("yyyy") == null) ? "" : request.getParameter("yyyy") ;
	String mm = (request.getParameter("mm") == null) ? "" : request.getParameter("mm") ;

%>
	<!-- --타이틀-- -->
	<h2 class="pt70">이전 <span class="bold">소식지 보기</span></h2>
	<form name="aform">
		<input type="hidden" name="control" value="page">
		<input type="hidden" name="part" value="replay">
		<!-- --이전 소식지 보기 분류 -->
		<div class="prev_category mt60 mb10">
			<select name="category" id="list_theme">
				<option value="0">전체</option>
					<% List<NewsCategory> newsCategoryList = NewsCategoryDAO.getDAO().newsCategoryLvl2();
						for (NewsCategory newsCategory : newsCategoryList) {
					%>
					<option value="<%=newsCategory.getIdx()%>" <%=category==newsCategory.getIdx()?"selected":"" %>><%=newsCategory.getName() %></option>
					<%	} %>
			</select>
			<select name="yyyy" id="list_year">
				<option value="">연도</option>
				<%	for (int y=currentCalendar.get(Calendar.YEAR); y>=2013; y--) {	%>
					<option value="<%=y%>" <%=(""+y).equals(yyyy)?"selected":"" %>><%=y %></option>
				<%	} %>
			</select>
			<select name="mm" id="lisr_month">
				<option value="">월별</option>
				<%	for (int m=1; m<=12; m++) {	%>
					<option value="<%=m%>" <%=(""+m).equals(mm)?"selected":"" %>><%=m %></option>
				<%	} %>
			</select>
			<button>
				<i class="fas fa-search"></i>
			</button>
		</div>
	</form>


<!-- --리스트-- -->
<div class="list_wrap">
	<ul id="post_list" class="list_con con_flex">

	</ul>
	<div id="btn_post_more" class="add_btn mt70"><p onclick="loadList();">+ 더 보기 <span class="active_hover"></span></div>
</div>

<script type="text/javascript">
var list_page=1;
var is_loadlist = false;

function loadList() {

	if(is_loadlist) {
		return;
	}
	is_loadlist = true;

	var cate = document.aform.category.value;
	var yyyy = document.aform.yyyy.value;
	var mm = document.aform.mm.value;

	var url = "ajax/post_list.jsp?category="+cate+"&page="+list_page+"&isOpen=N&yyyy="+yyyy+"&mm="+mm;
	$.get( url, function(data) {
		$("#post_list").append(data);
		list_page++;
		is_loadlist = false;
	}).fail(function() {
		is_loadlist = false;
	});
}

window.onload=function() {
	loadList();
}
</script>
