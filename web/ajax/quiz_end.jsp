<%@page import="kr.urimal365.dao.QuizViewDAO"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int quiz_apply_idx = 0;
	try{ quiz_apply_idx=Integer.parseInt(request.getParameter("quiz_apply_idx")); } catch(NumberFormatException ex){}
	int quiz_score = 0;
	try{ quiz_score=Integer.parseInt(request.getParameter("score")); } catch(NumberFormatException ex){}
	int quiz_grade = 0;
	try{ quiz_grade=Integer.parseInt(request.getParameter("grade")); } catch(NumberFormatException ex){}

	String sql = null;
	if(quiz_apply_idx>0) {
		HashMap<String,Object> param = new HashMap<String,Object>();
		param.put("score", quiz_score);
		param.put("grade", quiz_grade);
		param.put("idx", quiz_apply_idx);
		int upd_cnt = QuizViewDAO.getDAO().endQuiz(param);
	}
%>