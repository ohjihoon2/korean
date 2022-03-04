<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.urimal365.dto.NewsViewCount"%>
<%@page import="kr.urimal365.dao.NewsViewCountDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="kr.urimal365.dao.NewsDAO"%>
<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dto.Rownum"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="kr.urimal365.dao.NewsViewDAO"%>
<%@page import="kr.urimal365.dto.NewsView"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	int idx = 0;
	try{ 
		idx = Integer.parseInt(request.getParameter("idx")); 
	}
	catch(Exception ex){ 
		out.println("<script>alert('" + "올바른 접근이 아닙니다." + "');</script>");
		out.println("<script>location.href='index.jsp?control=page&part=main';</script>");
		return;
	}
	if( idx <= 0 ) {
		out.println("<script>alert('" + "올바른 접근이 아닙니다." + "');</script>");
		out.println("<script>location.href='index.jsp?control=page&part=main';</script>");
		return;
	}
	
	//////// 카페고리 정보 가져오기 /////////////		
	NewsCategory category = NewsCategoryDAO.getDAO().getCategory(idx);
		
	//관리자 미리보기
	boolean is_preview = session.getAttribute("admin_user_id") != null || "Y".equals(request.getParameter("preview"));
		
	NewsView news = null;
	//게시글정보
	if (is_preview) {
		news = NewsViewDAO.getDAO().getAdminNews(idx);	
	} else {
		news = NewsViewDAO.getDAO().getNews(idx);
	}
	
	if (news == null) {
		out.println("<script>alert('" + "올바른 접근이 아닙니다." + "');</script>");
		out.println("<script>location.href='index.jsp?control=page&part=main';</script>");
		return;
	}

	//조회수 
	if (!is_preview) {
		int i = NewsDAO.getDAO().readNews(idx);
		Calendar currentCalendar = Calendar.getInstance();
		java.text.DecimalFormat df = new java.text.DecimalFormat("00");
		String today = 
				currentCalendar.get(java.util.Calendar.YEAR)
				+"-"+ df.format(currentCalendar.get(Calendar.MONTH)+1)
				+"-"+ df.format(currentCalendar.get(java.util.Calendar.DAY_OF_MONTH));
		
		HashMap<String,Object> param = new HashMap<String,Object>();
		param.put("idx", idx);
		param.put("today", today);
		
		
		int count = -1; 
		count = NewsViewCountDAO.getDAO().getCount(param).getCnt();
		if (count > 0) {
			NewsViewCountDAO.getDAO().updateCount(param);
		} else {
			NewsViewCountDAO.getDAO().insertCount(param);
		}
	}
	
	
	//RowNum
	HashMap<String,Object> rownumMap = new HashMap<String,Object>();
	
	rownumMap.put("categoryIdx", news.getCategoryIdx());
	rownumMap.put("idx", idx);
	
	Rownum rowNum = NewsViewDAO.getDAO().getRowNum(rownumMap);
	
	
	
	int prevIdx = 0;
	int nextIdx = 0;
	
	if (rowNum != null && rowNum.getRownum()>0) {
		HashMap<String,Object> param = new HashMap<String,Object>();

		param.put("rownum", rowNum.getRownum()-1);
		param.put("categoryIdx", news.getCategoryIdx());
		
		HashMap<String,Object> param2 = new HashMap<String,Object>();

		param2.put("rownum", rowNum.getRownum()+1);
		param2.put("categoryIdx", news.getCategoryIdx());
	
		NewsView newsView = null;
		newsView = NewsViewDAO.getDAO().getIdx(param);
		if (newsView != null) { prevIdx = newsView.getIdx(); }
		
		newsView = NewsViewDAO.getDAO().getIdx(param2);
		
		if (newsView != null) { nextIdx = newsView.getIdx(); }
	}
	
	String subheader_bgimg="/images/common/banner_category_old.jpg";
	if (!(news.getDefaultBannerFile() == null || news.getDefaultBannerFile().equals(""))) {
		subheader_bgimg = news.getDefaultBannerFile();
	}
	
	String openDate = news.getWriteDate();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	Date date = df.parse(openDate.substring(0, 10));
	Date date2 = df.parse("2017-02-01");
	
	Calendar c = Calendar.getInstance();
	c.setTime(date);
	Calendar c2 = Calendar.getInstance();
	c2.setTime(date2);
	

	boolean after = c.after(c2);
%>

<div class="contentWrap">
	<div class="contents">
		<div class="pt70"></div>
	<% if (!after) { %>
	<div class="post_visual_tit" style="background:url('<%=subheader_bgimg%>') no-repeat center center; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='<%=subheader_bgimg%>', sizingMethod='scale');">
	<h2>
		<em><%=news.getCategoryName() %></em>
		<div class="tit"><%=news.getTitle() %></div>
	</h2>
	</div>	
	<% } %>
	<% if (!after) { %>
	<div class="post_body">
	<%=news.getContents() %>
	</div>
	<% }  else { %>
	<%=news.getContents() %>
	<% } %>
	<!-- <a href="javascript:event_view(12);">이벤트 참여 버튼</a> -->
	
	</div>
		<div class="reple_old">		
		<%--소셜 댓글 솔루션 disqus 가 들어갑니다.--%>
		<div id="disqus_thread"></div>
		<script>
		/**
		* RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
		* LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
		*/
		/*
		var disqus_config = function () {
		this.page.url = PAGE_URL; // Replace PAGE_URL with your page's canonical URL variable
		this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
		};
		*/
		(function() { // DON'T EDIT BELOW THIS LINE
		var d = document, s = d.createElement('script');

		s.src = '//newskoreangokr.disqus.com/embed.js';

		s.setAttribute('data-timestamp', +new Date());
		(d.head || d.body).appendChild(s);
		})();
		</script>
		<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
	</div>
