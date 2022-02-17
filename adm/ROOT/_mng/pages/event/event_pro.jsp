<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/check_login.jsp"%>
<%@ include file="/_common/dbopen.jsp"%>
<%@ include file="/_common/conf.jsp"%>
<%@ include file="/_common/function.jsp"%>
<%
	String control = request.getParameter("control");
	String eventName = request.getParameter("event_name");
	String idx = request.getParameter("idx");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;

	try {
		if (control.equals("add")) {
			sql = "insert into FZST_EVENT_SUBJECT values(null,?,'N')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, eventName);

			int num = pstmt.executeUpdate();

			pstmt.close();

			if (num > 0) {
				%><script>alert("이벤트 추가 성공");</script><%
			} else {
			%><script>alert("이벤트 추가 실패");</script><%
			}
		} else if (control.equals("del")) {
			sql = "update FZST_EVENT_SUBJECT set del_yn='Y' where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, idx);

			int num = pstmt.executeUpdate();

			pstmt.close();

			if (num > 0) {
				%><script>alert("이벤트 삭제 성공");</script><%
			} else {
			%><script>alert("이벤트 삭제 실패");</script><%
			}
			
		}
		
		response.sendRedirect("event_subject.jsp");
%>

<%
	} catch (SQLException ex) {
		out.println("오류가 발생되었습니다. 다시 시도해주세요");
		out.println(ex.toString());
	} finally {
		if (rs != null) {
			rs.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
	}
%>
<%@ include file="/_common/dbclose.jsp"%>