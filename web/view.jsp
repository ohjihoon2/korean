<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
	String preview = request.getParameter("preview");
	
	response.sendRedirect("index.jsp?control=page&part=view&idx=" + idx + "&preview=" + preview);
%>