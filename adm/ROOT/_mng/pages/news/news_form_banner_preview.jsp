<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.util.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%	
		
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

		String banner_file=null;
		while (items.hasNext()) {
    		FileItem thisItem = (FileItem) items.next();
	    	if (thisItem.isFormField()) {
	    		//Parameter
	    		params.put(thisItem.getFieldName(), thisItem.getString("UTF-8") );
	    	} else {
	    		//File Upload
	    		String fileName = new File(thisItem.getName()).getName();
	    		if( IsValid( fileName )) {	    			
					fileName="______banner_preview"+"."+fileName.substring(fileName.lastIndexOf( "." )+1);

	                String filePath = uploadPath + File.separator + fileName;
	                File storeFile = new File(filePath); 
	                thisItem.write(storeFile);
	                thisItem.delete();
	                if( "banner_file".equals(thisItem.getFieldName()) ) {	
	                	banner_file = UPLOAD_URL+"/"+fileName; //DB저장 경로
	                }
	            }
	    	}
	    }
	    //////////////////////////////////////////////////////////////////////////////////////

		String cmd 			= REQParam( params.get("cmd") );
		String idx 			= REQParam( params.get("idx") );

%>
<form name="aform" method="GET" action="news_list.jsp">
<input type="hidden" name="cmd" value="<%=cmd%>"/>
<input type="hidden" name="idx" value="<%=idx%>"/>
</form>
<%		
								
		//////////////////////////////////// 삭제 ///////////////////////////////////////
		if( "banner_preview".equals(cmd) ) {					
			%><script>window.location="http://<%=request.getServerName()%><%="220.120.99.66".equals(request.getServerName())?":88":""%>/index.jsp?banner_preview_file=<%=banner_file%>";</script><%
		//////////////////////////////////// 나머저의 경우(오류) ///////////////////////////////////////
		} else {
			out.println("올바른 접근이 아닙니다.");
		}
%>
