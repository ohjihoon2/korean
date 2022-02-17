<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String gbn = REQParam(request.getParameter("gbn"));

	if( "5-1".equals(gbn)) {
		pageContext.setAttribute("PageHeader","쉼표, 마침표. 수신신청");
	} else if( "5-2".equals(gbn)) {
		pageContext.setAttribute("PageHeader","쉼표, 마침표. 수신거부");
	} else if( "5-3".equals(gbn)) {
		pageContext.setAttribute("PageHeader","새국어생황 수신신청");
	} else if( "5-4".equals(gbn)) {
		pageContext.setAttribute("PageHeader","새국어생황 수신신청");
	} else {
		pageContext.setAttribute("PageHeader","소식지 수신 신청/거부");
	}
	pageContext.setAttribute("PageDescription","소식지 수신 신청/거부 접수 내역을 확인할 수 있습니다.");
	pageContext.setAttribute("PageMenuID",gbn);
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>
<script>
	function DoSearch()
	{
		var f = document.aform;
		f.action="reception_list.jsp";
		f.submit();	
	}
	
	function GoPage(pidx)
	{
		var f = document.aform;
		f.action="reception_list.jsp";		
		f.cpage.value = pidx;
		f.submit();
	}

	function ChangeConformYn(pidx, confirm_yn)
	{
		if( !confirm("확인 상태를 변경 하시겠습니까?")) return;

		var f = document.aform;
		f.action="reception_pro.jsp";		
		f.cmd.value="change_confirm";
		f.idx.value = pidx;
		f.confirm_yn.value = confirm_yn;
		f.submit();
	}

	function DoDelete(pidx)
	{
		if( !confirm("삭제를 하시겠습니까?")) return;

		var f = document.aform;
		f.action="reception_pro.jsp";		
		f.cmd.value="remove";
		f.idx.value = pidx;
		f.submit();
	}
</script>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;
	try{

		String search_txt = REQParam(request.getParameter("search_txt"));

		/***************** PAGE 관련 ***************/
		// 시작위치 offset ( 페이지 - 1 ) * 페이즈 글수
		int PAGE_SIZE = 20; //한페이지당 글수
		
		String str_cpage = REQParam(request.getParameter("cpage"));
		if(!IsValid(str_cpage)) { str_cpage="1"; }
		int ncpage = Integer.parseInt(str_cpage);
		
		int limit_offset = ( ncpage - 1 ) * PAGE_SIZE;
				
		//전체 글수
		sql = " SELECT count(1) AS cnt FROM NARO_RECEPTION a "
			+ " WHERE a.del_yn='N' AND a.gbn=? AND ( a.name LIKE ? OR a.email LIKE ? ) ";		
		pstmt = con.prepareStatement( sql );
		pstmt.setString(1, gbn);
		pstmt.setString(2, "%"+search_txt+"%");
		pstmt.setString(3, "%"+search_txt+"%");
		rs = pstmt.executeQuery();
		rs.next();
		int record_count = rs.getInt("cnt");		
		rs.close();
		pstmt.close();
		
		int max_page = (int)Math.ceil( (double)record_count / PAGE_SIZE ) ; 			//총 페이지 번호		
		/*------------------------------------------*/

%>
<form name="aform" method="GET">
	<input type="hidden" name="gbn" value="<%=gbn%>"/>   
	<input type="hidden" name="cmd"/>    
	<input type="hidden" name="idx"/>    
	<input type="hidden" name="confirm_yn"/>    
    <input type="hidden" name="cpage" value="<%=ncpage%>"/>
	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">목록</h3>
				
              <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 280px;">
                  <input name="search_txt" class="form-control pull-right" type="text" placeholder="Name or Email " value="<%=INPUT_VALUE(search_txt)%>">
                  <div class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="DoSearch();"><i class="fa fa-search"></i></button>                                        
                  </div>                  
                </div>                
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
                  <th>No</th>
                  <th>Check 1</th>
                  <th>Check 2</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Zip Cd.</th>                                    
                  <th>Address</th>
                  <th>Confirm Y/N</th>
                  <th>Command</th>
                  <th>write IP</th>
                  <th>Write Date</th>
                </tr>
<%
				sql =" 	SELECT "
					+"		a.idx, a.check1, a.check2, a.name, a.email, a.post, a.address, a.confirm_yn, a.write_ip, a.write_date "					
					+"	FROM "
					+"		NARO_RECEPTION a "
					+"	WHERE "
					+"		a.del_yn='N' AND a.gbn=? AND ( a.name LIKE ? OR a.email LIKE ? ) "
					+"	ORDER BY a.idx DESC LIMIT ? , ? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setString(1, gbn);
				pstmt.setString(2, "%"+search_txt+"%");
				pstmt.setString(3, "%"+search_txt+"%");
				pstmt.setInt(4,limit_offset);
				pstmt.setInt(5,PAGE_SIZE);

				rs = pstmt.executeQuery(); 
				
				for( int i=1; rs.next(); i++ ) {
%>                
                <tr>
                  <td><%=i%></td>                  
                  <td><%=DBStr(rs,"check1")%></td>
                  <td><%=DBStr(rs,"check2")%></td>
                  <td><%=DBStr(rs,"name")%></td>
                  <td><%=DBStr(rs,"email")%></td>
                  <td><%=DBStr(rs,"post")%></td>
                  <td><%=DBStr(rs,"address")%></td>
                  <td>
                  	<% if( "Y".equals(DBStr(rs,"confirm_yn")) ) { %>
                  		<button class="btn btn-inline btn-default btn-xs" type="button" onclick="ChangeConformYn('<%=DBInt(rs,"idx")%>','N');">확인</button>
                  	<% } else { %>
                  		<button class="btn btn-inline btn-warning btn-xs" type="button" onclick="ChangeConformYn('<%=DBInt(rs,"idx")%>','Y');">미확인</button>
                  	<% } %>
                  </td>
                  <td>                  	              		
              		<button class="btn btn-inline btn-danger btn-xs" type="button" onclick="DoDelete('<%=DBInt(rs,"idx")%>');">삭제</button>              	
                  </td>
                  <td><%=DBStr(rs,"write_ip")%></td>
                  <td><%=DBStr(rs,"write_date")%></td>
                </tr>
<%
				}
%>                
              </tbody></table>
            </div>
            <!-- /.box-body -->
            <div class="box-footer clearfix">
            	<%=ncpage%>/<%=max_page%> page(s)
            	<%
	                int start_page = (int)((ncpage-1)/10) * 10 + 1;		//페이지 리스트의 시작  페이지 번호
	                int end_page = start_page + 9;
	                if( end_page > max_page ) { end_page = max_page; }	//페이지 리스트의 마지막  페이지 번호
	                
	                boolean is_prev_pagelist = ( start_page >= 10 );
	                boolean is_next_pagelist = ( end_page < max_page );
            	%>
              <ul class="pagination pagination-sm no-margin pull-right">
                <li class="paginate_button <% if(!is_prev_pagelist) { %>disabled<% } %>"><a href="javascript:GoPage('<%=(start_page-1)%>');">이전</a></li>
                <% for( int i=start_page; i<=end_page; i++) { %>
                <li class="paginate_button <% if( ncpage == i ) { %>active<% } %>"><a href="javascript:GoPage('<%=i%>');"><%=i%></a></li>
                <% } %>
                <li class="paginate_button <% if(!is_next_pagelist) { %>disabled<% } %>"><a href="javascript:GoPage('<%=(end_page+1)%>');">다음</a></li>
              </ul>
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
		if( rs!= null) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="../../include/bottom.jsp" %>
<%@ include file="/_common/dbclose.jsp" %>