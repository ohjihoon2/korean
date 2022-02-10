<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xml:lang="ko" lang="ko">
<%
	int category = 1;
	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ){ }
	
	String categoryTitle = NewsCategoryDAO.getDAO().getCategoryTitle(category).getName();
	categoryTitle = UtilFunction.removeTag(categoryTitle);
%>
<body>

<div class="contentWrap contentWrapBg kr-listpage">
	<form name="aform">
		<input type="hidden" name="category" value="<%=category%>">
	</form>
	<div class="listStyle">
		<p class="title">
			<strong>'<%=categoryTitle %>'</strong> 글 모음입니다.
		</p>
		<ul class="" id="post_list">
			
			
		</ul>

		<a href="javascript:loadList();" id="btn_post_more" class="lazyLoadBt"><span>더보기</span></a>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
var list_page=1;
var is_loadlist = false;
function loadList( ) {
	var cate = document.aform.category.value;
	if( is_loadlist ) return; 
	is_loadlist = true;

	var url = "ajax/post_list.jsp?category="+cate+"&page="+list_page;
	
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
</body>
</html>
