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
        //String uploadPath = getServletContext().getRealPath("/") + File.separator + UPLOAD_DIRECTORY;
        String uploadPath = UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) { uploadDir.mkdir(); }

		Iterator items = upload.parseRequest(request).iterator();
		Hashtable<String,String> params = new Hashtable<String,String>();	

		String thumbnail_file = null, banner_file=null;
		while (items.hasNext()) {
    		FileItem thisItem = (FileItem) items.next();
	    	if (thisItem.isFormField()) {
	    		//Parameter
	    		params.put(thisItem.getFieldName(), thisItem.getString("UTF-8") );
	    	} else {
	    		//File Upload
	    		String fileName = new File(thisItem.getName()).getName();
	    		if( IsValid( fileName )) {
	    			fileName=System.currentTimeMillis()+"."+fileName.substring(fileName.lastIndexOf( "." )+1);
					String filePath = uploadPath + File.separator + fileName;
	                File storeFile = new File(filePath); 
	                thisItem.write(storeFile);
	                thisItem.delete();
	                if( "thumbnail_file".equals(thisItem.getFieldName()) ) {	    
	                	thumbnail_file = UPLOAD_URL+"/"+fileName; //DB저장 경로

	                	//thumbnail_file = "/"+UPLOAD_DIRECTORY+"/thum_"+fileName; //DB저장 경로
	                	//String savePath =  uploadPath + File.separator +"thum_"+fileName; //실제저장 경로
	                	//MakeThumbnail( 600,450, filePath, savePath );  //썸네일 만들기							                	
	                } else if( "banner_file".equals(thisItem.getFieldName()) ) {	
	                	banner_file = UPLOAD_URL+"/"+fileName; //DB저장 경로

	                	//String savePath =  uploadPath + File.separator +"thum_"+fileName; //실제저장 경로
	                	//MakeThumbnail( 400,400, filePath, savePath );  //썸네일 만들기
	                }
	            }
	    	}
	    }
	    //////////////////////////////////////////////////////////////////////////////////////

	    String cmd 			= REQParam( params.get("cmd") );
		String idx 			= REQParam( params.get("idx") );
		
