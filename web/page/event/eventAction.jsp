<%@page import="kr.urimal365.dao.EventDAO"%>
<%@page import="kr.urimal365.dto.Event"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String uploadDir = "c:/apache-tomcat-9.0.0.M4/webapps/ROOT/eventImage";
	String uploadPath = "/eventImage";
	String tmp = "c:/apache-tomcat-9.0.0.M4/webapps/ROOT/eventImage";
	int sizeLimit = 1024*1024*15;
	try {
 	MultipartRequest multi = 
			new MultipartRequest(request, tmp, sizeLimit
					, "utf-8", new DefaultFileRenamePolicy()); 
 	
 	Event event = new Event();
 	
	String name = multi.getParameter("name");
	String phone = multi.getParameter("phone");
	String comment = multi.getParameter("comment");
	int idx = Integer.parseInt(multi.getParameter("idx"));
 	
	event.setUserName(name);
	event.setUserHp(phone);
	event.setContents(comment);
	event.setEventGroupIdx(idx);
	event.setAgreeYn("Y");
	
	File file = multi.getFile("upload_file");
	
	if (file != null) {
		String dir = uploadDir + "/event_" + idx;
		File updir = new File(dir);
		if (!updir.exists()) { updir.mkdir();}
	
	   String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());  //현재시간
		dir = dir + "/" +now +  file.getName();

		File moveFile = new File(dir);
		file.renameTo(moveFile);
		
		uploadPath = uploadPath + "/event_" + idx + "/" + now +  file.getName();
		
		event.setImgDir(uploadPath);
	}
	
	int row = EventDAO.getDAO().insertEvent(event);
	
	if (row > 0 ) {
		%><script>alert("이벤트응모를 완료했습니다.");history.back();</script> <%
	} else {
		%><script>alert("이벤트응모에 실패했습니다. 다시 시도해주세요.");history.back();</script> <%
	}
	
	} catch(IOException e) {
		e.printStackTrace();
	}
	
%>