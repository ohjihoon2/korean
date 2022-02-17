<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/check_login.jsp" %>
<%@ include file="/_common/dbopen.jsp" %>
<%@ include file="/_common/conf.jsp" %>
<%@ include file="/_common/function.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	html{font-family: 'Source Sans Pro','Helvetica Neue',Helvetica,Arial,sans-serif; width:700px;}
	*{padding:0; margin:0; list-style:none;}
	body{padding:10px;}
	h3{font-size:18px; margin-bottom:15px; font-weight:normal;}
	table {border-collapse: collapse; border-spacing:0; border:0 none;border-left:1px solid #ccc; border-top:1px solid #ccc; }
	.serh_tb{margin-bottom:13px;}
	.serh_tb input{padding:3px; height:22px; box-sizing:border-box; border:1px solid #ccc; }
	.event_tb th, .event_tb td{border-right:1px solid #ccc; border-bottom:1px solid #ccc;padding:8px 11px; font-size:14px; color:#333;}
	.event_tb .num{text-align:center;}
	a.btn_del{display:inline-block; color:#fff; background-color:#3c8dbc;border:1px solid #367fa9; padding:3px 5px;  font-size:13px; text-decoration:none; border-radius:3px; }

</style>
</head>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql=null;
	
	try {
		sql = "select * from FZST_EVENT_SUBJECT where del_yn=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "N");
		rs = pstmt.executeQuery();
%>
<body>
	<h3>이벤트 등록현황</h3>
	<table  class="serh_tb event_tb ">
		<td>이벤트이름 : </td><td><input type="text" id="event_name"></td>
		<td><a href="javascript:event_add()" class="btn_del">이벤트 추가</a></td>		
	</table>
	<table  class="event_tb">
		<tr>
			<th width="500">이벤트 제목</th>
			<th width="90">이벤트 번호</th>
			<th width="90">비고</th>
		</tr>
		<% while (rs.next()) { %>
		<tr>
			<td><%=rs.getString("event_title") %></td>	
			<td class="num"><%=rs.getString("idx") %></td>	
			<td class="btn_area"><a href="javascript:event_delete('<%=rs.getString("idx")%>');" class="btn_del">이벤트삭제</a></td>	
		</tr>
		<% } 
			rs.close();
			pstmt.close();
		%>
	</table>
</body>
</html>
<script type="text/javascript">
	function event_add() {
		var event_name = document.getElementById("event_name").value;
		if(event_name == null || event_name == "") {
			alert("이벤트 이름을 입력해 주세요.");
			return;
		}
		if (confirm(event_name + "을 추가하시겠습니까?")) {
			location.href = "event_pro.jsp?event_name=" + event_name + "&control=add";
		} else {
			return;
		}
	}
	
	function event_delete(idx) {
		if (confirm("이벤트를 삭제하시겠습니까?")) {
			location.href = "event_pro.jsp?idx=" + idx + "&control=del";
		} else {
			return;
		}
		
	}
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
<%@ include file="/_common/dbclose.jsp" %>