%>
<form name="aform" method="GET" action="news_list.jsp">
<input type="hidden" name="cmd" value="<%=cmd%>".>
<input type="hidden" name="idx" value="<%=idx%>".>
</form>
<%		
		//////////////////////////////////// 등록 ///////////////////////////////////////
		if( "write".equals(cmd) ) {
			String sql = " INSERT INTO NARO_NEWS SET category_idx=?, title=?, subtitle=?, title2=?, title3=?, except=?, contents=?, thumbnail_file=?,banner_yn=?, banner_file=?, banner_link=?, read_count=0, open_yn=?, open_start_datetime=?, open_end_datetime=?, del_yn='N', write_id=?, write_date=now() ";
			pstmt = con.prepareStatement( sql );
		
			paramcnt=1;	
			pstmt.setInt( paramcnt++, Integer.parseInt(params.get("category_idx")) );
			pstmt.setString( paramcnt++, REQParam(params.get("title")) );
			pstmt.setString( paramcnt++, REQParam(params.get("subtitle")) );
			pstmt.setString( paramcnt++, REQParam(params.get("title2")) );
			pstmt.setString( paramcnt++, REQParam(params.get("title3")) );
			pstmt.setString( paramcnt++, REQParam(params.get("except")) );
			pstmt.setString( paramcnt++, REQParam(params.get("contents")) );
			pstmt.setString( paramcnt++, thumbnail_file );
			pstmt.setString( paramcnt++, REQCHKParam(params.get("banner_yn")) );
			pstmt.setString( paramcnt++, banner_file );
			pstmt.setString( paramcnt++, REQParam(params.get("banner_link")) );
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
			String sql = " UPDATE NARO_NEWS SET category_idx=?, title=?, subtitle=?, title2=?, title3=?, except=?, contents=?, banner_yn=?, banner_link=?, open_yn=?, open_start_datetime=?, open_end_datetime=?, update_id=?, update_date=now(),modify_id=modify_id+1,contents_status='U' WHERE idx=? ";
			pstmt = con.prepareStatement( sql );
			
			paramcnt=1;	
			pstmt.setInt( paramcnt++, Integer.parseInt(params.get("category_idx")) );
			pstmt.setString( paramcnt++, REQParam(params.get("title")) );
			pstmt.setString( paramcnt++, REQParam(params.get("subtitle")) );
			pstmt.setString( paramcnt++, REQParam(params.get("title2")) );
			pstmt.setString( paramcnt++, REQParam(params.get("title3")) );
			pstmt.setString( paramcnt++, REQParam(params.get("except")) ); 
			pstmt.setString( paramcnt++, REQParam(params.get("contents")) );			
			pstmt.setString( paramcnt++, REQCHKParam(params.get("banner_yn")) );
			pstmt.setString( paramcnt++, REQParam(params.get("banner_link")) );
			pstmt.setString( paramcnt++, REQCHKParam(params.get("open_yn")) );			
			pstmt.setString( paramcnt++, REQParam(params.get("open_start_datetime")) );
			pstmt.setString( paramcnt++, REQParam(params.get("open_end_datetime")) );
			pstmt.setString( paramcnt++, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( paramcnt++, idx );
			int upd_cnt = pstmt.executeUpdate();	
			pstmt.close();	
			

			String thumbnail_file_yn = REQCHKParam(params.get("thumbnail_file_yn"));
			if( IsValid(thumbnail_file) ) {
				sql = " UPDATE NARO_NEWS SET thumbnail_file=? WHERE idx=? ";
				pstmt = con.prepareStatement( sql );			
				paramcnt=1;	
				pstmt.setString( paramcnt++, thumbnail_file );
				pstmt.setString( paramcnt++, idx );
				pstmt.executeUpdate();	
				pstmt.close();	
			} else if( "Y".equals(thumbnail_file_yn) ) {
				sql = " UPDATE NARO_NEWS SET thumbnail_file=NULL WHERE idx=? ";
				pstmt = con.prepareStatement( sql );			
				paramcnt=1;	
				pstmt.setString( paramcnt++, idx );
				pstmt.executeUpdate();	
				pstmt.close();	
			}

			String banner_file_yn = REQCHKParam(params.get("banner_file_yn"));
			if( IsValid(banner_file) ) {
				sql = " UPDATE NARO_NEWS SET banner_file=? WHERE idx=? ";
				pstmt = con.prepareStatement( sql );			
				paramcnt=1;	
				pstmt.setString( paramcnt++, banner_file );
				pstmt.setString( paramcnt++, idx );
				pstmt.executeUpdate();	
				pstmt.close();	
			} else if( "Y".equals(banner_file_yn) ) {
				sql = " UPDATE NARO_NEWS SET banner_file=NULL WHERE idx=? ";
				pstmt = con.prepareStatement( sql );			
				paramcnt=1;	
				pstmt.setString( paramcnt++, idx );
				pstmt.executeUpdate();	
				pstmt.close();	
			}

			if( upd_cnt > 0 ) {
				out.println( "<script>alert('수정 되었습니다.'); document.aform.action='news_form.jsp'; document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('수정되지 않았습니다. 다시 시도해주세요.'); document.aform.action='news_form.jsp'; document.aform.submit(); </script>" );
			}			
		//////////////////////////////////// 삭제 ///////////////////////////////////////
		} else if( "remove".equals(cmd) ) {			
			String sql = " UPDATE NARO_NEWS SET del_yn='Y', update_id=?, update_date=now(),contents_status='D' WHERE idx=? ";
			pstmt = con.prepareStatement( sql );			
			pstmt.setString( 1, (String)session.getAttribute("admin_user_id") );
			pstmt.setString( 2, idx );
			int upd_cnt = pstmt.executeUpdate();		
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('삭제 되었습니다.'); document.aform.submit(); </script>" );
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