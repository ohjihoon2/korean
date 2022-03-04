<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	Connection con = null;
	
	try{ 
		com.mysql.jdbc.Driver  driver = new com.mysql.jdbc.Driver();
		con = DriverManager.getConnection( "jdbc:mysql://192.168.0.129/korean_dev?user=root&password=1234&useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Seoul&useSSL=false");
	}catch( SQLException ex ) {
		out.println("데이터베이스 접속에 오류가 발생하였습니다. 다시 시도해 주세요. 지속적으로 문제가 발생하는 경우 관리자에게 문의해 주세요.");
		//out.println("<li>SQLException: " + ex.getMessage());
		//out.println("<li>SQLState: " + ex.getSQLState());
		//out.println("<li>VendorError: " + ex.getErrorCode());
	}
%>