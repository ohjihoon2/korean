<%@ page contentType="application/vnd.ms-excel;charset=euc-kr" %>
<%
	if( session.getAttribute("admin_user_id") == null || "".equals(session.getAttribute("admin_user_id")) ) { return; }
%>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<%
	
	response.setContentType("application/vnd.ms-excel");
  	response.setHeader("Content-Disposition", "attachment; filename=statistics_category.xls");
  	response.setHeader("Content-Description", "JSP Generated Data");
  	response.setHeader("Pragma", "no-cache");


	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;
	
	try{
		java.util.Calendar currentCalendar = java.util.Calendar.getInstance();
	    java.text.DecimalFormat df = new java.text.DecimalFormat("00");
	    
	    String wp_start_datetime = REQParam(request.getParameter("start_datetime"));
	    String wp_end_datetime = REQParam(request.getParameter("end_datetime"));

	    if(!IsValid(wp_start_datetime)){
	      wp_start_datetime = currentCalendar.get(java.util.Calendar.YEAR)+"-"+ df.format( currentCalendar.get(java.util.Calendar.MONTH)+1 )+"-01";
	    }

	    if(!IsValid(wp_end_datetime)){
	      wp_end_datetime = currentCalendar.get(java.util.Calendar.YEAR)+"-"+ df.format( currentCalendar.get(java.util.Calendar.MONTH)+1 )+"-"+df.format(currentCalendar.get(java.util.Calendar.DAY_OF_MONTH));;
	    }
%>

			<table>
                <tbody><tr>
                  <th>No</th>
                  <th>Level</th>
                  <th>Name</th>                  
                  <th>View Count</th>                  
                  <th>Desc</th>
                </tr>
        <%  
					sql = " SELECT a.idx, a.parent_idx, a.lvl, a.name, IfNull( b.view_count, 0 ) AS view_count "
						+ " FROM NARO_NEWS_CATEGORY a LEFT OUTER JOIN ( "
						+ " 	  SELECT x.category_idx, sum( y.view_count ) AS view_count FROM VW_NARO_NEWS x INNER JOIN NARO_NEWS_VIEW_COUNT y ON x.idx = y.news_idx WHERE y.dt>=? AND y.dt<=? GROUP BY x.category_idx "
					  + "     UNION ALL "
					  + "     SELECT x.cate1, sum( y.view_count ) AS view_count FROM VW_NARO_NEWS x INNER JOIN NARO_NEWS_VIEW_COUNT y ON x.idx = y.news_idx WHERE y.dt>=? AND y.dt<=? GROUP BY x.cate1 "
					  + " ) b on a.idx = b.category_idx "
						+ " WHERE a.del_yn='N' "
						+ " ORDER BY a.parent_idx, a.lvl, a.sort_order ";
					pstmt = con.prepareStatement( sql );
		          	pstmt.setString(1,wp_start_datetime);
		          	pstmt.setString(2,wp_end_datetime);
		          	pstmt.setString(3,wp_start_datetime);
		          	pstmt.setString(4,wp_end_datetime);
					rs = pstmt.executeQuery();
					
					for( int i=1; rs.next(); i++ ) {
				%>
                <tr>
                  <td><%=i%></td>
                  <td><%=DBInt(rs, "lvl")%></td>
                  <td style="padding-left:<%=(DBInt(rs,"lvl")-1)*20%>px<% if(DBInt(rs,"lvl")==1){%>;font-weight:bold<%}%>"><%=DBStr(rs, "name")%></td>
                  <td style="<% if(DBInt(rs,"lvl")==1){%>font-weight:bold<%}%>" align="right"><%=NumberFormat(DBInt(rs, "view_count"))%></td>
                  <td></td>
                </tr>
                <%
					}
				%>
              </tbody></table>

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