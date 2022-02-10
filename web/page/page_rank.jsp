<%@page import="java.util.Calendar"%>
<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xml:lang="ko" lang="ko">
<%
	int category = 0;
	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ){ }
	
	String listType = request.getParameter("listType");
	if( !"popular".equals(listType) && !"recently".equals(listType)) { listType="popular"; }
	
	Calendar currentCalendar = Calendar.getInstance();
	
	int yyyy = currentCalendar.get(Calendar.YEAR); 
	int mm = currentCalendar.get(Calendar.MONTH) + 1;
	
	try{ yyyy = Integer.parseInt(request.getParameter("yyyy")); } catch( NumberFormatException ex ) {}
	try{ mm = Integer.parseInt(request.getParameter("mm")); } catch( NumberFormatException ex ) {}
	
	java.text.DecimalFormat df = new java.text.DecimalFormat("00");
	String rankYear=Integer.toString(yyyy), rankMM=df.format(mm); 
	
%>
<body>

<div class="contentWrap contentWrapBg">
	<form name="aform">
		<input type="hidden" name="category" value="<%=category%>">
		<input type="hidden" name="listType" value="<%=listType%>">
		<input type="hidden" name="yyyy" value="<%=rankYear%>">
		<input type="hidden" name="mm" value="<%=rankMM%>">
		<input type="hidden" name="control" value="page">
	<input type="hidden" name="part" value="rank">
	</form>
	<div class="listStyle">
		<p class="title">
			<strong>'인기글'</strong>글 모음입니다.
		</p>

		<!-- 기간별 리스트 -->
		<div class="date_control">
			<a href="javascript:GoPrevMonth();"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>
			<strong id="post_list_yyyy"><%=rankYear %></strong>
			<span>년</span>
			<strong id="post_list_mm"><%=rankMM %></strong> 
			<span>월</span>
			<a href="javascript:GoNextMonth();"><i class="fa fa-chevron-right" aria-hidden="true"></i></a>
		</div>

		<!-- 탭메뉴 -->
		<ul class="tab_menu three">
			<li <%if(listType.equals("popular")) { %>class="on"<% } %>><a href="javascript:GoList('popular');"><i class="fa fa-heart" aria-hidden="true"></i> 인기 많은 순</a></li>
			<li <%if(listType.equals("recently")) { %>class="on"<% } %>><a href="javascript:GoList('recently');"><i class="fa fa-bars" aria-hidden="true"></i> 최근 작성 순</a></li>
		</ul>


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
	var yyyy = document.aform.yyyy.value;
	var mm = document.aform.mm.value;
	var list_type = document.aform.listType.value;
	
	if( is_loadlist ) return; 
	is_loadlist = true;

	var url = "ajax/post_list.jsp?category="+cate+"&page="+list_page+"&yyyy="+yyyy+"&mm="+mm+"&listType="+list_type;
	
	$.get( url, function(data) {			 
		$("#post_list").append(data);			 
		list_page++;
		is_loadlist = false;
	}).fail(function() {
	    is_loadlist = false;
	});
}

function GoList( list_type )
{
	var f = document.aform;
	f.listType.value=list_type;
	f.submit();
}

function GoPrevMonth()
{
	var f = document.aform;
	f.action="index.jsp";				
	f.yyyy.value="<%= (mm-1)<1 ? yyyy-1 : yyyy %>";
	f.mm.value="<%= (mm-1)<1 ? 12 : mm-1 %>";
	f.submit();
}

function GoNextMonth()
{
	var f = document.aform;
	f.action="index.jsp";		
	f.yyyy.value="<%= (mm+1)>12 ? yyyy+1 : yyyy %>";
	f.mm.value="<%= (mm+1)>12 ? 1 : mm+1 %>";
	f.submit();
}

window.onload=function()
{
	loadList();
}
</script>
</body>
</html>
