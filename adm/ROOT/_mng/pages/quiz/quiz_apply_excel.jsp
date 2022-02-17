<%@ page contentType="application/vnd.ms-excel;charset=euc-kr" %>
<%
	if( session.getAttribute("admin_user_id") == null || "".equals(session.getAttribute("admin_user_id")) ) { return; }
%>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<%
	
	response.setContentType("application/vnd.ms-excel");
  	response.setHeader("Content-Disposition", "attachment; filename=download.xls");
  	response.setHeader("Content-Description", "JSP Generated Data");
  	response.setHeader("Pragma", "no-cache");


	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;

	int quiz_idx=0;
	try{ quiz_idx=Integer.parseInt(request.getParameter("quiz_idx")); } catch( NumberFormatException ex ){}

	try{

%>
              <table>
                <tr>
                  <th>No</th>
                  <th>Name</th>
                  <th>Score</th>
                  <th>Grade</th>                  
                  <th>Phone</th>
                  <th>Email</th>
                  <th>Write Date</th>
                </tr>
<%
				sql =" 	SELECT * FROM NARO_QUIZ_APPLY a WHERE a.del_yn='N' AND a.application_yn='Y' AND a.quiz_idx=? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setInt(1, quiz_idx);						
				rs = pstmt.executeQuery(); 				
				for( int i=1; rs.next(); i++ ) {
%>                
                <tr>
                  <td><%=i%></td>
                  <td><%=DBStr(rs,"name")%></td>
                  <td><%=DBStr(rs,"score")%></td>                  
                  <td><%=DBStr(rs,"grade")%></td>                  
                  <td><%=DBStr(rs,"phone")%></td>                  
                  <td><%=DBStr(rs,"email")%></td>                  
                  <td style='mso-number-format:"\@"'><%=DBStr(rs,"write_date")%></td>                  
                </tr>
<%
				}
%>                
              </table>             
<%
		out.flush();
		out.clear();
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
		out.println(ex.toString());
	} finally {
		if( rs != null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="/_common/dbclose.jsp" %>