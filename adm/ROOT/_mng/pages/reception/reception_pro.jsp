<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int paramcnt=0;
	try{
		request.setCharacterEncoding("UTF-8");
		String cmd 			= REQParam( request.getParameter("cmd") );
		String idx 			= REQParam( request.getParameter("idx") );

%>
<form name="aform" method="GET" action="reception_list.jsp">
<input type="hidden" name="gbn" value="<%=REQParam( request.getParameter("gbn") )%>"/>   
<input type="hidden" name="cpage" value="<%=REQParam( request.getParameter("cpage") )%>"/>
<input type="hidden" name="cmd" value="<%=cmd%>".>
<input type="hidden" name="idx" value="<%=idx%>".>
</form>
<%		
		//////////////////////////////////// 등록 ///////////////////////////////////////
		if( "change_confirm".equals(cmd) ) {
			String sql = " UPDATE NARO_RECEPTION SET confirm_yn=?, update_id=?, update_date=now() WHERE idx=? ";
			pstmt = con.prepareStatement( sql );			
			pstmt.setString( 1, REQParam( request.getParameter("confirm_yn") ) );
			pstmt.setString( 2, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( 3, idx );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('변경되었습니다.'); document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('변경되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			}							
		} else if( "remove".equals(cmd) ) {			
			String sql = " UPDATE NARO_RECEPTION SET del_yn='Y', update_id=?, update_date=now() WHERE idx=? ";
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
		out.println(ex.toString());
	} finally {
		if( rs !=null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="/_common/dbclose.jsp" %>