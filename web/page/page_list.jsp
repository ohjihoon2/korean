<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%! public String subject(String str) {
	String res[] = str.split(" ");
	String result = "";
	for(int i = 0; i < res.length; i++) {
		if(i == 1) {
			result = result + "<span class=\"bold\">" + res[i] + "</span>";
		}
		else {
			result = result + res[i];
		}
		if(i != (res.length - 1)) {
			result = result + " ";
		}
	}
	return result;
} %>

<%
	int category = 1;
	try{ category = Integer.parseInt(request.getParameter("category")); } catch( NumberFormatException ex ){ }
	
	String categoryTitle = NewsCategoryDAO.getDAO().getCategoryTitle(category).getName();
	categoryTitle = UtilFunction.removeTag(categoryTitle);
%>
<form name="aform">
	<input type="hidden" name="category" value="<%=category%>">
</form>
<!-- --타이틀-- -->
<h2 class="pt70">
	<%= subject(categoryTitle) %>
</h2>

<!-- --탭메뉴 / a태그 각각의 페이지로 이동-- -->
<ul class="list_tab con_flex mt50 mb10">
	<li class="on"><a href="sub1_list0.html">전체</a></li>
	<li><a href="sub1_list1.html">아 다르고 어 다른 우리말</a></li>
	<li><a href="sub1_list2.html">뭉치가 알려주는 국어 말뭉치</a></li>
	<li><a href="sub1_list3.html">문장 다듬기</a></li>
</ul>

<!-- --리스트-- -->
<div class="list_wrap">
	<ul class="list_con con_flex">
		<li>
			<a href="sub1_page0208_1.html">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/1.jpg" alt="책 그림">
				</div>
				<p class="tit_color">문장 다듬기</p>
				<p class="tit">어려운 표현은 쉽게 모호한 표현은 명료하게 바꿔 써요</p>
				<p class="tit_date">2022. 02. 07.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/2.jpg" alt="회의 그림">
				</div>
				<p class="tit_color">뭉치가 알려주는 국어 말뭉치</p>
				<p class="tit">'말뭉치란 무엇일까요?'</p>
				<p class="tit_date">2022. 02. 07.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/3.jpg" alt="방역 그림">
				</div>
				<p class="tit_color">사전 두 배로 즐기기</p>
				<p class="tit">"한국어기초사전" 120퍼센트 활용하기</p>
				<p class="tit_date">2022. 01. 24.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/4.jpg" alt="친환경 소비 그림">
				</div>
				<p class="tit_color">읽기 좋은 글, 듣기 좋은 말</p>
				<p class="tit">남의 떡은 언제나 언제나 더 크다</p>
				<p class="tit_date">2022. 01. 21.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/5.jpg" alt="하트를 받친 손 그림">
				</div>
				<p class="tit_color">실전 국어 표기법</p>
				<p class="tit">더 나은 새해를 기대하며 '낫다'와 '낳다'</p>
				<p class="tit_date">2022. 01. 21.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/6.jpg" alt="어른과 노인 그림">
				</div>
				<p class="tit_color">실전 국어 표기법</p>
				<p class="tit">아이와 함께하는 공부 '가르치다'와 '가르키다'</p>
				<p class="tit_date">2022. 01. 06.</p>
			</a>
		</li>
	</ul>


	<!-- 더보기로 보여질 리스트 -->

	<ul class="list_con con_flex on">
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/7.jpg" alt="코로나 보도 그림">
				</div>
				<p class="tit_color">사전 두 배로 즐기기</p>
				<p class="tit">한국어 학습자를 위한 사전 국립국어원<한국어기초사전>과 <한국어-외국어학습사전></p>
				<p class="tit_date">2022. 12. 15.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/8.jpg" alt="장소원 원장 사진">
				</div>
				<p class="tit_color">읽기 좋은 글, 듣기 좋은 말</p>
				<p class="tit">이기적인 공감은 없다</p>
				<p class="tit_date">2022. 12. 15.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/1.jpg" alt="책 그림">
				</div>
				<p class="tit_color">문장 다듬기</p>
				<p class="tit">어려운 표현은 쉽게 모호한 표현은 명료하게 바꿔 써요</p>
				<p class="tit_date">2022. 02. 07.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/2.jpg" alt="회의 그림">
				</div>
				<p class="tit_color">뭉치가 알려주는 국어 말뭉치</p>
				<p class="tit">'말뭉치란 무엇일까요?'</p>
				<p class="tit_date">2022. 02. 07.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/3.jpg" alt="방역 그림">
				</div>
				<p class="tit_color">사전 두 배로 즐기기</p>
				<p class="tit">"한국어기초사전" 120퍼센트 활용하기</p>
				<p class="tit_date">2022. 01. 24.</p>
			</a>
		</li>
		<li>
			<a href="#">
				<div class="list_img">
					<div class="add_hover"><img src="images/ico_add.png" alt="더보기"></div>
					<img src="images/2022_2/4.jpg" alt="친환경 소비 그림">
				</div>
				<p class="tit_color">읽기 좋은 글, 듣기 좋은 말</p>
				<p class="tit">남의 떡은 언제나 언제나 더 크다</p>
				<p class="tit_date">2022. 01. 21.</p>
			</a>
		</li>
	</ul>
	<div class="add_btn mt70"><p>+ 더보기</p></div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
var list_page=1;
var is_loadlist = false;
function loadList() {
	var cate = document.aform.category.value;
	if(is_loadlist) {
		return;
	}
	is_loadlist = true;

	var url = "ajax/post_list.jsp?category="+cate+"&page="+list_page;
	
	$.get( url, function(data) {
		$("#post_list").append(data);
		list_page++;
		is_loadlist = false;
	}).fail(function() {
	    is_loadlist = false;
	});
}

window.onload=function() {
	loadList();
}
</script>
