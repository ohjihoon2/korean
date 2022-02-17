<%@ page contentType="text/html; charset=UTF-8"%>
<%
	pageContext.setAttribute("PageHeader","게시글 관리");
	pageContext.setAttribute("PageDescription","게시글 등록 및 수정할 수 있습니다.");
	pageContext.setAttribute("PageMenuID","2-1");
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
		
		
		//////////////////// 글 정보 검색 /////////////////////		
		String idx = REQParam( request.getParameter("idx") );
		Hashtable data = new Hashtable();
		if( "modify".equals(cmd) ) {
			sql = " SELECT a.*, ( SELECT parent_idx FROM NARO_NEWS_CATEGORY x WHERE x.idx=a.category_idx) AS category_parent_idx FROM NARO_NEWS a WHERE a.del_yn='N' AND a.idx=? ";
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
    f.target="";
		f.action="news_form_pro.jsp";		
		f.submit();
	}

	function GoList()
	{
		var f = document.aform;
    f.target="";
		f.action="news_list.jsp";		
		f.submit();
	}
	
	function DoRemove()
	{
		if(!confirm("삭제하시겠습니까?")) return;

		var f = document.aform;
    f.target="";
		f.action="news_form_pro.jsp";
		f.cmd.value="remove";
		f.submit();	
	}

	function onCate1Change(cate1_idx, cate2_idx)
	{
		if( cate1_idx == null || cate1_idx == "" || cate1_idx == undefined ) {
			$("#category_idx").html("");				 
		} else {
			$.get("ajax/cate2_list.jsp?parent_idx="+cate1_idx, function(data) {
				 $("#category_idx").html("");				 
				 $("#category_idx").append(data);
				 if( cate2_idx != undefined && cate2_idx != null ) {				 
				 	$("#category_idx").val(cate2_idx );
				 } else {
				 	$("#category_idx").focus();
				 }
			});
		}
	}

	function GoPreview()
	{
		var data = "http://<%=request.getServerName()%><%="220.120.99.66".equals(request.getServerName())?":88":""%>/view.jsp?idx=<%=idx%>&preview=Y";

    if( document.all ) {
      window.clipboardData.setData("Text", data);
      alert("클립보드에 미리보기 주소가 복사되었습니다. 새창을 열어 주소를 붙여넣어 주세요.");
    } else {
      prompt("이 글의 미리보기 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", data); 
    }
	}

  var preview_win;
  function previewBanner()
  {
    var banner_file = $("#banner_file").val();
    if( banner_file=="" ) {
      alert("배너파일을 선택해주세요.");
      return;
    }

    var f = document.aform;
    f.target="banner_preview";
    f.action="news_form_banner_preview.jsp";
    f.cmd.value="banner_preview";
    f.submit(); 

    /*
    var url = "http://<%=request.getServerName()%><%="220.120.99.66".equals(request.getServerName())?":88":""%>/index.jsp?banner_preview_file="+banner_file;
    var win = window.open(url,"preview_win");
    if( win != null ) {
      preview_win = win;
    }
    if( preview_win!= null) preview_win.focus();
    */
  }
</script>

