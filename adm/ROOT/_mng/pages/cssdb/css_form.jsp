<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","CSS 관리");
	pageContext.setAttribute("PageDescription","CSS를 등록/수정 할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","8-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%
  String gbn = IsNull(request.getParameter("gbn"), "QUIZ");
	
	if( "8-1".equals(gbn)) {
    pageContext.setAttribute("PageHeader","전체 CSS");    
  } else if( "8-2".equals(gbn)) {   
    pageContext.setAttribute("PageHeader","메인CSS");
  } else if( "8-3".equals(gbn)) {   
    pageContext.setAttribute("PageHeader","서브CSS");
  } 
%>
<%@ include file="../../include/top.jsp" %>

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String cmd = REQParam( request.getParameter("cmd"));
	
	try{
		
		String sql="";
				
		//////////////////// 레코드 정보 검색 /////////////////////		
		String idx = REQParam( request.getParameter("idx") );
		Hashtable data = new Hashtable();
		
		sql = " SELECT idx, contents, DATE_FORMAT(write_date,'%Y-%m-%d %H:%i:%s') AS str_write_date, write_id, open_yn,title FROM fzst_css WHERE  idx=? ORDER BY idx DESC LIMIT 1 ";
		pstmt = con.prepareStatement( sql );		
    pstmt.setString(1,idx);
		rs = pstmt.executeQuery();		
		DBHash( rs, data );
	
		
%>
<script src="/_js/common.js"></script>
<script>
	function Dolist(){
		var f = document.aform;
		f.action="css_list.jsp";
		f.submit();
	}

	function DoWrite()
	{
		var f = document.aform;
		f.action="css_form_pro.jsp";
		f.submit();
	}
	
	function DoRemove()
	{
		if(!confirm('정말 삭제 하시겠습니까?')) {
			return false;
		}
		var f = document.aform;
		f.action="css_form_pro.jsp";
		f.cmd.value="remove";
		f.submit();	
	}
</script>

<form name="aform" method="POST">
	<input type="hidden" name="cmd" value="<%=cmd%>"/>
  <input type="hidden" name="gbn" value="<%=gbn%>"/>
	<input type="hidden" name="idx" value="<%=IsNull(data.get("idx"),"0")%>"/>
	<div class="row">
        <div class="col-xs-12">
    	  <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">컨텐츠 등록/수정</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
              <div class="box-body">
                <% if( !data.isEmpty() ) { %>
                <div class="form-group">
                  <label>작성자 / 작성일시 : </label>                  
                  <%=IsNull(data.get("write_id"),"")%> / <%=IsNull(data.get("str_write_date"),"")%>
                </div>
                <% } %>
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="open_yn" value="Y" <% if("Y".equals(data.get("open_yn"))) { %>checked<% } %>> 게시여부
                  </label>
                </div>
				<div class="form-group">
                  <label for="title">제목</label>
                  <input type="text" name="title" id="title" value="<%=IsNull(data.get("title"),"")%>"></input>                  
                </div>
                <div class="form-group">
                  <label for="contents">내용</label><br/>
                  <textarea name="contents" id="contents" rows="20" cols="200"><%=IsNull(data.get("contents"),"")%></textarea>                  
                </div>
                
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button class="btn btn-primary" type="button" onclick="DoWrite();">Submit</button>
				<button class="btn btn-primary" type="button" onclick="Dolist();">List</button>
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
		if( rs != null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="../../include/bottom.jsp" %>
<%@ include file="/_common/dbclose.jsp" %>