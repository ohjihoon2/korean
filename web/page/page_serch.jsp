<%@page import="kr.urimal365.util.UtilFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int category = 0;
	request.setCharacterEncoding("UTF-8");
	String searchTxt = UtilFunction.xssFilter(request.getParameter("searchTxt"));

	if(searchTxt != null) {
		searchTxt = searchTxt.replaceAll("&", "&amp;");
		searchTxt = searchTxt.replaceAll("#", "&#35;");
		searchTxt = searchTxt.replaceAll(";", "&#59;");
		searchTxt = searchTxt.replaceAll("\\\\", "&#92;");
		searchTxt = searchTxt.replaceAll("<"  , "&lt;");
		searchTxt = searchTxt.replaceAll(">"  , "&gt;");
		searchTxt = searchTxt.replaceAll("\\(", "&#40;");
		searchTxt = searchTxt.replaceAll("\\)", "&#41;");
		searchTxt = searchTxt.replaceAll("'"  , "&#39;");
		searchTxt = searchTxt.replaceAll("\"", "&quot;");
		searchTxt = searchTxt.replaceAll("[$]", "&#36;");
		searchTxt = searchTxt.replaceAll("[*]", "&#42;");
		searchTxt = searchTxt.replaceAll("[+]", "&#43;");
		searchTxt = searchTxt.replaceAll("[|]", "&#124;");
		searchTxt = searchTxt.replaceAll("\\." , "&#46;");
		searchTxt = searchTxt.replaceAll("\\?" , "&#63;");
		searchTxt = searchTxt.replaceAll("\\[" , "&#91;");
		searchTxt = searchTxt.replaceAll("\\]" , "&#93;");
		searchTxt = searchTxt.replaceAll("\\^" , "&#94;");
		searchTxt = searchTxt.replaceAll("\\{" , "&#123;");
		searchTxt = searchTxt.replaceAll("\\}" , "&#125;");
		searchTxt = searchTxt.replaceAll("!", "&#33;");
		searchTxt = searchTxt.replaceAll("%", "&#37;");
		searchTxt = searchTxt.replaceAll(",", "&#44;");
		searchTxt = searchTxt.replaceAll("-", "&#45;");
		searchTxt = searchTxt.replaceAll("/", "&#47;");
		searchTxt = searchTxt.replaceAll(":", "&#58;");
		searchTxt = searchTxt.replaceAll("=", "&#61;");
		searchTxt = searchTxt.replaceAll("@", "&#64;");
		searchTxt = searchTxt.replaceAll("_", "&#95;");
		searchTxt = searchTxt.replaceAll("`", "&#96;");
		searchTxt = searchTxt.replaceAll("~", "&#126;");
	}
%>
<form name="aform">
	<input type="hidden" name="category" value="<%=category%>">
	<input type="hidden" name="searchTxt" value="<%=searchTxt%>">
</form>

<!-- --타이틀-- -->
<h2 class="pt70">
	<span class="bold">'<%=searchTxt %>' 검색결과</span> 입니다.
</h2>

<!-- --리스트-- -->
<div class="list_wrap">
	<ul id="post_list" class="list_con con_flex">

	</ul>
	<div id="btn_post_more" class="add_btn mt70"><p onclick="loadList();">+ 더보기</p></div>
</div>

<script type="text/javascript">
var list_page=1;
var is_loadlist = false;
function loadList( ) {
	var cate = document.aform.category.value;
	var search_txt = document.aform.searchTxt.value;
	if( is_loadlist ) return; 
	is_loadlist = true;

	var url = "ajax/post_list.jsp?category="+cate+"&page="+list_page+"&searchTxt="+encodeURI(search_txt);		

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
