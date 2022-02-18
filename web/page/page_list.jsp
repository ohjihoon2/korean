<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

<%
	int category = 1;
	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ){ }
	
	String categoryTitle = NewsCategoryDAO.getDAO().getCategoryTitle(category).getName();

	categoryTitle = UtilFunction.removeTag(categoryTitle);
%>
<form name="aform">
	<input type="hidden" name="category" value="<%=category%>">
</form>
<!-- --타이틀-- -->
<h2 class="pt70">
	<%= subject(categoryTitle) %>
</h2>

<% List<Map<String, Object>> categoryGroup = NewsCategoryDAO.getDAO().getCategoryGroup(category); %>

<!-- --탭메뉴 / a태그 각각의 페이지로 이동-- -->
<% if(categoryGroup.size() > 2) { %>
<ul class="list_tab con_flex mt50 mb10">
	<% for(int i= 0; i < categoryGroup.size(); i++) { %>
	<li class="<% if(categoryGroup.get(i).get("idx").equals(category)) { %> on <% } %>"><a href="/index.jsp?control=page&part=list&category=<%= categoryGroup.get(i).get("idx") %>"><%= categoryGroup.get(i).get("name") %></a></li>
	<% } %>
</ul>
<% } %>

<!-- --리스트-- -->
<div class="list_wrap">
	<ul id="post_list" class="list_con con_flex">

	</ul>
	<div id="btn_post_more" class="add_btn mt70"><p onclick="loadList();">+ 더보기</p></div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
var list_page=1;
var is_loadlist = false;
function loadList() {
	var cate = document.aform.category.value;
	if(is_loadlist) {
		return;
	}
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

window.onload=function() {
	loadList();
}
</script>
