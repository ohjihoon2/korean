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
		
		/////////////////////////// 파일 업로드 및 파라메터 //////////////////////////////////
		java.util.Calendar currentCalendar = java.util.Calendar.getInstance();
		int yyyy = currentCalendar.get(java.util.Calendar.YEAR);
		int mm = currentCalendar.get(Calendar.MONTH) + 1;

		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);
        //String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY + File.separator + yyyy+"_"+mm;
        String uploadPath = UPLOAD_DIRECTORY + File.separator + yyyy+"_"+mm;
        String urlPath = UPLOAD_URL+"/"+yyyy+"_"+mm;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) { uploadDir.mkdir(); }

		Iterator items = upload.parseRequest(request).iterator();		
		Hashtable<String,String> params = new Hashtable<String,String>();	
		ArrayList uploadfilelist = new ArrayList();

		while (items.hasNext()) {
    		FileItem thisItem = (FileItem) items.next();    		
	    	if (!thisItem.isFormField()) {	    		
	    		//File Upload
	    		String fileName = new File(thisItem.getName()).getName();	    		
	    		if( IsValid( fileName )) {

	    			//fileName=System.currentTimeMillis()+"."+fileName.substring(fileName.lastIndexOf( "." )+1);

	                String filePath = uploadPath + File.separator + fileName;
	                File storeFile = new File(filePath); 
	                thisItem.write(storeFile);
	                thisItem.delete();               
	                
	                uploadfilelist.add( new String[]{ filePath, urlPath+"/"+fileName, fileName} );
	            }
	    	}
	    }



	    //////////////////////////////////////////////////////////////////////////////////////

		

	String cmd 			= "write";
	

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int paramcnt=0;
	try{
	
%>
<form name="aform" method="GET" action="media_list.jsp">
</form>
<%		
		//////////////////////////////////// 등록 ///////////////////////////////////////
		if( "write".equals(cmd) ) {
			int upd_cnt = 0;
			for( int i=0; i<uploadfilelist.size(); i++ ) {
				String sql = " INSERT INTO NARO_MEDIA SET url=?, path=?, filename=?, del_yn='N', write_id=?, write_date=now() ";
				pstmt = con.prepareStatement( sql );
				String data[] = (String[])uploadfilelist.get(i);
				paramcnt=1;				
				pstmt.setString( paramcnt++, data[1] );			
				pstmt.setString( paramcnt++, data[0] );			
				pstmt.setString( paramcnt++, data[2] );			
				pstmt.setString( paramcnt++, (String)session.getAttribute("admin_user_id") );
				upd_cnt += pstmt.executeUpdate();		
			}
			
			if( upd_cnt > 0 ) {
				out.println( "<script>alert('등록되었습니다.'); document.aform.submit(); </script>" );
			} else {
				out.println( "<script>alert('등록되지 않았습니다. 다시 시도해주세요.'); document.aform.submit(); </script>" );
			}			
		
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