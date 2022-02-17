<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","게시글 관리");
	pageContext.setAttribute("PageDescription","게시글 등록 및 수정할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","2-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>
<script>
	function DoWrite()
	{
		var f = document.aform;
		f.action="news_form.jsp";
		f.cmd.value="write";
		f.submit();		
	}
	
	function DoSearch()
	{
		var f = document.aform;
		f.action="news_list.jsp";
		f.submit();	
	}
	
	function GoPage(pidx)
	{
		var f = document.aform;
		f.action="news_list.jsp";		
		f.cpage.value = pidx;
		f.submit();
	}

	function GoView(pidx)
	{
		var f = document.aform;
		f.action="news_form.jsp";
		f.cmd.value="modify";
		f.idx.value = pidx;
		f.submit();
	}

	function GoPreview(pidx)
	{	
		var data = "http://<%=request.getServerName()%><%="220.120.99.66".equals(request.getServerName())?":88":""%>/view.jsp?idx="+pidx+"&preview=Y";

		if( document.all ) {
			window.clipboardData.setData("Text",data);
	    	alert("클립보드에 미리보기 주소가 복사되었습니다. 새창을 열어 주소를 붙여넣어 주세요.");
	    } else {
	    	prompt("이 글의 미리보기 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", data); 
	    }
	}

	function DoOpen(pidx)
	{
		if( !confirm("게시 하시겠습니까?") ) return;

		var f = document.aform;
		f.action="news_form_pro2.jsp";
		f.cmd.value="open_yn";
		f.idx.value = pidx;
		f.open_yn.value="Y";
		f.submit();
	}

	function DoClose(pidx)
	{
		if( !confirm("게시 중지 하시겠습니까?") ) return;

		var f = document.aform;
		f.action="news_form_pro2.jsp";
		f.cmd.value="open_yn";
		f.idx.value = pidx;
		f.open_yn.value="N";
		f.submit();
	}	

	function onCate1Change(cate1_idx, cate2_idx)
	{		
		if( cate1_idx == null || cate1_idx == "" || cate1_idx == undefined ) {
			$("#category_idx").html("");				 
			$("#category_idx").append("<option value=''>:: 카테고리 2 선택 ::</option>");
		} else {
			$.get("ajax/cate2_list.jsp?parent_idx="+cate1_idx, function(data) {
				 $("#category_idx").html("");				 
				 $("#category_idx").append("<option value=''>:: 카테고리 2 선택 ::</option>");
				 $("#category_idx").append(data);
				 if( cate2_idx != undefined && cate2_idx != null ) {				 
				 	$("#category_idx").val(cate2_idx );
				 } else {
				 	$("#category_idx").focus();
				 }
			});
		}
	}
</script>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;
	int paramcnt=0;
	try{

		String search_txt = REQParam(request.getParameter("search_txt"));
		String category1 = REQParam(request.getParameter("category1"));
		String category_idx = REQParam(request.getParameter("category_idx"));

		/***************** PAGE 관련 ***************/
		// 시작위치 offset ( 페이지 - 1 ) * 페이즈 글수
		int PAGE_SIZE = 20; //한페이지당 글수
		
		String str_cpage = REQParam(request.getParameter("cpage"));
		if(!IsValid(str_cpage)) { str_cpage="1"; }
		int ncpage = Integer.parseInt(str_cpage);
		
		int limit_offset = ( ncpage - 1 ) * PAGE_SIZE;
				
		//전체 글수
		sql = " SELECT count(1) AS cnt FROM NARO_NEWS a "
			+ "		LEFT OUTER JOIN ( "
			+"			SELECT idx, parent_idx, name, ( SELECT name FROM NARO_NEWS_CATEGORY z WHERE z.lvl=1 AND z.idx=x.parent_idx ) AS pname FROM NARO_NEWS_CATEGORY x WHERE x.lvl=2 "
			+"		) b ON a.category_idx = b.idx "
			+ "WHERE a.del_yn='N' AND ( a.title LIKE ? OR b.name LIKE ? ) ";		
		if( IsValid(category1) ) {
			sql += " AND b.parent_idx=? ";
		}
		if( IsValid(category_idx) ) {
			sql += " AND b.idx=? ";
		}
		paramcnt=1;
		pstmt = con.prepareStatement( sql );
		pstmt.setString(paramcnt++, "%"+search_txt+"%");
		pstmt.setString(paramcnt++, "%"+search_txt+"%");
		if( IsValid(category1) ) {
			pstmt.setString(paramcnt++, category1);
		}
		if( IsValid(category_idx) ) {
			pstmt.setString(paramcnt++, category_idx);
		}
		rs = pstmt.executeQuery();
		rs.next();
		int record_count = rs.getInt("cnt");		
		rs.close();
		pstmt.close();
		
		int max_page = (int)Math.ceil( (double)record_count / PAGE_SIZE ) ; 			//총 페이지 번호		
		/*------------------------------------------*/


		///////////////////// 카테고리 1차 정보 가져오기 //////////////////////////
		sql	=" SELECT idx, name FROM NARO_NEWS_CATEGORY WHERE del_yn='N' AND lvl=1 ORDER BY sort_order ";
		pstmt = con.prepareStatement( sql );
		rs = pstmt.executeQuery();
		ArrayList listCate1 = new ArrayList();
		while( rs.next() ) {
			listCate1.add( new String[]{ DBStr(rs,"idx"), DBStr(rs,"name") } );	
		}
		rs.close();
		pstmt.close();

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
			  <div style="display:inline; margin-left: 200px">
              	<select id="category1" name="category1"  onchange="onCate1Change(this.value);">
                    <option value="">:: 카테고리 1 선택 ::</option>
                    <% 
                    	for( int i=0; i<listCate1.size(); i++ ) { 
                    		String[] cateitem = (String[])listCate1.get(i); 
                    %>
                    <option value="<%=cateitem[0]%>" <% if(category1.equals(cateitem[0])) { %>selected<% } %>><%=cateitem[1]%></option>
                    <% 
                    	} 
                    %>
                </select>                
                <select id="category_idx" name="category_idx">                    
                	<option value="">:: 카테고리 2 선택 ::</option>
                </select>
                <button class="btn btn-default btn-xs" type="button" onclick="DoSearch();">검색</button>                    
              </div>

              <div class="box-tools">              	              	
                <div class="input-group input-group-sm" style="width: 280px;">                
                  <input name="search_txt" class="form-control pull-right" type="text" placeholder="Title or Category level2 name " value="<%=INPUT_VALUE(search_txt)%>">
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
                  <th>Title</th>                  
                  <th>Category</th>
                  <th>Banner</th>                                    
                  <th>Read.</th>
                  <%--
                  <th>writer</th>
                  <th>Write Date</th>
                  --%>
                </tr>
<%
				sql =" 	SELECT "
					+"		a.idx, a.title, a.category_idx, a.write_id, a.write_date, b.name AS cate2_name, b.pname AS cate1_name, a.read_count, a.banner_yn "
					+"		, a.open_yn, a.open_start_datetime, a.open_end_datetime "
					+"	FROM "
					+"		NARO_NEWS a "
					+"		LEFT OUTER JOIN ( "
					+"			SELECT idx, parent_idx, name, ( SELECT name FROM NARO_NEWS_CATEGORY z WHERE z.lvl=1 AND z.idx=x.parent_idx ) AS pname FROM NARO_NEWS_CATEGORY x WHERE x.lvl=2 "
					+"		) b ON a.category_idx = b.idx "
					+"	WHERE "
					+"		a.del_yn='N' AND ( a.title LIKE ? OR b.name LIKE ? ) ";
				if( IsValid(category1) ) {
					sql += " AND b.parent_idx=? ";
				}
				if( IsValid(category_idx) ) {
					sql += " AND b.idx=? ";
				}
				sql+="	ORDER BY a.idx DESC LIMIT ? , ? ";
				paramcnt=1;
				pstmt = con.prepareStatement( sql );
				pstmt.setString(paramcnt++, "%"+search_txt+"%");				
				pstmt.setString(paramcnt++, "%"+search_txt+"%");				
				if( IsValid(category1) ) {
					pstmt.setString(paramcnt++, category1);
				}
				if( IsValid(category_idx) ) {
					pstmt.setString(paramcnt++, category_idx);
				}
				pstmt.setInt(paramcnt++,limit_offset);
				pstmt.setInt(paramcnt++,PAGE_SIZE);

				rs = pstmt.executeQuery(); 
				
				for( int i=1; rs.next(); i++ ) {
%>                
                <tr>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=i%></a></td>
                  <td>
                  	<a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=DBStr(rs,"title")%></a>
                  	&nbsp;<a href="javascript:GoPreview('<%=DBStr(rs,"idx")%>');"><i class="fa fa-search"></i></a><br>
                  	<p>
                  		<small>
                  			게시여부: <strong><%=DBStr(rs,"open_yn")%></strong>&nbsp;-
                  			<% if( "Y".equals( DBStr(rs,"open_yn") ) ){ %> 
                  				<a href="javascript:DoClose('<%=DBStr(rs,"idx")%>');"><small>[게시 중지]</small></a>
                  			<% } else { %>
                  				<a href="javascript:DoOpen('<%=DBStr(rs,"idx")%>');" style="color:#ff0000"><small>[게시]</small></a>
                  			<% } %>
	                  		<% if(IsValid(DBStr(rs,"open_start_datetime"))){%><br>개시 시작 일시 :<%=DBStr(rs,"open_start_datetime")%><% } %>
	                  		<% if(IsValid(DBStr(rs,"open_end_datetime"))){%><br>개시 종료 일시 :<%=DBStr(rs,"open_end_datetime")%><% } %>
                  		</small>
                  	</p>
                  </td>                  
                  <td><%=DBStr(rs,"cate1_name")%> > <%=DBStr(rs,"cate2_name")%></td>
                  <td><%=DBStr(rs,"banner_yn")%></td>                  
                  <td><%=DBStr(rs,"read_count")%></td>
                  <%--
                  <td><%=DBStr(rs,"write_id")%></td>
                  <td><%=DBStr(rs,"write_date")%></td>
                  --%>
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

<script>
	$(function () {		
	    //Categroy Load
	    <% if( IsValid(category1) ) { %>
	    	$('#category1').val('<%=category1%>');
	    	onCate1Change('<%=category1%>', '<%=category_idx%>');
	    <% } %>
	});
</script>
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