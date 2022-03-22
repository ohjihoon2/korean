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
%>

<div class="contentWrap">
	<div class="contents">
		<div class="pt70"></div>
		<%=news.getContents() %>
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
				if (thumnail == null ||  thumnail.equals("")) {
					thumnail = "/img/common/list_thumnail.jpg";
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

<script type="text/javascript">
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