<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.NewsViewDAO"%>
<%@page import="kr.urimal365.dto.NewsView"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int category = 1;
	int postPage = 1;

	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ) {}


	try{ postPage = Integer.parseInt(request.getParameter("page")); if(postPage<1){postPage=1;} } catch( NumberFormatException ex ) {}

	String listType=request.getParameter("listType");
	if( !"popular".equals(listType) && !"recently".equals(listType)) { listType="recently"; }

	String isOpen = request.getParameter("isOpen");
	String searchTxt = request.getParameter("searchTxt");

	String yyyy = request.getParameter("yyyy");
	String mm = request.getParameter("mm");
	try{ yyyy = ""+Integer.parseInt(yyyy); } catch (NumberFormatException ex){ yyyy=""; }
	try{ mm = ""+Integer.parseInt(mm); } catch (NumberFormatException ex){ mm=""; }

	int pageSize = 9;
	int limitOffset = (postPage-1) * pageSize;

	HashMap<String, Object> param = new HashMap<String, Object>();

	param.put("category", category);
	param.put("parent", category);

	if (listType != null ) {
		param.put("listType", listType);
	}

	if (isOpen != null ) {
		param.put("isOpen", isOpen);
	}

	if (searchTxt != null ) {
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

		param.put("searchTxt", searchTxt);
	}

	if (yyyy != null || !"".equals(""+yyyy)) {
		param.put("yyyy", yyyy);
	}

	if (mm != null || !"".equals(""+mm)) {
		param.put("mm", mm);
	}

	param.put("pageSize", pageSize);
	param.put("limitOffset", limitOffset);


	List<NewsView> postList = NewsViewDAO.getDAO().postList(param);
%>
<% for (NewsView post : postList) {
	String thumnail = post.getThumbnailFile();
	if (thumnail == null || thumnail.equals("")) {
		thumnail = "/img/common/list_thumnail.jpg";
	}
%>
<li>
	<a href="index.jsp?control=page&part=view&idx=<%=post.getIdx()%>">
		<div class="list_img">
			<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
			<img src="<%=thumnail %>" alt="">
		</div>
		<p class="tit_color"><%=post.getCategoryName() %></p>
		<p class="tit"><%=post.getTitle() %></p>
		<p class="tit_date"><%=post.getWriteDate() %></p>
	</a>
</li>

<% } %>
<% if (limitOffset == 0 && postList.size() == 0) {  %>
	<% if (searchTxt.equals("")) {  %>
		<li class="none">
			등록된 게시물이 없습니다.
		</li>
	<% } else { %>
		<li class="none">
			검색된 게시물이 없습니다.
		</li>
	<% } %>
<% } %>

<% if (postList.size() < pageSize) {  %>
	<script>$("#btn_post_more").hide();</script>
<% } %>