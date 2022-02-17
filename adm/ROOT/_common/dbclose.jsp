<%
	try{
		if( con != null ) { con.close(); }
	}catch( SQLException ex ) {
		out.println("데이터베이스 접속 종료 중에 오류가 발생하였습니다. 다시 시도해 주세요. 지속적으로 문제가 발생하는 경우 관리자에게 문의해 주세요.");
		//out.println("<li>SQLException: " + ex.getMessage());
		//out.println("<li>SQLState: " + ex.getSQLState());
		//out.println("<li>VendorError: " + ex.getErrorCode());
	}
%>