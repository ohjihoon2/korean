<%@page import="java.util.HashMap"%>
<%@page import="kr.urimal365.dao.QuizViewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int quiz_idx = 0;
	try{ quiz_idx=Integer.parseInt(request.getParameter("quiz_idx")); } catch(NumberFormatException ex){}
	
	int quiz_apply_idx = 0;
	
	if(quiz_idx>0) {
	HashMap<String,Object> param = new HashMap<String,Object>();
	param.put("idx", quiz_idx);
	param.put("ip", request.getRemoteAddr());
	int upd_cnt = QuizViewDAO.getDAO().startQuiz(param);

	if( upd_cnt > 0 )  {
		int idx = QuizViewDAO.getDAO().getIdx();
		if( idx != 0 ){
			quiz_apply_idx = idx;
		}
	}

	if( quiz_apply_idx > 0 ){				
%>
	<script>
		onQuizStart('<%=quiz_apply_idx%>');
	</script>
<%		
		}
	}
%>

