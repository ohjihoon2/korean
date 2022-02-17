<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","미디어 관리");
	pageContext.setAttribute("PageDescription","이미지, 동영상 등의 파일을 대량 업로드 할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","6-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>

<script src="/_js/common.js"></script>
<script>
	function DoSearch()
	{
		var f = document.aform;
		f.action="media_list.jsp";
		f.submit();	
	}
	
	function DoDelete( idx ) {
		if( !confirm("해당 미디어를 삭제하시겠습니까?" ) ) return;
		
		var f = document.aform;
		f.action="media_pro.jsp";
		f.cmd.value = "remove";		
		f.idx.value = idx;
		f.submit();
	}

	function GoPage( pidx ) 
	{
		var f = document.aform;
		f.cpage.value=pidx;
		f.action="media_list.jsp";
		f.submit();		
	}
</script>		

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql="";
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
		sql = " SELECT count(1) AS cnt FROM NARO_MEDIA a "
			+ " WHERE a.del_yn='N' AND ( a.url LIKE ? ) ";		
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
<p>파일을 여러개 선택할 수 있습니다.</p>
<div class="row">
	<div class="col-xs-8">		
		<form name="upload_form" action="media_upload.jsp" method="POST" enctype="multipart/form-data">
			<input type="file" name="attach_file" multiple style="width:100%"/>
		</form>
	</div>		
	<div class="col-xs-">
		<button class="btn btn-inline btn-primary" type="button" onclick="DoFileUpload();">Upload</button>     
	</div>
</div>	

<script src="/_js/common.js"></script>
<script>
	function DoFileUpload()
	{
		var f = document.upload_form;
		if(CheckEmpty(f.attach_file,"파일을 선택해주세요.")) return;
		f.submit();
	}

	function DoRemoveFile(pidx)
	{
		if( !confirm("해당 파일을 삭제하시게습니까?") ) return;
		var f = document.aform;
		f.action="media_pro.php";
		f.cmd.value="remove";
		f.idx.value = pidx;
		f.submit();
	}
</script>
<hr>

<form name="aform" method="GET">
	<input type="hidden" name="cmd" value=""/>
	<input type="hidden" name="idx" value=""/>
	<input type="hidden" name="cpage" value="<%=ncpage%>"/>


	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">미디어 목록</h3>

			
              <div class="box-tools">
                <div class="input-group input-group-sm" style="width: 280px;">
                  <input name="search_txt" class="form-control pull-right" type="text" placeholder="URL " value="<%=INPUT_VALUE(search_txt)%>">
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
                  <th>FileName</th>
                  <th>URL</th>
                  <th>Path</th>
                  <th>Command</th>
                  <th>Write ID</th>
                  <th>Write Date</th>                  
                </tr>
                <%
					sql =" 	SELECT a.* "						
						+"	FROM NARO_MEDIA a "
						+"	WHERE a.del_yn='N' AND ( a.url LIKE ? ) "
						+"	ORDER BY a.idx DESC LIMIT ? , ? ";
					pstmt = con.prepareStatement( sql );					
					pstmt.setString(1, "%"+search_txt+"%");
					pstmt.setInt(2,limit_offset);
					pstmt.setInt(3,PAGE_SIZE);

					rs = pstmt.executeQuery(); 
					
					for( int i=1; rs.next(); i++ ) {
				%>
                <tr>
                  <td><%=i%></td>
                  <td><%=DBStr(rs, "filename")%></td>                  
                  <td>http://<%=request.getServerName()%><%=DBStr(rs, "url")%></td>                  
                  <td><%=DBStr(rs, "path")%></td>                  
                  <td><button class="btn btn-inline btn-danger btn-xs" type="button" onclick="DoDelete('<%=DBInt(rs,"idx")%>');">삭제</button>              	</td>
                  <td><%=DBStr(rs, "write_id")%></td>
                  <td><%=DBStr(rs, "write_date")%></td>
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
		out.println("오류가 발생되었습니다. 다시 시도해주세요" + ex);		
	} finally {
		if( rs != null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>

<%@ include file="../../include/bottom.jsp" %>
<%@ include file="/_common/dbclose.jsp" %>