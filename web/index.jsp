<%@ page import="kr.urimal365.dao.VisitCountDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	if(session.isNew()){
		VisitCountDAO dao = VisitCountDAO.getInstance();
		try {
			// 전체 방문자 수 증가
			dao.setTotalCount(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	request.setCharacterEncoding("UTF-8");

	String control = request.getParameter("control");
	String part = request.getParameter("part");
	String banner_preview_file = null;
	if(request.getParameter("banner_preview_file") != null) {banner_preview_file = request.getParameter("banner_preview_file");}
	if(control == null) { control = "page"; }
	if(part == null) { part = "main"; }


	control = control.replaceAll("&", "&amp;");
	control = control.replaceAll("#", "&#35;");
	control = control.replaceAll(";", "&#59;");
	control = control.replaceAll("\\\\", "&#92;");
	control = control.replaceAll("<"  , "&lt;");
	control = control.replaceAll(">"  , "&gt;");
	control = control.replaceAll("\\(", "&#40;");
	control = control.replaceAll("\\)", "&#41;");
	control = control.replaceAll("'"  , "&#39;");
	control = control.replaceAll("\"", "&quot;");
	control = control.replaceAll("[$]", "&#36;");
	control = control.replaceAll("[*]", "&#42;");
	control = control.replaceAll("[+]", "&#43;");
	control = control.replaceAll("[|]", "&#124;");
	control = control.replaceAll("\\." , "&#46;");
	control = control.replaceAll("\\?" , "&#63;");
	control = control.replaceAll("\\[" , "&#91;");
	control = control.replaceAll("\\]" , "&#93;");
	control = control.replaceAll("\\^" , "&#94;");
	control = control.replaceAll("\\{" , "&#123;");
	control = control.replaceAll("\\}" , "&#125;");
	control = control.replaceAll("!", "&#33;");
	control = control.replaceAll("%", "&#37;");
	control = control.replaceAll(",", "&#44;");
	control = control.replaceAll("-", "&#45;");
	control = control.replaceAll("/", "&#47;");
	control = control.replaceAll(":", "&#58;");
	control = control.replaceAll("=", "&#61;");
	control = control.replaceAll("@", "&#64;");
	control = control.replaceAll("_", "&#95;");
	control = control.replaceAll("`", "&#96;");
	control = control.replaceAll("~", "&#126;");

	part = part.replaceAll("&", "&amp;");
	part = part.replaceAll("#", "&#35;");
	part = part.replaceAll(";", "&#59;");
	part = part.replaceAll("\\\\", "&#92;");
	part = part.replaceAll("<"  , "&lt;");
	part = part.replaceAll(">"  , "&gt;");
	part = part.replaceAll("\\(", "&#40;");
	part = part.replaceAll("\\)", "&#41;");
	part = part.replaceAll("'"  , "&#39;");
	part = part.replaceAll("\"", "&quot;");
	part = part.replaceAll("[$]", "&#36;");
	part = part.replaceAll("[*]", "&#42;");
	part = part.replaceAll("[+]", "&#43;");
	part = part.replaceAll("[|]", "&#124;");
	part = part.replaceAll("\\." , "&#46;");
	part = part.replaceAll("\\?" , "&#63;");
	part = part.replaceAll("\\[" , "&#91;");
	part = part.replaceAll("\\]" , "&#93;");
	part = part.replaceAll("\\^" , "&#94;");
	part = part.replaceAll("\\{" , "&#123;");
	part = part.replaceAll("\\}" , "&#125;");
	part = part.replaceAll("!", "&#33;");
	part = part.replaceAll("%", "&#37;");
	part = part.replaceAll(",", "&#44;");
	part = part.replaceAll("-", "&#45;");
	part = part.replaceAll("/", "&#47;");
	part = part.replaceAll(":", "&#58;");
	part = part.replaceAll("=", "&#61;");
	part = part.replaceAll("@", "&#64;");
	part = part.replaceAll("_", "&#95;");
	part = part.replaceAll("`", "&#96;");
	part = part.replaceAll("~", "&#126;");
%>
<jsp:forward page="template/template.jsp">
	<jsp:param value="<%=control %>" name="control"/>
	<jsp:param value="<%=part %>" name="part"/>
</jsp:forward>