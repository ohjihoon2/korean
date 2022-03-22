<%@ page import="kr.urimal365.dao.ContentsDAO" %>
<%@ page import="kr.urimal365.dto.Contents" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- -------footer------- -->

<footer>
	<!-- --link-- -->

	<div id="link_site" class="mt150 clearfix">
		<ul>
			<li><a href="https://stdict.korean.go.kr/main/main.do" target="_blank"><img src="images/link_site1.png" alt="표준국어대사전 로고"></a></li>
			<li><a href="https://www.korean.go.kr/front/onlineQna/onlineQnaList.do?mn_id=216" target="_blank">온라인 가나다</a></li>
			<li><a href="https://edu.korean.go.kr/user/index.html" target="_blank"><img src="images/link_site2.png" alt="국어문화학교 로고"></a></li>
			<li><a href="https://www.hangeul.go.kr/webzine/202202/index.html" target="_blank">한박 웃음</a></li>
		</ul>
	</div>

	<!-- --푸터-- -->

	<div id="footer">
		<p class="foot_logo mt30 mb30"><a href="https://www.korean.go.kr/" target="_blank"><img src="images/foot_logo.png" alt="foot_logo"></a></p>
		<p class="line_w"></p>
		<% Contents footer = ContentsDAO.getDAO().getSelectOneBanner("3-4"); %>
		<% if(footer != null) { %>
		<%=footer.getContents() %>
		<% } %>
		<ul class="sns mt30 pb50">
			<li class="mr10"><a href="https://twitter.com/urimal365" target="_blank"><img src="images/ico_twiter.png" alt="트위터"></a></li>
			<li class="mr10"><a href="https://www.facebook.com/urimal365k/" target="_blank"><img src="images/ico_facebook.png" alt="페이스북"></a></li>
			<li class="mr10"><a href="https://blog.naver.com/areumkor" target="_blank"><img src="images/ico_naver.png" alt="네이버 블로그"></a></li>
			<li class="mr10"><a href="https://blog.daum.net/urimal365" target="_blank"><img src="images/ico_daum.png" alt="다음 블로그"></a></li>
			<li class="mr10"><a href="https://www.instagram.com/areumkor/" target="_blank"><img src="images/ico_insta.png" alt="인스타그램"></a></li>
			<li><a href="https://www.youtube.com/channel/UCQEUCVtOyPAozp76V1_Aw0A" target="_blank"><img src="images/ico_youtube.png" alt="유튜브"></a></li>
		</ul>
	</div>
</footer>
</div>

<% if (request.getParameter("part").equals("main")) {
	Contents cont = ContentsDAO.getDAO().getSelectOneBanner("3-5");

	Cookie[] ck = request.getCookies();
	String ckVal = "";
	if(ck != null){
		for(int i = 0; i < ck.length; ++i){
			String key = ck[i].getName();
			if(key != null || key.trim().equals("popupYN")){
				ckVal = ck[i].getValue();
				break;
			}
		}
	}

	if(cont != null && !ckVal.equals('N')) { %>
		<div id="mainPopup" class="main-popup">
			<%=cont.getContents() %>
			<div class="main-popup-foot" >
				<a href="javascript:closePopupCookie(1)">오늘 하루 팝업 닫기</a>
				<a href="javascript:closePopup();">닫기</a>
			</div>
		</div>
		<script>
			function closePopupCookie(day) {
				setCookie('popupYN', 'N' , day);
				$('#mainPopup').hide();
			}

			function closePopup() {
				$('#mainPopup').hide();
			}

			function setCookie(name, value, expiredays) {
				var todayDate = new Date();
				todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				if ( todayDate > new Date() ) {
					expiredays = expiredays - 1;
				}
				todayDate.setDate( todayDate.getDate() + expiredays );
				document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
			}
		</script>

	<% }
} %>

</body>
</html>