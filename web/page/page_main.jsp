<%@page import="kr.urimal365.util.UtilFunction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.urimal365.dao.NewsCategoryDAO"%>
<%@page import="kr.urimal365.dto.NewsCategory"%>
<%@page import="kr.urimal365.dao.ContentsDAO"%>
<%@page import="kr.urimal365.dto.Contents"%>
<%@page import="kr.urimal365.dao.NewsViewDAO"%>
<%@page import="kr.urimal365.dto.NewsView"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="contentWrap">
<%--	<div class="remodal modal1" data-remodal-id="modal1" style="width:500px">
		<div class="pop-head">
			<h2>< 안내 글 ></h2>
			<a data-remodal-action="close" class="remodal-close" href="#">
				<span class="hide-text">닫기</span>
			</a>
		</div>
		<img src="/images/notice20211009.jpg" />
		<div class="pop-ft" style="margin-bottom: 0px; padding: 10px;">
			<a href="#" class="btn1 upload todayBtn" style="width:200px">오늘 하루 열지 않음</a>
			<a href="#" class="btn1 upload" style="width:200px" data-remodal-action="close">닫기</a>
		</div>
	</div>
<script>
$(function() {
	//팝업 추가
	var inst = $('[data-remodal-id=modal1]').remodal();
	if(!$.cookie('modal1')){
		inst.open();
	}

	$('.todayBtn').click(function() {
		$.cookie('modal1', 'Y', { expires: 1, path: '/' });
	});
});
</script> --%>
	<div id="pc_mobile_main_con" style="display:none">
		<!-- pc -->
		<div class="kr-contents pc">
			<div class="kr-top-main">
				<div class="kr-full">
					<div class="main_top"><a href="javascript:void(0);"><img src="" alt="" id="pc_top"></a></div>
				</div>
				<div class="kr-two">
					<div class="left">
						<div class="main-slide">
							<div class="slide_1_01"><a href="javascript:void(0);"><img src="" alt="" id="slide_1_01"></a></div>
							<div class="slide_1_02"><a href="javascript:void(0);"><img src="" alt="" id="slide_1_02"></a></div>
						</div>
					</div>
					<div class="right">
						<div class="main-slide">
							<div class="slide_2_01"><a href="javascript:void(0);"><img src="" alt="" id="slide_2_01"></a></div>
							<div class="slide_2_02"><a href="javascript:void(0);"><img src="" alt="" id="slide_2_02"></a></div>
						</div>
						<div class="main-slide">
							<div class="slide_3_01"><a href="javascript:void(0);"><img src="" alt="" id="slide_3_01"></a></div>
							<div class="slide_3_02"><a href="javascript:void(0);"><img src="" alt="" id="slide_3_02"></a></div>
						</div>
					</div>
				</div>
			</div>
			<div class="kr-down-main">
				<div class="kr-two-main">
					<ul>
						<li class="li_main_1_01"><a href="javascript:void(0);"><img src="" alt="" id="pc_main_1_01"></a></li>
						<li class="li_main_1_02"><a href="javascript:void(0);"><img src="" alt="" id="pc_main_1_02"></a></li>
						<li class="li_main_1_03"><a href="javascript:void(0);"><img src="" alt="" id="pc_main_1_03"></a></li>
						<li class="li_main_1_04"><a href="javascript:void(0);"><img src="" alt="" id="pc_main_1_04"></a></li>
						<li class="li_main_1_05"><a href="javascript:void(0);"><img src="" alt="" id="pc_main_1_05"></a></li>
						<li class="li_main_1_06"><a href="javascript:void(0);"><img src="" alt="" id="pc_main_1_06"></a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 모바일 -->
		<div class="kr-contents mobile">
			<div class="kr-top-main">
				<div class="kr-full">
					<div class="main_top"><a href="javascript:void(0);"><img src="" alt="" id="mo_top"></a></div>
				</div>
				<div class="kr-two">
					<div class="left">
						<div class="main-slide">
							<div class="slide_1_01"><a href="javascript:void(0);"><img src="" alt="" id="mo_slide_1_01"></a></div>
							<div class="slide_1_02"><a href="javascript:void(0);"><img src="" alt="" id="mo_slide_1_02"></a></div>
						</div>
					</div>
					<div class="right">
						<div class="main-slide">
							<div class="slide_2_01"><a href="javascript:void(0);"><img src="" alt="" id="mo_slide_2_01"></a></div>
							<div class="slide_2_02"><a href="javascript:void(0);"><img src="" alt="" id="mo_slide_2_02"></a></div>
						</div>
						<div class="main-slide">
							<div class="slide_3_01"><a href="javascript:void(0);"><img src="" alt="" id="mo_slide_3_01"></a></div>
							<div class="slide_3_02"><a href="javascript:void(0);"><img src="" alt="" id="mo_slide_3_02"></a></div>
						</div>
					</div>
				</div>
			</div>
			<div class="kr-down-main">
				<div class="kr-two-main">
					<ul>
						<li class="li_main_1_01"><a href="javascript:void(0);"><img src="" alt="" id="mo_main_1_01"></a></li>
						<li class="li_main_1_02"><a href="javascript:void(0);"><img src="" alt="" id="mo_main_1_02"></a></li>
						<li class="li_main_1_03"><a href="javascript:void(0);"><img src="" alt="" id="mo_main_1_03"></a></li>
						<li class="li_main_1_04"><a href="javascript:void(0);"><img src="" alt="" id="mo_main_1_04"></a></li>
						<li class="li_main_1_05"><a href="javascript:void(0);"><img src="" alt="" id="mo_main_1_05"></a></li>
						<li class="li_Main_1_06"><a href="javascript:void(0);"><img src="" alt="" id="mo_main_1_06"></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="kr-contents kr-foo-main">
			<div class="kr-full">
				<div class="pc"><a href="javascript:void(0);"><img src="" alt="" id="pc_main_1_07"></a></div>
				<div class="mobile"><a href="javascript:void(0);"><img src="" alt="" id="mo_main_1_07"></a></div>
			</div>
		</div>
	</div>
	<div>
		<a href="index.jsp?control=page&part=view&idx=13112">test</a>
	</div>
</div>