</div>

<div class="con_with mt100 clearfix">
	<div class="con_bg"></div>
	<h2 class="pt30">함께 보면 좋은 기사</h2>
	<div class="add_btn"><a href="/index.jsp?control=page&part=replay">+ 더 보기<span class="active_hover"></span></a></div>
	<ul class="con_flex mt20">
		<%
			List<NewsView> recentNewsList = NewsViewDAO.getDAO().recentNewsList(news.getCate1());

			for (NewsView recentNews : recentNewsList) {
				String thumnail = recentNews.getDefaultThumbnailFile();
				if (thumnail == null || "".equals("thumnail")) {
					thumnail = "/images/common/thumnail_category_old.jpg";
				}
		%>
		<li>
			<a href="index.jsp?control=page&part=view&idx=<%=recentNews.getIdx() %>">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="<%=thumnail %>" alt="">
				</div>
				<p class="tit_color"><%=recentNews.getCategoryName() %></p>
				<p class="tit"><%=UtilFunction.removeTag(recentNews.getTitle()) %></p>
			</a>
		</li>
		<%	}  %>
	</ul>
</div>

<%--<div class="quick" id="quick">--%>
<%--	<div>--%>
<%--		<% if (nextIdx == 0) { %>--%>
<%--		<a href="javascript:alert('이전 글이 없습니다.');"><img src="img/sub/2021/quickPrev.png" alt=""/><span>이전 글</span></a>--%>
<%--		<% } else { %>--%>
<%--		<a href="index.jsp?control=page&part=view&idx=<%=nextIdx%>"><img src="img/sub/2021/quickPrev.png" alt=""/><span>이전 글</span></a>--%>
<%--		<% } %>--%>
<%--		<% if (prevIdx == 0) { %>--%>
<%--		<a href="javascript:alert('다음 글이 없습니다.');"><img src="img/sub/2021/quickNext.png" alt=""/><span>다음 글</span></a>--%>
<%--		<% } else { %>--%>
<%--		<a href="index.jsp?control=page&part=view&idx=<%=prevIdx%>"><img src="img/sub/2021/quickNext.png" alt=""/><span>다음 글</span></a>--%>
<%--		<% } %>--%>
<%--	</div>--%>
<%--	<a href="#" class="top" title="위로"><img src="img/sub/2021/btn_top.png" alt="위로"></a>--%>
<%--</div>--%>

<script language="javascript" type="text/javascript">
//<![CDATA[
	$('.reLis').slick({
		arrows: false,
		centerMode: true,
		centerPadding: '60px',
		slidesToShow: 5,
		variableWidth: true,
	});

	$('.reportViewBt').on('click',function(){
		if ($(this).hasClass('on')){
			$(this).removeClass('on').find('img').attr('src',$(this).find('img').attr('src').replace('down','up'));
			$('.report').css({
				'height':'auto',
				'padding':'50px 0 0'
			})
			$('.reportList').css({
				'padding':'0 0 80px',
				'margin-bottom':'0'
			})
		}else{
			$(this).addClass('on').find('img').attr('src',$(this).find('img').attr('src').replace('up','down'));
			$('.report').css({
				'height':'0',
				'padding':'0'
			})
			$('.reportList').css({
				'padding':'0',
				'margin-bottom':'30px'
			})
		}
		return false;
	})