<form name="aform" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="cmd" value="<%=cmd%>"/>
	<input type="hidden" name="idx" value="<%=idx%>"/>
	<div class="row">
        <div class="col-xs-12">
    
    	  <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">게시글 등록/수정</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
              <div class="box-body">
                <div class="form-group">
                  <label for="category1">카테고리 1</label>
                  <select class="form-control" id="category1" name="category1"  onchange="onCate1Change(this.value);">
                    <option value="">:: 카테고리 1 선택 ::</option>
                    <% 
                    	for( int i=0; i<listCate1.size(); i++ ) { 
                    		String[] cateitem = (String[])listCate1.get(i); 
                    %>
                    <option value="<%=cateitem[0]%>"><%=cateitem[1]%></option>
                    <% 
                    	} 
                    %>
                  </select>
                </div>
                <div class="form-group">
                  <label for="category1">카테고리 2</label>
                  <select class="form-control" id="category_idx" name="category_idx">                    
                  </select>
                </div>
                <div class="form-group">
                  <label for="title">제목</label>
                  <input class="form-control" id="title" name="title" type="text" placeholder="제목을 입력하세요." value="<%=INPUT_VALUE(data.get("title"))%>">
                </div>
                <div class="form-group">
                  <label for="title">소제목</label>
                  <input class="form-control" id="subtitle" name="subtitle" type="text" placeholder="소제목을 입력하세요." value="<%=INPUT_VALUE(data.get("subtitle"))%>">
                </div>
                <div class="form-group">
                  <label for="exampleInputFile">썸네일 파일</label>
                  <input class="form-control" id="thumbnail_file" name="thumbnail_file" type="file">
                  <% if( IsValid(data.get("thumbnail_file")) ) { %>                  
                  <input type="checkbox" name="thumbnail_file_yn" value="Y"> 삭제 여부
                  &nbsp;&nbsp;<a href="http://<%=request.getServerName()%><%="220.120.99.66".equals(request.getServerName())?":88":""%><%=data.get("thumbnail_file")%>" target="_blank">[링크]</a>
                  <% } else { %>
                  <p class="help-block">JPG 파일을 이용해주세요.</p>
                  <% } %>
                </div>
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
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="banner_yn" value="Y" <% if("Y".equals(data.get("banner_yn"))) { %>checked<% } %>> 배너 사용 여부
                  </label>
                </div>
                <div class="form-group">
                  <label for="exampleInputFile">배너 파일</label>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:previewBanner();">[미리보기]</a>
                  <input class="form-control" id="banner_file" name="banner_file" type="file">
                  <% if( IsValid(data.get("banner_file")) ) { %>                  
                  <input type="checkbox" name="banner_file_yn" value="Y"> 삭제 여부
                  &nbsp;&nbsp;<a href="http://<%=request.getServerName()%><%="220.120.99.66".equals(request.getServerName())?":88":""%><%=data.get("banner_file")%>" target="_blank">[링크]</a>
                  <% } else { %>
                  <p class="help-block">JPG 파일을 이용해주세요.</p>
                  <% } %>
                </div>
                <div class="form-group">
                  <label for="banner_link">배너 링크</label>
                  <input class="form-control" id="banner_link" name="banner_link" type="text" placeholder="링크를 입력하세요." value="<%=INPUT_VALUE(data.get("banner_link"))%>">
                </div>
                <div class="form-group">
                  <label for="title2">한글 맞춤법(제목)</label>
                  <input class="form-control" id="title2" name="title2" type="text" placeholder="한글 맞춤법의 제목을 입력하세요." value="<%=INPUT_VALUE(data.get("title2"))%>">
                </div>
                <div class="form-group">
                  <label for="title3">한글 맞춤법(요약)</label>
                  <input class="form-control" id="title3" name="title3" type="text" placeholder="한글 맞춤법의 요약내용을 입력하세요." value="<%=INPUT_VALUE(data.get("title3"))%>">
                </div>
                <div class="form-group">
                  <label for="except">Description(meta tag)</label>
                  <input class="form-control" id="except" name="except" type="text" placeholder="meta 태그에 사용될 Description 을 입력하세요." value="<%=INPUT_VALUE(data.get("except"))%>">
                </div>
                <div class="form-group">
                  <label for="contents">내용</label>
                  <textarea name="contents" id="contents" style="display: none; visibility: hidden;" rows="10" cols="80"><%=IsNull(data.get("contents"),"")%></textarea>
                  <%--<textarea class="form-control" name="contents" id="contents" rows="30" cols="80"><%=IsNull(data.get("contents"),"")%></textarea>--%>                  
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
	    
		
		
	    //Categroy Load
	    <% if( IsValid(data.get("category_parent_idx")) ) { %>
	    	$('#category1').val('<%=data.get("category_parent_idx")%>');
	    	onCate1Change('<%=data.get("category_parent_idx")%>', '<%=data.get("category_idx")%>');
	    <% } %>
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