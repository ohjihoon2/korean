<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","설문");
	pageContext.setAttribute("PageDescription","2016년 11월 우리말 다듬기 설문 응답내역을 조회할 수 있습니다. ( 설문입력 페이지 http://"+request.getServerName()+"/survey/201611.html )");
	pageContext.setAttribute("PageMenuID","7-3");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>
<script>
	function DoSearch()
	{
		var f = document.aform;
		f.action="survey201611.jsp";
		f.submit();
	}

	function GoPage(pidx)
	{
		var f = document.aform;
		f.action="survey201611.jsp";
		f.cpage.value = pidx;
		f.submit();
	}

	function DoownLoadExcel()
	{
		var f = document.aform;
		f.action="survey201611_excel.jsp";
		f.submit();
	}
</script>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;
	int paramcnt=0;
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
		sql = " SELECT count(1) AS cnt FROM NARO_SURVEY201611 a "
			+ " WHERE a.del_yn='N' AND a.name LIKE ? ";
		paramcnt=1;
		pstmt = con.prepareStatement( sql );
		pstmt.setString(paramcnt++, "%"+search_txt+"%");
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
    <input type="hidden" name="cpage" value="<%=ncpage%>"/>
    <input type="hidden" name="open_yn"/>
	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">게시글 목록</h3>

              <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 280px;">
                  <input name="search_txt" class="form-control pull-right" type="text" placeholder="name " value="<%=INPUT_VALUE(search_txt)%>">
                  <div class="input-group-btn">
                    <button class="btn btn-default" type="button" onclick="DoSearch();"><i class="fa fa-search"></i></button>
                    <button class="btn btn-inline btn-success btn-xs" style="margin-left:40px" type="button" onclick="DoownLoadExcel();">Excel 다운로드</button>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding" style="overflow:auto">
              <table class="table table-hover">
                <tbody><tr>
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
                  <th>write ip</th>
                  <th>Write Date</th>
                </tr>
<%
				sql =" 	SELECT "
					+"		a.idx, a.q01, a.q02, a.q03, a.q04, a.q05, a.q06, a.q07, a.q08, a.name, a.write_ip, a.write_date "
					+"	FROM "
					+"		NARO_SURVEY201611 a "
					+"	WHERE "
					+"		a.del_yn='N' AND a.name LIKE ? ";
				sql+="	ORDER BY a.idx DESC LIMIT ? , ? ";
				paramcnt=1;
				pstmt = con.prepareStatement( sql );
				pstmt.setString(paramcnt++, "%"+search_txt+"%");
				pstmt.setInt(paramcnt++,limit_offset);
				pstmt.setInt(paramcnt++,PAGE_SIZE);

				rs = pstmt.executeQuery();

				for( int i=1; rs.next(); i++ ) {
%>
                <tr>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=i%></a></td>
                  <td><%=DBStr(rs,"q01")%></td>
                  <td><%=DBStr(rs,"q02")%></td>
                  <td><%=DBStr(rs,"q03")%></td>
                  <td><%=DBStr(rs,"q04")%></td>
                  <td><%=DBStr(rs,"q05")%></td>
                  <td><%=DBStr(rs,"q06")%></td>
                  <td><%=DBStr(rs,"q07")%></td>
                  <td><%=DBStr(rs,"q08")%></td>
                  <td><%=DBStr(rs,"name")%></td>
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
