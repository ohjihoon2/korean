<%@ page contentType="text/html; charset=UTF-8" %>
      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <li class="header">MAIN NAVIGATION</li>
        
        <%
    			String menu_id = request.getParameter("PageMenuID");			
    		%>
        <li <% if( menu_id.equals("0-1") ) { %>class="active"<% } %>><a href="../user/admin_user_list.jsp"><i class="fa fa-user"></i> <span>관리자 관리</span></a></li>
        <li <% if( menu_id.equals("1-1") ) { %>class="active"<% } %>><a href="../category/category_list.jsp"><i class="fa fa-th-large"></i> <span>카테고리 관리</span></a></li>
        <li <% if( menu_id.equals("6-1") ) { %>class="active"<% } %>><a href="../media/media_list.jsp"><i class="fa fa-file-image-o"></i> <span>미디어 관리</span></a></li>        
        <li <% if( menu_id.equals("2-1") ) { %>class="active"<% } %>><a href="../news/news_list.jsp"><i class="fa fa-list"></i> <span>게시글 관리</span></a></li>        
        <li  <% if( menu_id.equals("3") ) { %>class="active"<% } %>><!--class="treeview"-->
          <a href="../contents/contents_list.jsp"><i class="fa fa-link"></i> <span>컨텐츠 관리</span></a>
		<!--		
          <ul class="treeview-menu">
            <li <% if( menu_id.equals("3-5") ) { %>class="active"<% } %>><a href="../contents/contents_form.jsp?gbn=3-5"><i class="fa fa-circle-o"></i>메인 최상단 팝업 배너</a></li>
            <li <% if( menu_id.equals("3-1") ) { %>class="active"<% } %>><a href="../contents/contents_form.jsp?gbn=3-1"><i class="fa fa-circle-o"></i>메인 퀴즈 베너</a></li>
            <li <% if( menu_id.equals("3-2") ) { %>class="active"<% } %>><a href="../contents/contents_form.jsp?gbn=3-2"><i class="fa fa-circle-o"></i>메인 하단베너1</a></li>
            <li <% if( menu_id.equals("3-3") ) { %>class="active"<% } %>><a href="../contents/contents_form.jsp?gbn=3-3"><i class="fa fa-circle-o"></i>메인 하단베너2</a></li>
            <li <% if( menu_id.equals("3-4") ) { %>class="active"<% } %>><a href="../contents/contents_form.jsp?gbn=3-4"><i class="fa fa-circle-o"></i>푸터</a></li>            
          </ul>
		-->  
        </li>
        <li <% if( menu_id.equals("4-1") ) { %>class="active"<% } %>><a href="../quiz/quiz_list.jsp"><i class="fa fa-star"></i> <span>우리말 달인 관리</span></a></li>
        <li class="treeview">
          <a href="#"><i class="fa fa-newspaper-o"></i> <span>소식지 신청/거부</span> <i class="fa fa-angle-left pull-right"></i></a>          
          <ul class="treeview-menu">
            <li <% if( menu_id.equals("5-1") ) { %>class="active"<% } %>><a href="../reception/reception_list.jsp?gbn=5-1"><i class="fa fa-circle-o"></i>쉼표, 마침표. 수신신청</a></li>
            <li <% if( menu_id.equals("5-2") ) { %>class="active"<% } %>><a href="../reception/reception_list.jsp?gbn=5-2"><i class="fa fa-circle-o"></i>쉼표, 마침표. 수신거부</a></li>            
            <li <% if( menu_id.equals("5-3") ) { %>class="active"<% } %>><a href="../reception/reception_list.jsp?gbn=5-3"><i class="fa fa-circle-o"></i>새국어생활 수신신청</a></li>
            <li <% if( menu_id.equals("5-4") ) { %>class="active"<% } %>><a href="../reception/reception_list.jsp?gbn=5-4"><i class="fa fa-circle-o"></i>새국어생활 수신거부</a></li>            
          </ul>
        </li>
		<li <% if( menu_id.equals("7-1") ) { %>class="active"<% } %>><a href="../event/event_list.jsp"><i class="fa fa-star"></i> <span>이벤트응모현황</span></a></li>
		<li <% if( menu_id.equals("8-1") ) { %>class="active"<% } %>><a href="../cssdb/css_list.jsp"><i class="fa fa-file-code-o"></i> <span>css관리</span></a></li>
      </ul>
      <!-- /.sidebar-menu -->