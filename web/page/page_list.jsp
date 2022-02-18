<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
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

	/**
	 * 카테고리 그룹 예제
	 */
	List<Map<String, Object>> categoryGroup = NewsCategoryDAO.getDAO().getCategoryGroup(1);
	System.out.println("categoryGroup = " + categoryGroup);

	categoryTitle = UtilFunction.removeTag(categoryTitle);
%>
<form name="aform">
	<input type="hidden" name="category" value="<%=category%>">
</form>
<!-- --타이틀-- -->
<h2 class="pt70">
	<%= subject(categoryTitle) %>
</h2>

<!-- --탭메뉴 / a태그 각각의 페이지로 이동-- -->
<ul class="list_tab con_flex mt50 mb10">
	<li class="on"><a href="sub1_list0.html">전체</a></li>
	<li><a href="sub1_list1.html">아 다르고 어 다른 우리말</a></li>
	<li><a href="sub1_list2.html">뭉치가 알려주는 국어 말뭉치</a></li>
	<li><a href="sub1_list3.html">문장 다듬기</a></li>
</ul>

<!-- --리스트-- -->
<div class="list_wrap">
	<ul id="post_list" class="list_con con_flex">

	</ul>
	<div class="add_btn mt70"><p onclick="loadList();">+ 더보기</p></div>
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
