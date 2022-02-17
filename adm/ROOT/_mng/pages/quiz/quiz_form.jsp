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
		String idx = REQParam( request.getParameter("idx") );
		Hashtable data = new Hashtable();
		if( "modify".equals(cmd) ) {
			sql = " SELECT a.* FROM NARO_QUIZ a WHERE a.del_yn='N' AND a.idx=? ";
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
		f.action="quiz_form_pro.jsp";		
		f.submit();
	}

	function GoList()
	{
		var f = document.aform;
		f.action="quiz_list.jsp";		
		f.submit();
	}
	
	function DoRemove()
	{
		if(!confirm("삭제하시겠습니까?")) return;

		var f = document.aform;
		f.action="quiz_form_pro.jsp";
		f.cmd.value="remove";
		f.submit();	
	}

	function GoPreview()
	{
		window.open("/quiz.jsp?idx=<%=idx%>","preview_quiz<%=idx%>");
	}

</script>

<form name="aform" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="cmd" value="<%=cmd%>"/>
	<input type="hidden" name="idx" value="<%=idx%>"/>
	<div class="row">
        <div class="col-xs-12">
    
    	  <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">등록/수정</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
              <div class="box-body">
                <div class="form-group">
                  <label for="title">월</label>
                  <input class="form-control" id="ym" name="ym" type="text" placeholder="해당월을 입력하세요." value="<%=INPUT_VALUE(data.get("ym"))%>">
                </div>
                <div class="form-group">
                  <label for="title">Description</label>
                  <textarea class="form-control" id="description" name="description" rows="5"><%=INPUT_VALUE(data.get("description"))%></textarea>
                </div>
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="open_yn" value="Y" <% if("Y".equals(data.get("open_yn"))) { %>checked<% } %>> 게시여부 ( 이벤트 퀴즈는 오픈여부를 <strong>체크하지 마세요.</strong>)
                  </label>
                </div>
                <div class="form-group">
                  <label for="open_start_datetime">게시 시작 시간</label>
                  <div class="input-group date">
                    <div class="input-group-addon">
                    	<i class="fa fa-calendar"></i>
                    </div>
                    <input class="form-control pull-right" id="open_start_datetime" name="open_start_datetime" type="text" value="<%=INPUT_VALUE(data.get("open_start_datetime"))%>">
                  </div>
                </div>                
                <div class="form-group">
                  <label for="open_end_datetime">게시 종료 시간</label>
                  <div class="input-group date">
                    <div class="input-group-addon">
                    	<i class="fa fa-calendar"></i>
                    </div>
                    <input class="form-control pull-right" id="open_end_datetime" name="open_end_datetime" type="text" value="<%=INPUT_VALUE(data.get("open_end_datetime"))%>">
                  </div>
                </div>
                <div class="form-group">
                  <label for="title">내용</label>
                  <textarea name="contents" id="contents" style="display: none; visibility: hidden;" rows="10" cols="80"><%=IsNull(data.get("contents"),"")%></textarea>                 
                </div>
                
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button class="btn btn-primary" type="button" onclick="DoWrite();">Submit</button>
                <button class="btn btn-warning" type="button" onclick="GoList();">List</button>
                <% if( "modify".equals(cmd) ) { %>
                <button class="btn btn-danger" type="button" onclick="DoRemove();">Remove</button>
                <button class="btn btn-success" type="button" onclick="GoPreview();">Preview</button>
                <% } %>
              </div>
          </div>
    
        </div>
    </div>
</form>    

<script src="../../plugins/ckeditor/ckeditor.js"></script>
<script>
	$(function () {
		//DateTime picker
		$('#open_start_datetime').datetimepicker({
			format: "YYYY-MM-DD HH:mm",			
            sideBySide: true
		});
		$('#open_end_datetime').datetimepicker({
			format: "YYYY-MM-DD HH:mm",
			sideBySide: true
		});
	
		//CKEDITOR	
	    CKEDITOR.replace('contents',{
	    	width:"100%",
	    	height:"400px",
	    	"filebrowserUploadUrl":"/_mng/plugins/ckeditor/upload.jsp",
	    	allowedContent:true
	    });
		
	});
	  
</script>

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