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
		
		String cmd 			= REQParam( request.getParameter("cmd") );
		String idx 			= REQParam( request.getParameter("idx") );
		String name 		= REQParam( request.getParameter("name"+idx) );
		String link 		= REQParam( request.getParameter("link"+idx) );
		String is_open 		= REQCHKParam( request.getParameter("is_open"+idx) );
		String sort_order 	= REQParam( request.getParameter("sort_order"+idx) );

		//////////////////////////////////// 등록 ///////////////////////////////////////
		if( "write".equals(cmd) ) {
			String sql = " INSERT INTO NARO_NEWS_CATEGORY SET parent_idx=?, lvl=2, name=?, link=?, sort_order=?, del_yn='N', write_id=?, write_date=now() ";
			pstmt = con.prepareStatement( sql );
			pstmt.setString( 1, idx );
			pstmt.setString( 2, "새 카테고리" );
			pstmt.setString( 3, "" );
			pstmt.setString( 4, "" );
			pstmt.setString( 5, (String)session.getAttribute("admin_user_id") );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('등록되었습니다.'); window.location='category_list.jsp'; </script>" );
			} else {
				out.println( "<script>alert('등록되지 않았습니다. 다시 시도해주세요.'); window.location='category_list.jsp'; </script>" );
			}			
		//////////////////////////////////// 수정 ///////////////////////////////////////
		} else if( "modify".equals(cmd) ) {
			String sql = " UPDATE NARO_NEWS_CATEGORY SET name=?, link=?, sort_order=?, is_open=?, update_id=?, update_date=now() WHERE idx=? ";
			pstmt = con.prepareStatement( sql );			
			pstmt.setString( 1, name );
			pstmt.setString( 2, link );
			pstmt.setString( 3, sort_order );
			pstmt.setString( 4, is_open );
			pstmt.setString( 5, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( 6, idx );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('수정되었습니다.'); window.location='category_list.jsp'; </script>" );
			} else {
				out.println( "<script>alert('수정되지 않았습니다. 다시 시도해주세요.'); window.location='category_list.jsp'; </script>" );
			}	
		//////////////////////////////////// 삭제 ///////////////////////////////////////
		} else if( "remove".equals(cmd) ) {
			String sql = " UPDATE NARO_NEWS_CATEGORY SET del_yn='Y', update_id=?, update_date=now() WHERE idx=? ";
			pstmt = con.prepareStatement( sql );			
			pstmt.setString( 1, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( 2, idx );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('삭제되었습니다.'); window.location='category_list.jsp'; </script>" );
			} else {
				out.println( "<script>alert('삭제되지 않았습니다. 다시 시도해주세요.'); window.location='category_list.jsp'; </script>" );
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