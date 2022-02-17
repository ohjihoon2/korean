<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","우리말 달인 관리");
	pageContext.setAttribute("PageDescription","우리말 달인 등록 및 수정할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","4-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>

<script src="/_js/common.js"></script>
<script>
	function DoWrite()
	{
		var f = document.aform;
		f.action="quiz_detail_form.jsp";		
		f.cmd.value = "write";
		f.submit();
	}

	function GoList()
	{
		var f = document.aform;
		f.action="quiz_list.jsp";		
		f.submit();
	}

	function GoView( pidx )
	{
		var f = document.aform;
		f.action="quiz_detail_form.jsp";		
		f.cmd.value = "modify";
		f.idx.value = pidx;
		f.submit();	
	}
	
</script>


<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;

	int quiz_idx=0;
	try{ quiz_idx=Integer.parseInt(request.getParameter("quiz_idx")); } catch( NumberFormatException ex ){}

	try{
		sql = " SELECT ym FROM NARO_QUIZ WHERE idx=? ";
		pstmt = con.prepareStatement( sql );				
		pstmt.setInt(1,quiz_idx);
		rs = pstmt.executeQuery();
		String ym="";
		if( rs.next() ){
			ym = rs.getString("ym");
		}
		rs.close();
		pstmt.close();
%>

<form name="aform" method="GET">
	<input type="hidden" name="cmd"/>    
	<input type="hidden" name="idx"/>    
	<input type="hidden" name="quiz_idx" value="<%=quiz_idx%>"/>    
	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title"><%=ym%></h3>
				
              <div class="box-tools">
                    <button class="btn btn-inline btn-primary btn-xs" type="button" onclick="DoWrite();">추가</button>
                    <button class="btn btn-inline btn-warning btn-xs" style="margin-left:10px" type="button" onclick="GoList();">뒤로</button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
                  <th>Num</th>
                  <th>Question</th>
                  <th>Right Answer</th>
                </tr>
<%
				sql =" 	SELECT a.* FROM NARO_QUIZ_QUESTION a WHERE a.del_yn='N' AND a.quiz_idx=? ORDER BY a.num ASC ";
				pstmt = con.prepareStatement( sql );				
				pstmt.setInt(1,quiz_idx);
				rs = pstmt.executeQuery(); 				
				for( int i=1; rs.next(); i++ ) {
%>                
                <tr>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=i%></a></td>
                  <td>
                  	<a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=DBStr(rs,"title")%></a><br>
                  	<small><%=DBStr(rs,"subtitle")%></small><br>
                  	<p class="text-muted well well-sm no-shadow"><small><%=DBStr(rs,"contents")%></small></p>
                  </td>
                  <td><h3><%=DBStr(rs,"right_answer")%></h3></td>
                </tr>
<%
				}
%>                
              </tbody></table>
            </div>
          </div>
          <!-- /.box -->
        </div>
      </div>
</form>      
    
<%
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
		out.println(ex.toString());
	} finally {
		if( rs != null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="../../include/bottom.jsp" %>
<%@ include file="/_common/dbclose.jsp" %>