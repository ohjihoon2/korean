<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<form name="aform" action="media_list.jsp">
	<input type="hidden" name="cpage" value="<%=request.getParameter("cpage")%>"/>
	<input type="hidden" name="search_txt" value="<%=INPUT_VALUE(request.getParameter("search_txt"))%>"/>	
</form>
<%	
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try{
		request.setCharacterEncoding("UTF-8");
		
		String cmd 			= REQParam( request.getParameter("cmd") );
		String idx 			= REQParam( request.getParameter("idx") );
		
		//////////////////////////////////// 삭제 ///////////////////////////////////////
		if( "remove".equals(cmd) ) {
			String sql = "";

			//정보 가져오기
			sql = " SELECT * FROM NARO_MEDIA WHERE idx=? ";
			pstmt = con.prepareStatement( sql );						
			pstmt.setString( 1, idx );
			rs = pstmt.executeQuery();
			String filepath=null;
			if( rs.next() ) {
				filepath = rs.getString("path");
			}
			rs.close();
			pstmt.close();

			//해당파일 삭제
			java.io.File delfile = new java.io.File( filepath );
			if( delfile.exists() && delfile.isFile()) {
				delfile.delete();
			}

			//DB 삭제처리
			sql = " UPDATE NARO_MEDIA SET del_yn='Y', update_id=?, update_date=now() WHERE idx=? ";
			pstmt = con.prepareStatement( sql );			
			pstmt.setString( 1, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( 2, idx );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('삭제되었습니다.'); document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('삭제되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			}				
		//////////////////////////////////// 나머저의 경우(오류) ///////////////////////////////////////
		} else {
			out.println("올바른 접근이 아닙니다.");
		}
			
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
	} finally {
		if( rs !=null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="/_common/dbclose.jsp" %>