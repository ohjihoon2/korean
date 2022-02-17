<%@ page contentType="text/plain; charset=UTF-8" %>
<%@ include file="../../../include/check_login_pass.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%--
<option value="">:: 카테고리 1 선택 ::</option>
--%>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		String parent_idx = REQParam(request.getParameter("parent_idx"));
		
		String sql	=" SELECT idx, name FROM NARO_NEWS_CATEGORY WHERE del_yn='N' AND lvl=2 AND parent_idx=? ORDER BY sort_order ";
		pstmt = con.prepareStatement( sql );
		pstmt.setInt(1, Integer.parseInt( parent_idx ) );
		rs = pstmt.executeQuery();
		
		while( rs.next() ) {		
%>
<option value="<%=DBStr(rs,"idx")%>"><%=DBStr(rs,"name")%></option>
<%
		}
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
	} finally {
		if( rs != null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }	
	}
%>
<%@ include file="/_common/dbclose.jsp" %>