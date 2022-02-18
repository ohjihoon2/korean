<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int category = 0;
	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ) {}
	
	Calendar currentCalendar = Calendar.getInstance();
	String yyyy = request.getParameter("yyyy");
	String mm = request.getParameter("mm");
	
	if (yyyy == null) {
		yyyy = "" + currentCalendar.get(Calendar.YEAR);
	}
	
	if (mm == null) {
		mm = "" + (currentCalendar.get(Calendar.MONTH) + 1); 
	}
%>
<form name="aform">
	<input type="hidden" name="control" value="page">
	<input type="hidden" name="part" value="replay">

	<!-- --타이틀-- -->
	<h2 class="pt70">
		이전 소식지 보기
	</h2>
	<div class="daySel">
		<select name="category" title="" style="width:156px;">
			<option value="0" selected="selected">::분류선택::</option>
			<%
				List<NewsCategory> newsCategoryList = NewsCategoryDAO.getDAO().newsCategoryLvl2();
				for (NewsCategory newsCategory : newsCategoryList) {
			%>
			<option value="<%=newsCategory.getIdx()%>" <%=category==newsCategory.getIdx()?"selected":"" %>><%=newsCategory.getName() %></option>
			<%	} %>
		</select>
		<span class="selN">/</span>
		<select name="yyyy" title="" style="width:64px;">
			<option value="_">:전체:</option>
			<%	for (int y=currentCalendar.get(Calendar.YEAR); y>=2013; y--) {	%>
				<option value="<%=y%>" <%=(""+y).equals(yyyy)?"selected":"" %>><%=y %></option>
			<%	} %>
		</select>
		<span>년</span>
		<select name="mm" title="" style="width:64px;">
			<option value="_">:전체:</option>
			<%	for (int m=1; m<=12; m++) {	%>
				<option value="<%=m%>" <%=(""+m).equals(mm)?"selected":"" %>><%=m %></option>
			<%	} %>
		</select>
		<span>월</span>
		<button>이동</button>
	</div>
	<!-- --리스트-- -->
	<div class="list_wrap">
		<ul id="post_list" class="list_con con_flex">

		</ul>
		<div id="btn_post_more" class="add_btn mt70"><p onclick="loadList();">+ 더보기</p></div>
	</div>
</form>
<script type="text/javascript">
var list_page=1;
var is_loadlist = false;
function loadList( ) {
	var cate = document.aform.category.value;
	var yyyy = document.aform.yyyy.value;
	var mm = document.aform.mm.value;
	
	if( is_loadlist ) return; 
	is_loadlist = true;

	var url = "ajax/post_list.jsp?category="+cate+"&page="+list_page+"&yyyy="+yyyy+"&mm="+mm;				

	$.get( url, function(data) {			 			
		$("#post_list").append(data);			 
		list_page++;
		is_loadlist = false;
	}).fail(function() {
	    is_loadlist = false;
	});
}

window.onload=function()
{
	loadList();
}
</script>
