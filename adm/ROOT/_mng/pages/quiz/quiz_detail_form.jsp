<%@ page contentType="text/html; charset=UTF-8" %>
<%
	pageContext.setAttribute("PageHeader","우리말 달인 관리");
	pageContext.setAttribute("PageDescription","우리말 달인 등록 및 수정할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","4-1");
%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%@ include file="../../include/top.jsp" %>

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String cmd = REQParam( request.getParameter("cmd") );
	
	try{
		
		String sql="";
		
		//////////////////// 글 정보 검색 /////////////////////		
		String quiz_idx = REQParam( request.getParameter("quiz_idx") );
		String idx = REQParam( request.getParameter("idx") );
		Hashtable data = new Hashtable();
		if( "modify".equals(cmd) ) {
			sql = " SELECT a.* FROM NARO_QUIZ_QUESTION a WHERE a.del_yn='N' AND a.idx=? ";
			pstmt = con.prepareStatement( sql );
			pstmt.setInt(1, Integer.parseInt(idx) );
			rs = pstmt.executeQuery();		
			DBHash( rs, data );
		}
		
%>
<script src="/_js/common.js"></script>
<script>
	function DoWrite()
	{
		var f = document.aform;
		if(CheckEmpty(f.num,"번호를 입력하세요")) return;
		if(CheckNumber(f.num,"번호에 영문자,한글, 특수문자들을 제외한 숫자만 입력하세요")) return;
		if(CheckEmpty(f.title,"질문을 입력하세요")) return;
		f.action="quiz_detail_form_pro.jsp";		
		f.submit();
	}

	function GoList()
	{
		var f = document.aform;
		f.action="quiz_detail.jsp";		
		f.enctype="application/x-www-form-urlencoded";
		f.submit();
	}
	
	function DoRemove()
	{
		if(!confirm("삭제하시겠습니까?")) return;

		var f = document.aform;
		f.action="quiz_detail_form_pro.jsp";
		f.cmd.value="remove";
		f.submit();	
	}

</script>

<form name="aform" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="cmd" value="<%=cmd%>"/>
	<input type="hidden" name="idx" value="<%=IsNull(data.get("idx"),"0")%>"/>
	<input type="hidden" name="quiz_idx" value="<%=quiz_idx%>"/>
	<div class="row">
        <div class="col-xs-12">
    
    	  <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">문항 등록/수정</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
              <div class="box-body">
                <div class="form-group">
                  <label for="title">번호</label>
                  <input class="form-control" id="num" name="num" type="text" placeholder="번호를 숫자로 입력하세요." value="<%=INPUT_VALUE(data.get("num"))%>">
                </div>
                <div class="form-group">
                  <label for="title">질문</label>
                  <textarea class="form-control" name="title" id="title" rows="2" cols="80"><%=IsNull(data.get("title"),"")%></textarea>                 
                </div>
                <div class="form-group">
                  <label for="subtitle">예시</label>
                  <textarea class="form-control" name="subtitle" id="subtitle" rows="2" cols="80"><%=IsNull(data.get("subtitle"),"")%></textarea>                 
                </div>
                <div class="form-group">
                  <label for="right_answer">정답</label>&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="right_answer" id="right_answer_o" value="O" <%if("O".equals(data.get("right_answer"))){%>checked<%}%>> O&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="right_answer" id="right_answer_x" value="X" <%if("X".equals(data.get("right_answer"))){%>checked<%}%>> X                
                </div>
                <div class="form-group">
                  <label for="contents">정답설명</label>
                  <textarea class="form-control" name="contents" id="contents" rows="3" cols="80"><%=IsNull(data.get("contents"),"")%></textarea>                 
                </div>
                
              </div> 
              <!-- /.box-body -->

              <div class="box-footer">
                <button class="btn btn-primary" type="button" onclick="DoWrite();">Submit</button>
                <button class="btn btn-warning" type="button" onclick="GoList();">List</button>
                <% if( "modify".equals(cmd) ) { %>
                <button class="btn btn-danger" type="button" onclick="DoRemove();">Remove</button>
                <% } %>
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