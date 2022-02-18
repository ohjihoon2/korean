<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String control = request.getParameter("control");
	String part = request.getParameter("part");

	if(control == null || part == null) {
		response.sendRedirect("../index.jsp");
	}
	String centerFile = "../" + control + "/" + control + "_" + part + ".jsp";
%>	
<!DOCTYPE html>
<html xml:lang="ko" lang="ko">
<%-- 헤더 --%>
<jsp:include page="bitsol_header.jsp"></jsp:include>
<%-- 본문 --%>
<section>
	<div class="con_wrap">
<jsp:include page="<%=centerFile %>"></jsp:include>
<%-- 카테고리 --%>
<% if(!part.equals("main")) { %>
	<jsp:include page="bitsol_category.jsp"></jsp:include>
<% } %>
	</div>
</section>
<%-- 푸터 --%>
<jsp:include page="bitsol_footer.jsp"></jsp:include>
</html>