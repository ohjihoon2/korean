<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.NewsViewDAO"%>
<%@page import="kr.urimal365.dto.NewsView"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int category = 1;
	int postPage = 1;
	
	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ) {}
	try{ postPage = Integer.parseInt(request.getParameter("page")); if(postPage<1){postPage=1;} } catch( NumberFormatException ex ) {}
	
	String listType=request.getParameter("listType");
	if( !"popular".equals(listType) && !"recently".equals(listType)) { listType="recently"; }
	
	String searchTxt = request.getParameter("searchTxt");
	
	String yyyy = request.getParameter("yyyy");
	String mm = request.getParameter("mm");
	try{ yyyy = ""+Integer.parseInt(yyyy); } catch (NumberFormatException ex){ yyyy=""; }
	try{ mm = ""+Integer.parseInt(mm); } catch (NumberFormatException ex){ mm=""; }
	
	int pageSize = 8;
	int limitOffset = (postPage-1) * pageSize;
	
	HashMap<String, Object> param = new HashMap<String, Object>();
	
	if (category > 0) {
		param.put("category", category);
		param.put("cate1", category);
	}
	
	if (listType != null ) {
		param.put("listType", listType);
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
	String thumnail = post.getDefaultThumbnailFile();
	if (thumnail == null || thumnail.equals("")) {
		thumnail = "/images/common/thumnail_category_old.jpg";
	}
%>
<li>
				<div class="">
					<p class="img"><!-- 265*149(6.4*3.6) �̹��� ������ ���� -->
						<img src="<%=thumnail %>" alt="" class="bg"/>
					</p>
					<p class="cont">
						<span class="cate"><%=post.getCategoryName() %></span>
						<strong class="tit"><%=post.getTitle() %></strong>
						<span class="day"><%=post.getWriteDate() %>.</span>
					</p>
					<span class="layer"><a href="index.jsp?control=page&part=view&idx=<%=post.getIdx()%>"><img src="img/sub/listBt.png" alt=""/></a></span>
				</div>
</li>
<% } %>
<%
if (postList.size() < pageSize) {  %>
	<script>$("#btn_post_more").hide();</script>
<% } %>