//]]>
</script>
<%--<div class="eventPopupWrap" id="eventPop">--%>
<%--	<p class="title"><img src="img/main/eventPopupWrapTitle.png" alt="이벤트 신청"/></p>--%>
<%--	<div class="epw">--%>
<%--		<p class="tit"><strong>이벤트</strong>신청하기</p>--%>
<%--		<div class="epwForm">--%>
<%--			<form method="post" id="upload_form" action="" enctype="multipart/form-data">--%>
<%--			<input type="hidden" id="event_idx" name="idx">--%>
<%--				<p class="w50">--%>
<%--					<span>이름</span>--%>
<%--					<input type="text" class="it " title="" value="" name="name"/>--%>
<%--				</p>--%>
<%--				<p class="w50">--%>
<%--					<span>휴대폰번호</span>--%>
<%--					<input type="text" class="it " title="" value="" name="phone" placeholder="ex)010-1234-1234"/>--%>
<%--				</p>--%>
<%--				<p class="w100p">--%>
<%--					<span>이벤트<br/>정답</span>--%>
<%--					<textarea name="comment" cols="" rows="" title=""></textarea>--%>
<%--				</p>--%>
<%--				<p class="file">--%>
<%--					<span>파일첨부</span>--%>
<%--					<input type="text" class="it" readonly="readonly" title="" value="" id="file_name"/>--%>
<%--					<input type="file" id="upload_file" accept="image/*" name="upload_file" multiple style="display:none"/>--%>
<%--					<button type="button" onclick="javascript:upload_btn();">찾아보기</button>--%>
<%--				</p>--%>
<%--				<p class="buttonArea">--%>
<%--					<button type="button" onclick="javascript:event_submit();"><img src="img/main/bt_ok.png" alt=""/></button>--%>
<%--					<a href="javascript:event_close();"><img src="img/main/bt_cancel.png" alt=""/></a>--%>
<%--				</p>--%>
<%--			</form>--%>
<%--		</div>--%>
<%--		<div class="epwTxt">--%>
<%--			<p class="tit">[개인정보 보호를 위한 동의]</p>--%>
<%--			<p class="txt">--%>
<%--				<span><strong>1) 수집목적 : </strong>상기 이벤트는 국민들의 통일에 대한 관심을 높이기 위해 실시되고 있습니다. 이에 이벤트 참여를 통해 통일에 대해 생각해보는 계기를 만들고, 이벤트 참가자분들이 웹진을 계속 구독할 수 있도록 하고자 합니다.</span>--%>
<%--				<span><strong>2) 수집항목 : </strong>닉네임, 비밀번호, 이메일, 휴대폰번호, 댓글, 비밀댓글 여부, 정보수집동의 여부, 웹진수신동의(구독자 확대를 위해 실시하는 이벤트이므로 개인정보수집 동의시 웹진 수신을 동의한 것으로 간주합니다.)</span>--%>
<%--				<span><strong>3) 이용 : </strong>이벤트 당첨시 경품 발송, 당선작 발표, 웹진 발송</span>--%>
<%--				<span><strong>4) 보유기간 : </strong>경품 수령 확인시까지(1개월), 단 웹진 구독용 정보는 &lt;해지&gt;시까지 이메일만 보유</span>--%>
<%--				<span><strong>5) 정보보호 책임자 : </strong>이벤트 대행사 (주)인포아트 서지민(02-2269-5029)</span>--%>
<%--			</p>--%>
<%--		</div>--%>
<%--	</div>--%>
<%--</div>--%>
<%--<script src="/js/jquery.form.js"></script>--%>
<%--<script>--%>
<%--$("#upload_file").change(--%>
<%--	    function(){--%>
<%--	     val = $(this).val().split("\\");--%>
<%--	     f_name = val[val.length-1]; //마지막 화일명--%>
<%--	     s_name = f_name.substring(f_name.length-4, f_name.length);//확장자빼오기--%>

<%--	     if(s_name.toLowerCase() == '.jpg' || s_name.toLowerCase() == '.png' || s_name.toLowerCase() == '.gif'){//허용 확장자 비교--%>
<%--	      $("#file_name").val(f_name);--%>
<%--	     }else{--%>
<%--	      alert("jpg,png,gif 파일만 선택해 주세요.");--%>
<%--	      return false;--%>
<%--	     }--%>
<%--	  	});--%>

<%--function event_view(idx) {--%>
<%--	var event_idx = document.getElementById("event_idx");--%>
<%--	event_idx.value=idx;--%>
<%--	var event_pop = document.getElementById("eventPop");--%>
<%--	event_pop.style.display="block";--%>
<%--}--%>

<%--function event_close() {--%>
<%--	var event_pop = document.getElementById("eventPop");--%>
<%--	event_pop.style.display="none";--%>
<%--	document.getElementsByName("name")[0].value="";--%>
<%--	document.getElementsByName("phone")[0].value="";--%>
<%--	document.getElementsByName("comment")[0].value="";--%>
<%--	document.getElementById("file_name").value="";--%>
<%--}--%>

<%--function upload_btn() {--%>
<%--	var file = document.getElementById("upload_file");--%>
<%--	file.click();--%>
<%--}--%>

<%--function event_submit() {--%>
<%--	var name = document.getElementsByName("name")[0].value;--%>
<%--	if (name==null || name==""){--%>
<%--		alert("이름을 입력해 주세요.");--%>
<%--		return false;--%>
<%--	}--%>
<%--	var phone = document.getElementsByName("phone")[0].value;--%>
<%--	if (phone==null || phone==""){--%>
<%--		alert("휴대폰번호를 입력해 주세요.");--%>
<%--		return false;--%>
<%--	}--%>
<%--	var comment = document.getElementsByName("comment")[0].value;--%>
<%--	if (comment==null || comment==""){--%>
<%--		alert("정답을 입력해 주세요.");--%>
<%--		return false;--%>
<%--	}--%>
<%--	--%>
<%--	if(confirm("이벤트에 응모 하시겠습니까?")) {--%>
<%--		$("#upload_form").attr("action","/page/event/eventAction.jsp");--%>
<%--		$("#upload_form").submit();--%>
<%--	}--%>
<%--}--%>
<%--</script>--%>