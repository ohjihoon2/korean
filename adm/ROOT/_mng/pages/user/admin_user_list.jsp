<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","관리자 관리");
	pageContext.setAttribute("PageDescription","관리자 계정의 추가,수정,삭제할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","0-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>

<script src="/_js/common.js"></script>
<script>
	function CheckWriteAdminUser( ) {
		var f = document.write_form;
		if( CheckEmpty( f.user_id, "ID를 입력하세요." ) ) return;
		if( CheckIDPWD( f.user_id, "ID는 숫자나 영문자만 입력하세요." ) ) return;
		if( CheckEmpty( f.user_pwd, "암호를 입력하세요." ) ) return;
		if( CheckEmpty( f.user_name, "이름을 입력하세요." ) ) return;
		f.action="admin_user_write_pro.jsp";	
		f.submit();
	}
	
	function CheckModifyAdminUser( f ) {
		if( ! confirm("수정하시겠습니까?" ) ) return;
		
		if( CheckEmpty( f.user_name, "이름을 입력하세요." ) ) return;
		f.action="admin_user_modify_pro.jsp";	
		f.submit();
	}
</script>


<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
%>
	   <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">관리자 목록</h3>

              <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 150px;">
                  <input name="table_search" class="form-control pull-right" type="text" placeholder="Search">

                  <div class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
                  <th>ID</th>
                  <th>암호</th>
                  <th>이름</th>
                  <th>사용여부</th>
                  <th>수정</th>
                  <th>등록자</th>
                  <th>등록일자</th>
                  <th>수정자</th>
                  <th>수정일자</th>
                </tr>
<%
		String sql = " SELECT * FROM NARO_MST_ADMIN_USER ORDER BY user_name ";
		pstmt = con.prepareStatement( sql );
		rs = pstmt.executeQuery();		
		
		int rec_no=0;
		while( rs.next() ) {
			rec_no++;
%>            
				<form name="modify_form" method="POST">
				<input type="hidden" name="user_id" value="<%=rs.getString("user_id")%>"/>    
                <tr>
                  <td><%=rs.getString("user_id")%></td>
                  <td><input type="password" name="user_pwd" value="" style="width:100px" maxlength="20"/></td>
                  <td><input type="text" name="user_name" value="<%= INPUT_VALUE( DBStr(rs,"user_name") ) %>" style="width:100px" maxlength="20"/></td>
                  <td><input type="checkbox" name="use_yn" value="Y" <%=( "Y".equals(DBStr(rs,"use_yn")) ) ? "checked" : ""%>/></td>
                  <td><button class="btn btn-inline btn-warning btn-xs" type="button" onclick="CheckModifyAdminUser(this.form);">수정</button></td>
                  <td><%=DBStr(rs,"write_id")%></td>
                  <td><%=DBStr(rs,"write_date")%></td>
                  <td><%=DBStr(rs,"update_id")%></td>
                  <td><%=DBStr(rs,"update_date")%></td>
                </tr>
                </form>
<%
		}
%>                
               </tbody>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
      </div>
      
      
	  <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">관리자 추가</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <form name="write_form" method="POST">
              <table class="table table-hover">
                <tbody><tr>
                  <th>ID</th>
                  <th>암호</th>
                  <th>이름</th>
                  <th>사용여부</th>
                  <th>등록</th>
                </tr>
                <tr height="25">
                    <td><input type="text" name="user_id" style="width:100px" maxlength="20"/></td>
                    <td><input type="password" name="user_pwd" style="width:100px" maxlength="20"/></td>
                    <td><input type="text" name="user_name" style="width:100px" maxlength="20"/></td>    
                    <td><input type="checkbox" name="use_yn" value="Y" checked class="dn"/></td>
                    <td><button class="btn btn-block btn-primary btn-xs" type="button" onclick="CheckWriteAdminUser();">등록</button></td>
                </tr>
                </tbody>
              </table>
              </form>
            </div>
          </div>
        </div>
      </div>

                
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