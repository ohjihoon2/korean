<%@page import="kr.urimal365.dao.QuizViewDAO"%>
<%@page import="kr.urimal365.dto.QuizView"%>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String quiz_apply_idx 		= request.getParameter("quiz_apply_idx");
	String application_name 	= request.getParameter("application_name");
	String application_phone	= request.getParameter("application_phone");
	String application_email 	= request.getParameter("application_email");
	String agree_yn 			= request.getParameter("agree_yn"); 

	/*
	out.println("<li>application_name : "+application_name);
	out.println("<li>application_phone : "+application_phone);
	out.println("<li>application_email : "+application_email);
	out.println("<li>agree_yn : "+agree_yn);
	*/

	
	HashMap<String,Object> param = new HashMap<String,Object>();
	param.put("name", application_name);
	param.put("phone", application_phone);
	param.put("email", application_email);
	param.put("agreeYn", agree_yn);
	param.put("idx", quiz_apply_idx);
	int upd_cnt = QuizViewDAO.getDAO().quizApply(param);
	
	if( upd_cnt > 0 ) {
%>
	<script>alert("등록되었습니다."); window.location="../index.jsp";</script>
<%
	} else {
%>
	<script>alert("등록되지 않았습니다. 다시 시도해 주세요."); window.location="../index.jsp";</script>
<%		
	} 
%>
