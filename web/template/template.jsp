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
<jsp:include page="bitsol_header.jsp"></jsp:include>
<body>
<jsp:include page="<%=centerFile %>"></jsp:include>
<jsp:include page="new_footer.jsp"></jsp:include>
</body>
</html>