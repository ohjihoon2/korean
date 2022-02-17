<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","우리말 달인 관리");
	pageContext.setAttribute("PageDescription","우리말 달인 등록 및 수정할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","4-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>
<script>
	function DoWrite()
	{
		var f = document.aform;
		f.action="quiz_form.jsp";
		f.cmd.value="write";
		f.submit();		
	}
	
	function DoSearch()
	{
		var f = document.aform;
		f.action="quiz_list.jsp";
		f.submit();	
	}
	
	function GoPage(pidx)
	{
		var f = document.aform;
		f.action="quiz_list.jsp";
		f.cpage.value = pidx;
		f.submit();
	}

	function GoView(pidx)
	{
		var f = document.aform;
		f.action="quiz_form.jsp";
		f.cmd.value="modify";
		f.idx.value = pidx;
		f.submit();
	}

	function GoDetail(pidx)
	{
		var f = document.aform;
		f.action="quiz_detail.jsp";
		f.quiz_idx.value = pidx;
		f.submit();	
	} 

	function GoPreview(pidx)
	{
		var data = "http://<%=request.getServerName()%><%="220.120.99.66".equals(request.getServerName())?":88":""%>/quiz.jsp?idx="+pidx+"&preview=Y";

		if( document.all ) {
			window.clipboardData.setData("Text",data);
			alert("클립보드에 미리보기 주소가 복사되었습니다. 새창을 열어 주소를 붙여넣어 주세요.");
		} else {
			prompt("이 글의 미리보기 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", data);
		}
	}

	function GoApplyList(pidx)
	{
		var f = document.aform;
		f.action="quiz_apply_list.jsp";
		f.quiz_idx.value = pidx;
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
		sql = " SELECT count(1) AS cnt FROM NARO_QUIZ WHERE del_yn='N' AND title LIKE ? ";		
		pstmt = con.prepareStatement( sql );
		pstmt.setString(1, "%"+search_txt+"%");
		rs = pstmt.executeQuery();
		rs.next();
		int record_count = rs.getInt("cnt");		
		rs.close();
		pstmt.close();
		
		int max_page = (int)Math.ceil( (double)record_count / PAGE_SIZE ) ; 			//총 페이지 번호		
		/*------------------------------------------*/

%>
<form name="aform" method="GET">
	<input type="hidden" name="cmd"/>    
	<input type="hidden" name="idx"/>    
	<input type="hidden" name="quiz_idx"/>    
    <input type="hidden" name="cpage" value="<%=ncpage%>"/>
	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">목록</h3>
				
              <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 280px;">
                  <input name="search_txt" class="form-control pull-right" type="text" placeholder="Search" value="<%=INPUT_VALUE(search_txt)%>">
                  <div class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="DoSearch();"><i class="fa fa-search"></i></button>                    
                    <button class="btn btn-inline btn-primary btn-xs" style="margin-left:40px" type="button" onclick="DoWrite();">추가</button>
                  </div>                  
                </div>                
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
                  <th>No</th>
                  <th>Month</th>
                  <th>Open</th>
                  <th>Command</th>
                  <th>writer</th>
                  <th>Write Date</th>
                </tr>
<%
				sql =" 	SELECT "
					+"		a.idx, a.ym, a.title, a.write_id, a.write_date, a.open_yn, a.open_start_datetime, a.open_end_datetime "
					+"	FROM "
					+"		NARO_QUIZ a "
					+"	WHERE "
					+"		a.del_yn='N' AND a.title LIKE ? "
					+"	ORDER BY a.idx DESC LIMIT ? , ? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setString(1, "%"+search_txt+"%");				
				pstmt.setInt(2,limit_offset);
				pstmt.setInt(3,PAGE_SIZE);

				rs = pstmt.executeQuery(); 
				
				for( int i=1; rs.next(); i++ ) {
%>                
                <tr>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=i%></a></td>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=DBStr(rs,"ym")%></a></td>
                  <td><%=DBStr(rs,"open_yn")%> | start dt:<%=DBStr(rs,"open_start_datetime")%> | end dt:<%=DBStr(rs,"open_end_datetime")%></td>
                  <td>
                  	<button class="btn btn-inline btn-primary btn-xs" type="button" onclick="GoDetail('<%=DBInt(rs, "idx")%>');">상세보기</button>
                  	<button class="btn btn-inline btn-success btn-xs" type="button" onclick="GoPreview('<%=DBInt(rs, "idx")%>');">미리보기</button>
                  	<button class="btn btn-inline btn-danger btn-xs" type="button" onclick="GoApplyList('<%=DBInt(rs, "idx")%>');">응답자</button>
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