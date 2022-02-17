<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","CSS 관리");
	pageContext.setAttribute("PageDescription","CSS를 등록/수정 할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","8-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>
<script>
	function DoWrite(a)
	{
		var f = document.aform;
		f.action="css_form.jsp";
		f.cmd.value="write";
		f.gbn.value = a;
		f.submit();		
	}
	function onSearching(a){
		var f = document.aform;
		f.action="css_list.jsp";
		f.search_txt.value = a;
		f.submit();	
	}
	function DoSearch()
	{
		var f = document.aform;
		f.action="css_list.jsp";
		f.submit();	
	}
	
	function GoPage(pidx)
	{
		var f = document.aform;
		f.action="css_list.jsp";		
		f.cpage.value = pidx;
		f.submit();
	}

	function GoView(pidx)
	{
		var f = document.aform;
		f.action="css_form.jsp";
		f.cmd.value="modify";
		f.idx.value = pidx;
		f.submit();
	}

	function GoDetail(pidx)
	{
		var f = document.aform;
		f.action="css_form.jsp";
		f.quiz_idx.value = pidx;
		f.submit();	
	} 

var check = false;
function CheckAll(){
var chk = document.getElementsByName("del_unit[]");
if(check == false){
check = true;
for(var i=0; i<chk.length;i++){                                                                    
chk[i].checked = true;     //모두 체크
}
}else{
check = false;
for(var i=0; i<chk.length;i++){                                                                    
chk[i].checked = false;     //모두 해제
}
}
}
	function DoRemove()
	{
		if(!confirm('정말 삭제 하시겠습니까?')) {
			return false;
		}
		var chk = document.getElementsByName("del_unit[]");
		var idx = new Array();
		var cnt=0;
		for(var i=0; i<chk.length; i++){
			if(chk[i].checked == true){  //체크가 되어있는 값 구분
				idx[cnt] = chk[i].value;
				cnt++;
			}
		}
		if(cnt==0) {
			alert("체크박스를 선택해 주세요");
			return false;
		}
		location.href="css_form_pro.jsp?cmd=remove&idxArr=" + idx;  
		//var f = document.aform;
		//f.action="css_form_pro.jsp";
		//f.cmd.value="remove";
		//f.submit();	
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
			sql = " SELECT count(1) AS cnt FROM fzst_css";		
			pstmt = con.prepareStatement( sql );			
		} else {
			sql = " SELECT count(1) AS cnt FROM fzst_css WHERE gbn = ? ";		
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
		
		
		if(search_txt.equals("8-1")) { selected1 = "selected"; }
		else if(search_txt.equals("8-2")) { selected2 = "selected"; }
		else if(search_txt.equals("8-3")) { selected3 = "selected"; }
		else  { 
			selected4 = "selected"; 
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
                <div class="input-group input-group-sm" style="width: 550px;">
				  <select class = "form-control" id="search_txt" name="search_txt" onchange="onSearching(this.value)">
					<option value="" <%=selected4%>>전체보기</option>
					<option value="8-1" <%=selected1%>>전체CSS</option>
					<option value="8-2" <%=selected2%>>메인CSS</option>
					<option value="8-3" <%=selected3%>>서브CSS</option>
				  </select>
                  <!--<input name="search_txt" class="form-control pull-right" type="text" placeholder="Search" value="<%=INPUT_VALUE(search_txt)%>">-->
                  <div class="input-group-btn">
                    <!--<button class="btn btn-default" type="button" onclick="DoSearch();"><i class="fa fa-search"></i></button>-->                    
                    <button class="btn btn-inline btn-primary btn-xs" style="margin-left:40px" type="button" onclick="DoWrite('8-1');">전체CSS 등록</button>
					<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="DoWrite('8-2');">메인CSS 등록</button>
					<button class="btn btn-inline btn-primary btn-xs" style="margin-left:10px" type="button" onclick="DoWrite('8-3');">서브CSS 등록</button>
					 <button class="btn btn-danger" type="button" style="margin-left:10px" onclick="DoRemove();">삭제하기</button>
                  </div>                  
                </div>                
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
              <table class="table table-hover">
                <tbody><tr>
				  <th><input type="checkbox" name="checkall" onclick="javascript:CheckAll()"></th>
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
					+"		a.idx, a.gbn, a.contents ,a.title, a.open_yn, a.open_yn, a.write_date, a.write_id "
					+"	FROM "
					+"		fzst_css a "
					+"	ORDER BY a.gbn,a.idx DESC LIMIT ? , ? ";
				pstmt = con.prepareStatement( sql );
				pstmt.setInt(1,limit_offset);
				pstmt.setInt(2,PAGE_SIZE);	
			} else {	
				sql =" 	SELECT "
					+"		a.idx, a.gbn, a.contents ,a.title, a.open_yn, a.open_yn, a.write_date, a.write_id "
					+"	FROM "
					+"		fzst_css a "
					+"	WHERE "
					+"	a.gbn = ? "
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
					if(gbn_txt.equals("8-1")) { gbn_show = "전체CSS"; }
					else if(gbn_txt.equals("8-2")) { gbn_show = "메인CSS"; }
					else if(gbn_txt.equals("8-3")) { gbn_show = "서브CSS"; }
%>                
                <tr>
				  <td><input type="checkbox" name="del_unit[]" value="<%=DBStr(rs,"idx")%>"></td>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=i%></a></td>
                  <td><a href="javascript:GoView('<%=DBStr(rs,"idx")%>');"><%=gbn_show%></a></td>
                  <td><%=DBStr(rs,"open_yn")%> | 제목:<%=DBStr(rs,"title") %></td>
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