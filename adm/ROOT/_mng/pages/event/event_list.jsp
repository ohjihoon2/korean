<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","이벤트 응모 현황");
	pageContext.setAttribute("PageDescription","이벤트 응모 현황 볼수 있습니다.");
	pageContext.setAttribute("PageMenuID","7-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>

<script src="/_js/common.js"></script>
<script>

	function GoPage(pidx)
	{
		var f = document.aform;
		f.action="event_list.jsp";		
		f.cpage.value = pidx;
		f.submit();
	}

	function GoList()
	{
		var f = document.aform;
		f.action="event_list.jsp";		
		f.submit();
	}

	function DoSaveExcel(pidx)
	{
		var f = document.aform;
		f.event_group_idx.value = pidx;
		f.action="event_excel.jsp";				
		f.submit();
	}
	
	$(document).ready(function(){
			    $('#selectbox').change(function(){
			        var idx =  $('#selectbox option:selected').val();
			        var url = "event_list.jsp?event_group_idx=" + idx;    
			        $(location).attr('href',url);
			    });
			    
	});
	
	function popupOpen(){
		var popUrl = "event_subject.jsp";	//팝업창에 출력될 페이지 URL
	    
		var popOption = "width=710, height=800, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
			window.open(popUrl,"",popOption);
	}
	
</script>


<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;

	int event_group_idx=1;
	try{ event_group_idx=Integer.parseInt(request.getParameter("event_group_idx")); } catch( NumberFormatException ex ){}

	try{
		
		/***************** PAGE 관련 ***************/
		// 시작위치 offset ( 페이지 - 1 ) * 페이즈 글수
		int PAGE_SIZE = 20; //한페이지당 글수
		
		String str_cpage = REQParam(request.getParameter("cpage"));
		if(!IsValid(str_cpage)) { str_cpage="1"; }
		int ncpage = Integer.parseInt(str_cpage);
		
		int limit_offset = ( ncpage - 1 ) * PAGE_SIZE;
				
		//전체 글수
		sql = " SELECT count(1) AS cnt FROM NARO_EVENT a WHERE a.event_group_idx=? ";		
		pstmt = con.prepareStatement( sql );
		pstmt.setInt(1, event_group_idx);		
		rs = pstmt.executeQuery();
		rs.next();
		int record_count = rs.getInt("cnt");		
		rs.close();
		pstmt.close();
		
		int max_page = (int)Math.ceil( (double)record_count / PAGE_SIZE ) ; 			//총 페이지 번호		
		/*------------------------------------------*/


		// 해당월 
		/**sql = " SELECT ym FROM NARO_QUIZ WHERE idx=? ";
		pstmt = con.prepareStatement( sql );				
		pstmt.setInt(1,event_group_idx);
		rs = pstmt.executeQuery();
		String ym="";
		if( rs.next() ){
			ym = rs.getString("ym");
		}
		rs.close();
		pstmt.close();
		**/
%>
<form name="aform" method="GET">
	<input type="hidden" name="event_group_idx" value="<%=event_group_idx%>"/>    
	<input type="hidden" name="cpage" value="<%=ncpage%>"/>
	<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <h3 class="box-title">응답자 목록</h3>
				
              <div class="box-tools">
              <a href="javascript:popupOpen()">이벤트 등록 현황</a>
              	<select id="selectbox">
              	<%
              		sql = "select * from FZST_EVENT_SUBJECT where del_yn=?";
              		pstmt = con.prepareStatement(sql);
              		pstmt.setString(1, "N");
              		rs = pstmt.executeQuery();
              		for (int i=1; rs.next(); i++) {
              			int idx = Integer.parseInt(DBStr(rs, "idx"));
              	%>
              		<option value="<%=idx%>" <% if(event_group_idx == idx) {%> selected <% } %>><%=rs.getString("event_title")%>
              	<%
              		}
              		rs.close();
              		pstmt.close();
              	%>
              	</select>
                    <button class="btn btn-inline btn-primary btn-xs" type="button" onclick="DoSaveExcel(<%=event_group_idx%>);">엑셀저장</button>                    
                    <button class="btn btn-inline btn-warning btn-xs" type="button" onclick="GoList();">뒤로</button>                    
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
                  <th>No</th>
                  <th>Name</th>
                  <th>Phone</th>
                  <th>Email</th>
				  <th>Agree</th>
                  <th>Write Date</th>
				  <th>Contents</th>
				  <th>img</th>
                </tr>
<%
				sql =" 	SELECT * FROM NARO_EVENT a WHERE a.event_group_idx=? "	
					+"	ORDER BY a.idx DESC LIMIT ? , ? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setInt(1, event_group_idx);		
				pstmt.setInt(2,limit_offset);
				pstmt.setInt(3,PAGE_SIZE);

				rs = pstmt.executeQuery(); 
				
				for( int i=1; rs.next(); i++ ) {
%>                
                <tr>
                  <td><%=i%></td>
                  <td><%=DBStr(rs,"user_name")%></td>
                  <td><%=DBStr(rs,"user_hp")%></td>                  
                  <td><%=DBStr(rs,"user_email")%></td>                  
				  <td><%=DBStr(rs,"agree_yn")%></td>  
                  <td><%=DBStr(rs,"write_date")%></td>                  
				  <td><%=DBStr(rs,"contents")%></td>
				  <% String img = DBStr(rs,"img_dir"); %> 
				  <td><a href="event_img.jsp?img=<%=img%>"><%=img%></a></td> 
                </tr>
<%
				}
%>                
              </tbody></table>
            </div>
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
		if( rs != null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="../../include/bottom.jsp" %>
<%@ include file="/_common/dbclose.jsp" %>