<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.util.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int paramcnt=0;
	try{
		
		/////////////////////////// 파일 업로드 및 파라메터 //////////////////////////////////
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);
        String uploadPath = getServletContext().getRealPath("/") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) { uploadDir.mkdir(); }

		Iterator items = upload.parseRequest(request).iterator();
		Hashtable<String,String> params = new Hashtable<String,String>();	
		while (items.hasNext()) {
    		FileItem thisItem = (FileItem) items.next();
	    	if (thisItem.isFormField()) {
	    		//Parameter
	    		params.put(thisItem.getFieldName(), thisItem.getString("UTF-8") );
	    	} else {
	    		//File Upload
	    	}
	    }
	    //////////////////////////////////////////////////////////////////////////////////////

		String cmd 			= REQParam( params.get("cmd") );
		String idx 			= REQParam( params.get("idx") );

%>
<form name="aform" method="GET" action="quiz_list.jsp">
<input type="hidden" name="cmd" value="<%=cmd%>".>
<input type="hidden" name="idx" value="<%=idx%>".>
</form>
<%		
		//////////////////////////////////// 등록 ///////////////////////////////////////
		if( "write".equals(cmd) ) {
			String sql = " INSERT INTO NARO_QUIZ SET title=?, subtitle=?, ym=?, description=?, contents=?, open_yn=?, open_start_datetime=?, open_end_datetime=?, del_yn='N', write_id=?, write_date=now() ";
			pstmt = con.prepareStatement( sql );
		
			paramcnt=1;	
			pstmt.setString( paramcnt++, REQParam(params.get("title")) );
			pstmt.setString( paramcnt++, REQParam(params.get("subtitle")) );
			pstmt.setString( paramcnt++, REQParam(params.get("ym")) );
			pstmt.setString( paramcnt++, REQParam(params.get("description")) );
			pstmt.setString( paramcnt++, REQParam(params.get("contents")) );			
			pstmt.setString( paramcnt++, REQCHKParam(params.get("open_yn")) );			
			pstmt.setString( paramcnt++, REQParam(params.get("open_start_datetime")) );
			pstmt.setString( paramcnt++, REQParam(params.get("open_end_datetime")) );
			pstmt.setString( paramcnt++, (String)session.getAttribute("admin_user_id") );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('등록되었습니다.'); document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('등록되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			}			
		//////////////////////////////////// 수정 ///////////////////////////////////////
		} else if( "modify".equals(cmd) ) {
			String sql = " UPDATE NARO_QUIZ SET title=?, subtitle=?, ym=?, description=?, contents=?, open_yn=?, open_start_datetime=?, open_end_datetime=?, update_id=?, update_date=now() WHERE idx=? ";
			pstmt = con.prepareStatement( sql );
			
			paramcnt=1;	
			pstmt.setString( paramcnt++, REQParam(params.get("title")) );
			pstmt.setString( paramcnt++, REQParam(params.get("subtitle")) );
			pstmt.setString( paramcnt++, REQParam(params.get("ym")) );
			pstmt.setString( paramcnt++, REQParam(params.get("description")) );
			pstmt.setString( paramcnt++, REQParam(params.get("contents")) );			
			pstmt.setString( paramcnt++, REQCHKParam(params.get("open_yn")) );			
			pstmt.setString( paramcnt++, REQParam(params.get("open_start_datetime")) );
			pstmt.setString( paramcnt++, REQParam(params.get("open_end_datetime")) );
			pstmt.setString( paramcnt++, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( paramcnt++, idx );
			int upd_cnt = pstmt.executeUpdate();	
			pstmt.close();	
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('수정되었습니다.'); document.aform.action='quiz_form.jsp'; document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('수정되지 않았습니다. 다시 시도해주세요.'); document.aform.action='quiz_form.jsp'; document.aform.submit(); </script>" );
			}			
		//////////////////////////////////// 삭제 ///////////////////////////////////////
		} else if( "remove".equals(cmd) ) {			
			String sql = " UPDATE NARO_QUIZ SET del_yn='Y', update_id=?, update_date=now() WHERE idx=? ";
			pstmt = con.prepareStatement( sql );			
			pstmt.setString( 1, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( 2, idx );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('삭제되었습니다.'); document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('삭제되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			}							
		//////////////////////////////////// 나머저의 경우(오류) ///////////////////////////////////////
		} else {
			out.println("올바른 접근이 아닙니다.");
		}
			
	} catch( SQLException ex ) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
		out.println(ex.toString());
	} finally {
		if( rs !=null ) { rs.close(); }
		if( pstmt != null ) { pstmt.close(); }
	}
%>
<%@ include file="/_common/dbclose.jsp" %>