<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","카테고리 관리");
	pageContext.setAttribute("PageDescription","기사분류를 관리할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","1-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>

<script src="/_js/common.js"></script>
<script>
	function DoWrite( idx ) {
		if( !confirm("새로운 하위 카테고리를 생성하시겠습니까?" ) ) return;
		
		var f = document.aform;
		f.cmd.value = "write";
		f.idx.value = idx;
		f.submit();
	}
	
	function DoModify( idx ) {
		var f = document.aform;
		f.cmd.value = "modify";
		f.idx.value = idx;
		f.submit();
	}
	
	function DoRemove( idx ) {
		if( !confirm("해당 카테고리를 삭제하시겠습니까?" ) ) return;
		
		var f = document.aform;
		f.cmd.value = "remove";
		f.idx.value = idx;
		f.submit();
	}
</script>		

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
%>
<form name="aform" action="category_pro.jsp" method="POST">
	<input type="hidden" name="cmd" value=""/>
	<input type="hidden" name="idx" value=""/>
	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">카테고리 목록</h3>

			<%--
              <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 150px;">
                  <input name="table_search" class="form-control pull-right" type="text" placeholder="Search">

                  <div class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
                  </div>
                </div>
              </div>
             --%>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
                  <th>No</th>
                  <th>Level</th>
                  <th>Name</th>
                  <th>Sort Order</th>
                  <th>Link</th>
                  <th>Open</th>
                  <th>Command</th>
                  <th>Desc.</th>
                </tr>
                <%
					String sql = " SELECT * FROM NARO_NEWS_CATEGORY WHERE del_yn='N' ORDER BY parent_idx, lvl, sort_order ";
					pstmt = con.prepareStatement( sql );
					rs = pstmt.executeQuery();
					
					for( int i=1; rs.next(); i++ ) {
				%>
                <tr>
                  <td><%=i%></td>
                  <td><%=DBInt(rs, "lvl")%></td>
                  <td style="padding-left:<%=(DBInt(rs,"lvl")-1)*20%>px"><input class="form-control" type="text" name="name<%=DBInt(rs, "idx")%>" placeholder="Enter ..." value="<%=INPUT_VALUE(DBStr(rs, "name"))%>"></td>
                  <td><input class="form-control" type="text" name="sort_order<%=DBInt(rs, "idx")%>" placeholder="Enter ..." value="<%=INPUT_VALUE(DBStr(rs, "sort_order"))%>"></td>
                  <td><input class="form-control" type="text" name="link<%=DBInt(rs, "idx")%>" placeholder="Enter ..." value="<%=INPUT_VALUE(DBStr(rs, "link"))%>"></td>
                  <td align="center"><input type="checkbox" name="is_open<%=DBInt(rs, "idx")%>" value="Y" <%=("Y".equals(DBStr(rs, "is_open")))?"checked":""%>></td>
                  <td>
                  	<% if( DBInt(rs,"lvl")==1 ) { %><button class="btn btn-inline btn-primary btn-xs" type="button" onclick="DoWrite('<%=DBInt(rs, "idx")%>');">추가</button><% } %>
                  	<button class="btn btn-inline btn-warning btn-xs" type="button" onclick="DoModify('<%=DBInt(rs, "idx")%>');">수정</button>
                    <button class="btn btn-inline btn-danger btn-xs" type="button" onclick="DoRemove('<%=DBInt(rs, "idx")%>');">삭제</button>
                  </td>
                  <td>W:(<%=DBStr(rs, "write_id")%>/<%=DBStr(rs, "write_date")%>), U:(<%=DBStr(rs, "update_id")%>/<%=DBStr(rs, "update_date")%>)</td>
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