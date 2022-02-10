<%@page import="kr.urimal365.dao.ReceptionDAO"%>
<%@page import="kr.urimal365.dto.Reception"%>
<%@page import="kr.urimal365.util.UtilFunction"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String gbn 			= UtilFunction.reqString(request.getParameter("gbn"));
	String receiptGbn 	= UtilFunction.reqString(request.getParameter("receipt_gbn")); 
	String name			= UtilFunction.reqString(request.getParameter("name"));
	String email 		= UtilFunction.reqString(request.getParameter("email"));
	String post			= UtilFunction.reqString(request.getParameter("post"));
	String address		= UtilFunction.reqString(request.getParameter("address"));
	String check1 		= UtilFunction.reqString(request.getParameter("check1")); 
	String check2 		= UtilFunction.reqString(request.getParameter("check2")); 


	if( gbn == null || receiptGbn == null || email == null ) {
		%><script>alert("올바른 접근이 아닙니다."); window.location="../index.jsp";</script><%		
	} else {
		Reception reception = new Reception();
		reception.setGbn(gbn);
		reception.setReceiptGbn(receiptGbn);
		reception.setName(name);
		reception.setEmail(email);
		reception.setPost(post);
		reception.setAddress(address);
		reception.setCheck1(check1);
		reception.setCheck2(check2);
		reception.setWriteIp(request.getRemoteAddr());
		
		int cnt = ReceptionDAO.getDAO().insertReception(reception);
		if( cnt > 0 ) {
			%><script>alert("등록되었습니다."); window.location="../index.jsp";</script><%
		} else {
			%><script>alert("등록되지 않았습니다. 다시 시도해 주세요."); window.location="../index.jsp";</script><%		
		} 
	}
	
%>
