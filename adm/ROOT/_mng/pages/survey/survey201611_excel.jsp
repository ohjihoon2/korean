<%@ page contentType="application/vnd.ms-excel;charset=euc-kr" %>
<%
	if( session.getAttribute("admin_user_id") == null || "".equals(session.getAttribute("admin_user_id")) ) { return; }
%>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<%

	response.setContentType("application/vnd.ms-excel");
  	response.setHeader("Content-Disposition", "attachment; filename=survey201606.xls");
  	response.setHeader("Content-Description", "JSP Generated Data");
  	response.setHeader("Pragma", "no-cache");

  	String search_txt = REQParam(request.getParameter("search_txt"));

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;

	try{
%>
		<table>
           	<tbody>
           		<tr>
                  <th>No</th>
                  <th>Q1</th>
                  <th>Q2</th>
                  <th>Q3</th>
                  <th>Q4</th>
                  <th>Q5</th>
                  <th>Q6</th>
                  <th>Q7</th>
                  <th>Q8</th>
                  <th>writer</th>
                  <th>Sex</th>
                  <th>Age</th>
                  <th>Email</th>
                  <th>Handphone</th>
                  <th>Address</th>
                  <th>write ip</th>
                  <th>Write Date</th>
                </tr>
        <%
					sql =" 	SELECT "
						+"		a.idx, a.q01, a.q02, a.q03, a.q04, a.q05, a.q06, a.q07, a.q08, a.name, a.sex, a.age, a.email, a.handphone, a.address, a.write_ip, a.write_date "
						+"	FROM "
						+"		NARO_SURVEY201611 a "
						+"	WHERE "
						+"		a.del_yn='N' AND a.name LIKE ? ";
					sql+="	ORDER BY a.idx DESC ";
					int paramcnt=1;
					pstmt = con.prepareStatement( sql );
					pstmt.setString(paramcnt++, "%"+search_txt+"%");

		          	rs = pstmt.executeQuery();

					for( int i=1; rs.next(); i++ ) {
				%>
                <tr>
                  <td><%=i%></td>
                  <td><%=DBStr(rs,"q01")%></td>
                  <td><%=DBStr(rs,"q02")%></td>
                  <td><%=DBStr(rs,"q03")%></td>
                  <td><%=DBStr(rs,"q04")%></td>
                  <td><%=DBStr(rs,"q05")%></td>
                  <td><%=DBStr(rs,"q06")%></td>
                  <td><%=DBStr(rs,"q07")%></td>
                  <td><%=DBStr(rs,"q08")%></td>
                  <td><%=DBStr(rs,"name")%></td>
                  <td><%=DBStr(rs,"sex")%></td>
                  <td><%=DBStr(rs,"age")%></td>
                  <td><%=DBStr(rs,"email")%></td>
                  <td><%=DBStr(rs,"handphone")%></td>
                  <td><%=DBStr(rs,"address")%></td>
                  <td><%=DBStr(rs,"write_ip")%></td>
                  <td><%=DBStr(rs,"write_date")%></td>
                </tr>
                <%
					}
				%>
			</tbody>
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
