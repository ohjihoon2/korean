<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>
<%
  String gbn = IsNull(request.getParameter("gbn"), "QUIZ");

	if( "3-1".equals(gbn)) {
    pageContext.setAttribute("PageHeader","메인 퀴즈 배너");    
  } else if( "3-2".equals(gbn)) {   
    pageContext.setAttribute("PageHeader","메인 하단 베너1");
  } else if( "3-3".equals(gbn)) {   
    pageContext.setAttribute("PageHeader","메인 하단 베너2");
  } else if( "3-4".equals(gbn)) {   
    pageContext.setAttribute("PageHeader","푸터");
  } else if( "3-5".equals(gbn)) {   
    pageContext.setAttribute("PageHeader","메인 최상단 팝업 배너");
  }
	pageContext.setAttribute("PageDescription","컨텐츠를 등록 및 수정할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","3");
%>
<%@ include file="../../include/top.jsp" %>

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String cmd = "write";
	
	try{
		
		String sql="";
				
		//////////////////// 레코드 정보 검색 /////////////////////		
		String idx = REQParam( request.getParameter("idx") );
		Hashtable data = new Hashtable();
		
		sql = " SELECT idx, contents, DATE_FORMAT(write_date,'%Y-%m-%d %H:%i:%s') AS str_write_date, write_id, open_yn,open_start_datetime,open_end_datetime FROM NARO_CONTENTS WHERE del_yn='N' AND idx=? ORDER BY idx DESC LIMIT 1 ";
		pstmt = con.prepareStatement( sql );		
    pstmt.setString(1,idx);
		rs = pstmt.executeQuery();		
		DBHash( rs, data );
	
		
%>
<script src="/_js/common.js"></script>
<script>
	function Dolist(){
		var f = document.aform;
		f.action="contents_list.jsp";
		f.submit();
	}

	function DoWrite()
	{
		var f = document.aform;
		f.action="contents_form_pro.jsp";
		f.submit();
	}
	
	function DoRemove()
	{
		if(!confirm("삭제하시겠습니까?")) return;

		var f = document.aform;
		f.action="contents_form_pro.jsp";
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
                <% if( !data.isEmpty() ) { %>
                <button class="btn btn-danger" type="button" onclick="DoRemove();">Remove</button>
                <% } %>
				<button class="btn btn-primary" type="button" onclick="Dolist();">List</button>
              </div>
          </div>
    
        </div>
    </div>
</form>    

<script src="../../plugins/ckeditor/ckeditor.js"></script>
<script>
	$(function () {		
		//CKEDITOR	
	    CKEDITOR.replace('contents',{
	    	width:"100%",
	    	height:"400px",
	    	"filebrowserUploadUrl":"/_mng/plugins/ckeditor/upload.jsp",
	    	allowedContent:true
	    });
		
		/*
	    CKEDITOR.on('dialogDefinition', function( ev ){
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
          
            switch (dialogName) {
                case 'image': //Image Properties dialog
                    //dialogDefinition.removeContents('info');
                    dialogDefinition.removeContents('Link');
                    dialogDefinition.removeContents('advanced');
                    break;
            }
        });
        */
		
		$('#open_start_datetime').datetimepicker({
			format: "YYYY-MM-DD HH:mm",			
            sideBySide: true
		});
		$('#open_end_datetime').datetimepicker({
			format: "YYYY-MM-DD HH:mm",
			sideBySide: true
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