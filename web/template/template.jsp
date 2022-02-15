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
<jsp:include page="<%=centerFile %>"></jsp:include>
<%-- 푸터 --%>
<jsp:include page="bitsol_footer.jsp"></jsp:include>
</html>