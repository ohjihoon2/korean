<%@ page contentType="application/vnd.ms-excel;charset=euc-kr" %>
<%
	if( session.getAttribute("admin_user_id") == null || "".equals(session.getAttribute("admin_user_id")) ) { return; }
%>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<%
	
	response.setContentType("application/vnd.ms-excel");
  	response.setHeader("Content-Disposition", "attachment; filename=statistics_news.xls");
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
                  <th>Category1</th>
                  <th>Category2</th>                  
                  <th>Title</th>                  
                  <th>View Count(<%=wp_start_datetime%> ~ <%=wp_end_datetime%>)</th>                                    
                </tr>
        <%  
					sql = " SELECT 	a.category_name, a.idx, a.title, ifnull( b.view_count,0 ) AS view_count "
						+ "		, ( SELECT x.name FROM NARO_NEWS_CATEGORY x WHERE x.idx = a.cate1 ) AS cate1_name "
						+ "	FROM VW_NARO_NEWS a "
						+ "	INNER JOIN ( SELECT x.news_idx, sum(x.view_count) AS view_count FROM NARO_NEWS_VIEW_COUNT x WHERE x.dt>=? AND x.dt<=? GROUP BY x.news_idx ) b ON a.idx = b.news_idx	"
						+ "	ORDER BY view_count DESC ";
					pstmt = con.prepareStatement( sql );
		          	pstmt.setString(1,wp_start_datetime);
		          	pstmt.setString(2,wp_end_datetime);
		          	rs = pstmt.executeQuery();
					
					for( int i=1; rs.next(); i++ ) {
				%>
                <tr>
                  <td><%=i%></td>
                  <td><%=DBStr(rs, "cate1_name")%></td>
                  <td><%=DBStr(rs, "category_name")%></td>
                  <td><%=DBStr(rs, "title")%></td>
                  <td><%=NumberFormat(DBInt(rs, "view_count"))%></td>                  
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