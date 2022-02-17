<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","카테고리별 접속통계");
	pageContext.setAttribute("PageDescription","카테고리별 게시물 조회수의 합계를 조회할 수 있습니다. 2016-06-02일 부터 유효한 데이터가 조회됩니다.");
	pageContext.setAttribute("PageMenuID","6-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>

<%
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
  <script>
    function DoSearch() 
    {
      var f = document.aform;
      f.action="view_count_by_category.jsp";
      f.submit();
    }

    function DoSaveExcel()
    {
      var f = document.aform;
      f.action="view_count_by_category_excel.jsp";
      f.submit();
    }

    function DoSaveNewsExcel()
    {
      var f = document.aform;
      f.action="view_count_by_news_excel.jsp";
      f.submit();  
    }
  </script>

    <form name="aform" method="GET">

	    <div class="row">	
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title"><%=wp_start_datetime%> ~ <%=wp_end_datetime%></h3>
              <div style="display:inline; margin-left: 200px">
                <input id="start_datetime" name="start_datetime" type="text" size="10" maxlength="10" value="<%=INPUT_VALUE(wp_start_datetime)%>">
                <input id="end_datetime" name="end_datetime" type="text" size="10" maxlength="10" value="<%=INPUT_VALUE(wp_end_datetime)%>">
                <button class="btn btn-default btn-xs" type="button" onclick="DoSearch();">검색</button>                    
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button class="btn btn-success btn-xs" type="button" onclick="DoSaveExcel();">Excel저장</button>                   
                <button class="btn btn-success btn-xs" type="button" onclick="DoSaveNewsExcel();">기사별 현황 Excel저장</button>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
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
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
      </div>
    </form>
    <script>
      $(function () {
        //DateTime picker
        $('#start_datetime').datetimepicker({
          format: "YYYY-MM-DD",     
                sideBySide: true
        });
        $('#end_datetime').datetimepicker({
          format: "YYYY-MM-DD",
          sideBySide: true
        });
      });
        
    </script>
<%
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
	} finally {
		if( rs != null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>

<%@ include file="../../include/bottom.jsp" %>
<%@ include file="/_common/dbclose.jsp" %>