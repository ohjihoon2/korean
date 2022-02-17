<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%	
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
		request.setCharacterEncoding("UTF-8");
		
		String user_id 		= REQParam( request.getParameter("user_id") );
		String user_name 	= REQParam( request.getParameter("user_name") );
		String user_pwd 	= REQParam( request.getParameter("user_pwd") );
		String use_yn 		= REQCHKParam( request.getParameter("use_yn") );
		
		String sql = " INSERT INTO NARO_MST_ADMIN_USER ( user_id, user_name, user_pwd, use_yn, write_id, write_date ) "
					+" VALUES ( ?, ?, password(?), ?, ?, now() ) ";
		pstmt = con.prepareStatement( sql );
		pstmt.setString( 1, user_id );
		pstmt.setString( 2, user_name );
		pstmt.setString( 3, user_pwd );
		pstmt.setString( 4, use_yn );
		pstmt.setString( 5, (String)session.getAttribute("admin_user_id") );
		int upd_cnt = pstmt.executeUpdate();		
		
		if( upd_cnt > 0 ) {
			out.println( "<script>alert('등록되었습니다.'); window.location='admin_user_list.jsp'; </script>" );
		} else {
			out.println( "<script>alert('등록되지 않았습니다. 다시 시도해주세요.'); window.location='admin_user_list.jsp'; </script>" );
		}
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
	} finally {
		if( rs !=null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="/_common/dbclose.jsp" %>