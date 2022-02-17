<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.util.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%	
	request.setCharacterEncoding("UTF-8");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int paramcnt=0;
	try{
				
		String cmd 			= REQParam( request.getParameter("cmd") );		
		String gbn 			= REQParam( request.getParameter("gbn") );		
		String idx 			= REQParam( request.getParameter("idx") );		

%>
<form name="aform" method="GET" action="css_list.jsp">
<input type="hidden" name="gbn" value="<%=gbn%>".>
</form>
<%		
		//////////////////////////////////// 등록 ///////////////////////////////////////
		if( "write".equals(cmd) ) {
			//String sql = " UPDATE NARO_CONTENTS SET del_yn='Y',open_yn='N' WHERE gbn = '" + gbn + "'";
			//pstmt = con.prepareStatement( sql );
			//int upd_cnt = pstmt.executeUpdate();
			
			//if(upd_cnt > 0) {
				String sql = " INSERT INTO fzst_css SET gbn=?, contents=?, open_yn=?,  write_id=?, title=?, write_date=now() ";
				pstmt = con.prepareStatement( sql );
			
				paramcnt=1;	
				pstmt.setString( paramcnt++, gbn );
				pstmt.setString( paramcnt++, REQParam(request.getParameter("contents")) );
				pstmt.setString( paramcnt++, REQCHKParam(request.getParameter("open_yn")) );			
				pstmt.setString( paramcnt++, (String)session.getAttribute("admin_user_id") );
				pstmt.setString( paramcnt++, REQParam(request.getParameter("title")) );
				int in_cnt = pstmt.executeUpdate();		
				
				if( in_cnt > 0 ) {
					out.println( "<script>alert('등록되었습니다.'); document.aform.submit(); </script>" );
				} else {
					out.println( "<script>alert('등록되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
				}			
			//} else {
				//out.println( "<script>alert('등록되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			//}		
		//////////////////////////////////// 수정 ///////////////////////////////////////
		} else if( "modify".equals(cmd) ) {
			String sql = " UPDATE fzst_css SET open_yn=?, title=?,  contents=? WHERE idx=? ";
			pstmt = con.prepareStatement( sql );
			pstmt.setString( 1, REQCHKParam(request.getParameter("open_yn")));	
			pstmt.setString( 2, REQParam(request.getParameter("title")) );
			pstmt.setString( 3, REQParam(request.getParameter("contents")) );
			pstmt.setString( 4, idx );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('수정되었습니다.'); document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('수정되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			}							
		}  else if( "remove".equals(cmd) ) {
			String idxText = request.getParameter("idxArr"); 
			String[] idxArr = idxText.split(",");
			int rmv_cnt = 0;
			int cnt=0;
			for (int i=0; i<idxArr.length;i++) {
				String sql = " DELETE FROM fzst_css WHERE idx=? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setString( 1, idxArr[i]);	
				rmv_cnt = pstmt.executeUpdate();		
				if( rmv_cnt > 0 ) {
					cnt++;
				}
			}
			
			if( rmv_cnt > 0 ) {
				out.println( "<script>alert('총"+ idxArr.length +"개 중 " + cnt + "개 삭제되었습니다.'); document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('삭제되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			}							
		//////////////////////////////////// 나머저의 경우(오류) ///////////////////////////////////////
		}else {
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