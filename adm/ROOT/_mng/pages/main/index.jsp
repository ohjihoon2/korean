<%@ page import="java.util.Hashtable" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader", null);
	pageContext.setAttribute("PageDescription","관리자님 환영합니다!");
	pageContext.setAttribute("PageMenuID",null);
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>
<!-- Your Page Content Here -->
<script src="/_js/common.js"></script>

<script>
	function GoStatistics(stat) {
		var f = document.aform;
		f.statistics.value = stat;
		f.action="index.jsp";
		f.submit();
	}

	function DoSearch() {
		var f = document.aform;
		f.action="index.jsp";
		f.cpage.value = 1;
		f.submit();
	}

	function GoPage(pidx) {
		var f = document.aform;
		f.action="index.jsp";
		f.cpage.value = pidx;
		f.submit();
	}

</script>

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	try{

		String statistics = REQParam(request.getParameter("statistics"));
		String search_txt = REQParam(request.getParameter("search_txt"));

		/***************** PAGE 관련 ***************/
		// 시작위치 offset ( 페이지 - 1 ) * 페이즈 글수
		int PAGE_SIZE = 15; //한페이지당 글수

		String str_cpage = REQParam(request.getParameter("cpage"));
		if(!IsValid(str_cpage)) { str_cpage="1"; }
		int ncpage = Integer.parseInt(str_cpage);

		int limit_offset = ( ncpage - 1 ) * PAGE_SIZE;

		//전체 글수
		sql = " SELECT count(1) AS cnt FROM NARO_LOG_CONNECT_USER WHERE connect_ip LIKE ? ";
		pstmt = con.prepareStatement( sql );
		pstmt.setString(1, "%"+search_txt+"%");
		rs = pstmt.executeQuery();
		rs.next();
		int record_count = rs.getInt("cnt");
		rs.close();
		pstmt.close();

		int max_page = (int)Math.ceil( (double)record_count / PAGE_SIZE ) ; 			//총 페이지 번호
		/*------------------------------------------*/

		String data = new Hashtable();

		sql = "   SELECT COUNT(*) AS total_user "
				+"  FROM naro_log_connect_user "
				+" WHERE (connect_date BETWEEN '2022-02-15' AND '2022-02-23') ";
		pstmt = con.prepareStatement( sql );
//		pstmt.setString(1,idx);
		rs = pstmt.executeQuery();
		DBStr( rs, data.get("total") );

%>
<%= data.toString()%>
<form name="aform" method="GET">
	<input type="hidden" name="cmd"/>
	<input type="hidden" name="statistics" value="<%=statistics%>"/>
	<input type="hidden" name="idx"/>
	<input type="hidden" name="quiz_idx"/>
	<input type="hidden" name="cpage" value="<%=ncpage%>"/>
	<div class="cus-half">
		<%@ include file="statistics.jsp" %>
		<div>
			<div class="row">
				<div class="col-xs-12 cus-height">
					<div class="box" style="max-height: 100%;">
						<div class="box-header">
							<h3 class="box-title">기간별 게시글 조회</h3>

							<div class="box-tools">
								<div class="input-group input-group-sm" style="width: 280px;">
									<input name="search_txt" class="form-control pull-right" type="text" placeholder="IP Search" value="<%=INPUT_VALUE(search_txt)%>">
									<div class="input-group-btn">
										<button class="btn btn-default" type="button" onclick="DoSearch();"><i class="fa fa-search"></i></button>
									</div>
								</div>
							</div>
						</div>
						<!-- /.box-header -->
						<div class="box-body table-responsive no-padding">
							<table class="table table-hover text-center">
								<tbody>
								<tr>
									<th>순위</th>
									<th>게시물</th>
									<th>게시일</th>
									<th>기간 조회수</th>
								</tr>
								<%
									sql =" 	  SELECT "
											+"		a.news_idx, c.name, b.title, DATE_FORMAT(b.write_date, '%Y-%m-%d %H:%m:%s') as write_date, SUM(view_count) AS view_count "
											+"	FROM "
											+"		naro_news_view_count a "
											+" INNER JOIN "
											+"		naro_news b ON a.news_idx = b.idx "
											+" INNER JOIN "
											+"		naro_news_category c ON c.idx = B.category_idx"
											+"	WHERE "
											+"		(dt BETWEEN '2022-02-15' AND '2022-02-23') "
											+"	GROUP BY news_idx, name, title "
											+"		ORDER BY view_count DESC LIMIT 7 ";
									pstmt = con.prepareStatement( sql );
//									pstmt.setString(1, "%"+search_txt+"%");
//									pstmt.setInt(2,limit_offset);
//									pstmt.setInt(3,PAGE_SIZE);

									rs = pstmt.executeQuery();
								%>

								<%
									for( int i=1; rs.next(); i++ ) {
								%>
								<tr>
									<td><%=i%></td>
									<td class="text-left"><%=DBStr(rs,"title")%></td>
									<td><%=DBStr(rs,"write_date")%></td>
									<td><%=DBStr(rs,"view_count")%></td>
								</tr>
								<%
									}
								%>
								</tbody>
							</table>
						</div>
						<!-- /.box-body -->
						<div class="box-footer clearfix">
							기간 총 접속자 수 : 기간 총 조회수 : 기간 방문당 조회 수 :
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-12 cus-height">
					<div class="box" style="max-height: 100%;">
						<div class="box-header">
							<h3 class="box-title">방문기록</h3>

							<div class="box-tools">
								<div class="input-group input-group-sm" style="width: 280px;">
									<input name="search_txt" class="form-control pull-right" type="text" placeholder="IP Search" value="<%=INPUT_VALUE(search_txt)%>">
									<div class="input-group-btn">
										<button class="btn btn-default" type="button" onclick="DoSearch();"><i class="fa fa-search"></i></button>
									</div>
								</div>
							</div>
						</div>
						<!-- /.box-header -->
						<div class="box-body table-responsive no-padding">
							<table class="table table-hover text-center">
								<tbody>
								<tr>
									<th>IP</th>
									<th>OS</th>
									<th>Browser</th>
									<th>Date</th>
								</tr>
								<%
									sql =" 	SELECT "
											+"		idx, connect_os, DATE_FORMAT(connect_date, '%Y-%m-%d %H:%m:%s') as connect_date, connect_ip, connect_browser"
											+"	FROM "
											+"		NARO_LOG_CONNECT_USER "
											+"	WHERE "
											+"		connect_ip LIKE ? "
											+"	ORDER BY idx DESC LIMIT ? , ? ";
									pstmt = con.prepareStatement( sql );
									pstmt.setString(1, "%"+search_txt+"%");
									pstmt.setInt(2,limit_offset);
									pstmt.setInt(3,PAGE_SIZE);

									rs = pstmt.executeQuery();
								%>

								<%
									for( int i=1; rs.next(); i++ ) {
								%>
								<tr>
									<td><%=DBStr(rs,"connect_ip")%></td>
									<td><%=DBStr(rs,"connect_os")%></td>
									<td><%=DBStr(rs,"connect_browser")%></td>
									<td><%=DBStr(rs,"connect_date")%></td>
								</tr>
								<%
									}
								%>
								</tbody>
							</table>
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
				</div>
			</div>

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