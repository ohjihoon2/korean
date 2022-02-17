<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	PreparedStatement pstmt = null, pstmt2=null;
	ResultSet rs = null;

	try{
		String id 			= REQParam( request.getParameter("id") );
		String password 	= REQParam( request.getParameter("password") );
		
		String sql = " SELECT user_name FROM NARO_MST_ADMIN_USER WHERE user_id = ? AND user_pwd=password(?) AND use_yn = 'Y' ";
		pstmt = con.prepareStatement( sql );
		pstmt.setString(1, id);
		pstmt.setString(2, password );
		
		rs = pstmt.executeQuery();
		if( rs.next() ) {
			session.setAttribute("admin_user_id", id);
			session.setAttribute("admin_user_name", rs.getString("user_name"));
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			session.setAttribute("admin_login_date", formatter.format(new java.util.Date()));
			
			pstmt2 = con.prepareStatement( " INSERT INTO NARO_LOG_ADMIN_USER SET user_id=?, login_date=now(), login_ip=? " );
			pstmt2.setString(1,id);
			pstmt2.setString(2,request.getRemoteAddr());
			pstmt2.executeUpdate();
		
			response.sendRedirect("/_mng/pages/main/index.jsp");
			
		} else {
			out.println( "<script>alert('로그인 할 수 없습니다.\\r\\nID와 암호를 확인하세요.'); window.location='login.jsp'; </script>" );
		}
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
	} finally {
		if( rs !=null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
		if( pstmt2 != null ) { pstmt2.close(); }
	}
%>
<%@ include file="/_common/dbclose.jsp" %>