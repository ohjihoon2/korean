<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","컨텐츠 관리");
	pageContext.setAttribute("PageDescription","각종 컨텐츠 (최상단팝업/퀴즈배너/하단배너/푸터)를 등록/수정 할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","3");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>
<script>
	function DoWrite(a)
	{
		var f = document.aform;
		f.action="contents_form.jsp";
		f.gbn.value = a;
		f.submit();		
	}
	function onSearching(a){
		var f = document.aform;
		f.action="contents_list.jsp";
		f.search_txt.value = a;
		f.submit();	
	}
	function DoSearch()
	{
		var f = document.aform;
		f.action="contents_list.jsp";
		f.submit();	
	}
	
	function GoPage(pidx)
	{
		var f = document.aform;
		f.action="contents_list.jsp";		
		f.cpage.value = pidx;
		f.submit();
	}

	function GoView(pidx)
	{
		var f = document.aform;
		f.action="contents_form.jsp";
		f.cmd.value="modify";
		f.idx.value = pidx;
		f.submit();
	}

	function GoDetail(pidx)
	{
		var f = document.aform;
		f.action="contents_form.jsp";
		f.quiz_idx.value = pidx;
		f.submit();	
	} 


</script>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;
	String selected1 = "";
	String selected2 = "";
	String selected3 = "";
	String selected4 = "";
	String selected5 = "";
	String selected6 = "";
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
		if(search_txt.equals("") || search_txt.equals("null")) {
			sql = " SELECT count(1) AS cnt FROM NARO_CONTENTS WHERE del_yn='N'";		
			pstmt = con.prepareStatement( sql );			
		} else {
			sql = " SELECT count(1) AS cnt FROM NARO_CONTENTS WHERE del_yn='N' AND gbn = ? ";		
			pstmt = con.prepareStatement( sql );
			pstmt.setString(1, search_txt);
		}
		rs = pstmt.executeQuery();
		rs.next();
		int record_count = rs.getInt("cnt");		
		rs.close();
		pstmt.close();
		
		int max_page = (int)Math.ceil( (double)record_count / PAGE_SIZE ) ; 			//총 페이지 번호		
		/*------------------------------------------*/
		
		
		if(search_txt.equals("3-5")) { selected1 = "selected"; }
		else if(search_txt.equals("3-1")) { selected2 = "selected"; }
		else if(search_txt.equals("3-2")) { selected3 = "selected"; }
		else if(search_txt.equals("3-3")) { selected4 = "selected"; }
		else if(search_txt.equals("3-4")) { selected5 = "selected"; }
		else  { 
			selected6 = "selected"; 
		}
		
%>
<form name="aform" method="GET">
	<input type="hidden" name="cmd"/>    
	<input type="hidden" name="gbn"/>    
	<input type="hidden" name="idx"/>    
	<input type="hidden" name="quiz_idx"/>    
    <input type="hidden" name="cpage" value="<%=ncpage%>"/>
	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">목록</h3>
				
              <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 700px;">
				  <select class = "form-control" id="search_txt" name="search_txt" onchange="onSearching(this.value)">
					<option value="" <%=selected6%>>전체보기</option>
					<option value="3-5" <%=selected1%>>최상 단팝업 배너</option>
					<option value="3-1" <%=selected2%>>퀴즈 배너</option>
					<option value="3-2" <%=selected3%>>메인 상당배너 등록</option>
					<option value="3-3" <%=selected4%>>메인 하단배너 등록</option>
					<option value="3-4" <%=selected5%>>푸터</option>
				  </select>
                  <!--<input name="search_txt" class="form-control pull-right" type="text" placeholder="Search" value="<%=INPUT_VALUE(search_txt)%>">-->
                  <div class="input-group-btn">
                    <!--<button class="btn btn-default" type="button" onclick="DoSearch();"><i class="fa fa-search"></i></button>-->                    
                    <button class="btn btn-inline btn-primary btn-xs" style="margin-left:40px" type="button" onclick="DoWrite('3-5');">최상단팝업배너 등록</button>
					<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="DoWrite('3-1');">퀴즈배너 등록</button>
					<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="DoWrite('3-2');">메인 상당배너 등록</button>
					<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="DoWrite('3-3');">메인 하단배너 등록</button>
					<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="DoWrite('3-4');">푸터 등록</button>
                  </div>                  
                </div>                
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
                  <th>No</th>
                  <th>구분</th>
                  <th>Open</th>
                  <th>Command</th>
                  <th>writer</th>
                  <th>Write Date</th>
                </tr>
<%
			if(search_txt.equals("") || search_txt.equals("null")) {
				sql =" 	SELECT "
					+"		a.idx, a.gbn, a.contents, a.open_yn, a.del_yn, a.open_start_datetime, a.open_end_datetime, a.write_date, a.write_id "
					+"	FROM "
					+"		NARO_CONTENTS a "
					+"	WHERE "
					+"		a.del_yn='N' "
					+"	ORDER BY a.gbn,a.idx DESC LIMIT ? , ? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setInt(1,limit_offset);
				pstmt.setInt(2,PAGE_SIZE);	
			} else {	
				sql =" 	SELECT "
					+"		a.idx, a.gbn, a.contents, a.open_yn, a.del_yn, a.open_start_datetime, a.open_end_datetime, a.write_date, a.write_id "
					+"	FROM "
					+"		NARO_CONTENTS a "
					+"	WHERE "
					+"		a.del_yn='N' AND a.gbn = ? "
					+"	ORDER BY a.gbn,a.idx DESC LIMIT ? , ? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setString(1, search_txt);				
				pstmt.setInt(2,limit_offset);
				pstmt.setInt(3,PAGE_SIZE);
			}
				rs = pstmt.executeQuery(); 
				
				for( int i=1; rs.next(); i++ ) {
					String gbn_txt = DBStr(rs,"gbn");
					String gbn_show = "";
					if(gbn_txt.equals("3-5")) { gbn_show = "최상단팝업배너"; }
					else if(gbn_txt.equals("3-1")) { gbn_show = "퀴즈배너"; }
					else if(gbn_txt.equals("3-2")) { gbn_show = "메인 상당배너 등록"; }
					else if(gbn_txt.equals("3-3")) { gbn_show = "메인 하단배너 등록"; }
					else if(gbn_txt.equals("3-4")) { gbn_show = "푸터"; }
					else  { gbn_show = "N"; }
%>                
                <tr>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=i%></a></td>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=gbn_show%></a></td>
                  <td><%=DBStr(rs,"open_yn")%> | 개시일:<%=DBStr(rs,"open_start_datetime")%> | 종료일:<%=DBStr(rs,"open_end_datetime")%></td>
                  <td>
                  	<button class="btn btn-inline btn-primary btn-xs" type="button" onclick="GoView('<%=DBStr(rs,"idx")%>');">상세보기</button>                  	
                  </td>
                  <td><%=DBStr(rs,"write_id")%></td>
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