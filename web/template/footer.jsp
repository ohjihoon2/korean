<%@page import="kr.urimal365.dao.ContentsDAO"%>
<%@page import="kr.urimal365.dto.Contents"%>
<%@page import="kr.urimal365.dto.Media"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 소식지팝업 -->
<div id="newsletters_poppup" style="display:none;">
	<div class="newsletters_poppup">
		<ul class="popup_tabmenu">
			<li class="current"><a href="#newsletter_tab01">수신 신청</a></li>
			<li><a href="#newsletter_tab02">수신 거부</a></li>
		</ul>

		<div class="popup_tabcont_wrap">

			<!-- 수신 신청 -->
			<div id="newsletter_tab01" class="popup_tab_content">
				<form name="reception5_1" method="POST">
				<input type="hidden" name="gbn" value="5-1"/>
				<input type="hidden" name="receipt_gbn" value="Y"/>
				<div class="popup_section">
					<div class="popup_tit"><strong>쉼표, 마침표.</strong> 수신 신청</div>
					<ul class="popup_form_layout">
						<li class="half">
							<label for="">이름</label>
							<input type="text" id="name" name="name" placeholder="이름을 입력해 주세요" />
						</li>
						<li class="half">
							<label for="" class="fn">전자 우편</label>
							<input type="text" id="email" name="email" placeholder="전자 우편 주소를 입력해 주세요" />
						</li>
					</ul>
					<p><label for="">국립국어원 온라인 소식지 ≪쉼표, 마침표.≫ 수신을 신청합니다.</label> <input type="checkbox" id="check1" name="check1" value="Y"/></p>
					<p><label for="">온라인 소식지 외에 국어(원) 관련 소식 수신을 신청합니다.</label> <input type="checkbox" id="check2" name="check2" value="Y" /></p>
					<div class="popup_btns">
						<a href="javascript:submitReception5_1();" class="black"><i class="fa fa-check" aria-hidden="true"></i> <span>신청하기</span></a>
						<a href="javascript:hideReception();" class="white">취소</a>
					</div>
				</div>
				</form>
				
				<form name="reception5_3" method="POST">
				<input type="hidden" name="gbn" value="5-3"/>
				<input type="hidden" name="receipt_gbn" value="Y"/>
				<div class="popup_section">
					<div class="popup_tit"><strong>새국어생활</strong> 정기 구독 신청(우편 발송)</div>
					<ul class="popup_form_layout">
						<li class="half">
							<label for="">이름</label>
							<input type="text" id="name" name="name" placeholder="이름을 입력해 주세요" />
						</li>
						<li class="half">
							<label for="" class="fn">전자 우편</label>
							<input type="text"  id="email" name="email" placeholder="전자 우편 주소를 입력해 주세요" />
						</li>
						<li>
							<label for="">주소</label>
							<div class="address">
								<input type="text" id="post" name="post" placeholder="우편 번호를 입력해 주세요" /><br />
								<input type="text" id="address" name="address" placeholder="도로명 주소를 입력해 주세요" style="width:100%;" />
							</div>
						</li>
					</ul>
					<p><label for="">국립국어원 계간지 새국어생활 정기 구독을 신청합니다.</label> <input type="checkbox" id="check1" name="check1" value="Y" /></p>
					<div class="popup_btns">
						<a href="javascript:submitReception5_3();" class="black"><i class="fa fa-check" aria-hidden="true"></i> <span>신청하기</span></a>
						<a href="javascript:hideReception();" class="white">취소</a>
					</div>
				</div>
				</form>

			</div>

			<!-- 수신 거부 -->
			<div id="newsletter_tab02" class="popup_tab_content" style="display:none;">
				
				<form name="reception5_2" method="POST">
				<input type="hidden" name="gbn" value="5-2"/>
				<input type="hidden" name="receipt_gbn" value="N"/>
				<div class="popup_section">
					<div class="popup_tit"><strong>쉼표, 마침표.</strong> 수신 거부 신청</div>
					<ul class="popup_form_layout">
						<li>
							<label for="">전자 우편</label>
							<input type="text" id="email" name="email" placeholder="전자 우편 주소를 입력해 주세요" />
						</li>
					</ul>
					<p><label for="">국립국어원 온라인 소식지 ≪쉼표, 마침표.≫ 수신을 거부합니다</label> <input type="checkbox" id="check1" name="check1" value="Y" /></p>
					<p><label for="">온라인 소식지 외에 국어(원) 관련 소식 수신을 거부합니다.</label> <input type="checkbox" id="check2" name="check2" value="Y" /></p>
					<div class="popup_btns">
						<a href="javascript:submitReception5_2();" class="black"><i class="fa fa-check" aria-hidden="true"></i> <span>확인</span></a>
						<a href="javascript:hideReception();" class="white">취소</a>
					</div>
				</div>
				</form>
				

				<form name="reception5_4" method="POST">
				<input type="hidden" name="gbn" value="5-4"/>
				<input type="hidden" name="receipt_gbn" value="N"/>
				<div class="popup_section">
					<div class="popup_tit"><strong>새국어생활</strong> 정기 구독 거부 신청(우편 발송)</div>
					<ul class="popup_form_layout">
						<li class="half">
							<label for="">이름</label>
							<input type="text" id="name" name="name" placeholder="이름을 입력해 주세요" />
						</li>
						<li class="half">
							<label for="" class="fn">전자 우편</label>
							<input type="text" id="email" name="email" placeholder="전자 우편 주소를 입력해 주세요" />
						</li>
						<li>
							<label for="">주소</label>
							<div class="address">
								<input type="text" id="post" name="post" placeholder="우편 번호를 입력해 주세요" /><br />
								<input type="text" id="address" name="address" placeholder="도로명 주소를 입력해 주세요" style="width:100%;" />
							</div>
						</li>
					</ul>
					<p><label for="">국립국어원 계간지 ≪새국어생활≫ 정기 구독 수신을 거부합니다.</label> <input type="checkbox" id="check1" name="check1" value="Y" /></p>
					<div class="popup_btns">
						<a href="javascript:submitReception5_4();" class="black"><i class="fa fa-check" aria-hidden="true"></i> <span>확인</span></a>
						<a href="javascript:hideReception();" class="white">취소</a>
					</div>
				</div>
				</form>

			</div>

		</div>
	</div>
</div>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="/js/jquery.popup.min.js"></script>
<script src="/js/jquery.word-break-keep-all.min.js"></script>
<script src="/_js/common.js"></script>
<script>
	function submitReception5_1()
	{
		var f = document.reception5_1;
		if(CheckEmpty(f.name,"이름을 입력해 주세요.")) return;
		if(CheckEmpty(f.email,"전자 우편 주소를 입력해 주세요.")) return;
		if(CheckCount(f.check1,"수신 동의 체크란에 체크 해 주시기 바랍니다.")) return;

		f.action="/page/newsletter_receipt_pro.jsp";
		f.submit();
	}

	function submitReception5_2()
	{
		var f = document.reception5_2;
		if(CheckEmpty(f.email,"전자 우편 주소를 입력해 주세요.")) return;
		if(CheckCount(f.check1,"수신 거부 체크란에 체크 해 주시기 바랍니다.")) return;
		
		f.action="/page/newsletter_receipt_pro.jsp";
		f.submit();
	}

	function submitReception5_3()
	{
		var f = document.reception5_3;
		if(CheckEmpty(f.name,"이름을 입력해 주세요.")) return;
		if(CheckEmpty(f.email,"전자 우편 주소를 입력해 주세요.")) return;
		if(CheckEmpty(f.post,"우편 번호를 입력해 주세요.")) return;
		if(CheckEmpty(f.address,"도로명 주소를 입력해 주세요.")) return;
		if(CheckCount(f.check1,"수신 동의 체크란에 체크 해 주시기 바랍니다.")) return;
		
		f.action="/page/newsletter_receipt_pro.jsp";
		f.submit();
	}

	function submitReception5_4()
	{
		var f = document.reception5_4;
		if(CheckEmpty(f.name,"이름을 입력해 주세요.")) return;
		if(CheckEmpty(f.email,"전자 우편 주소를 입력해 주세요.")) return;
		if(CheckEmpty(f.post,"우편 번호를 입력해 주세요.")) return;
		if(CheckEmpty(f.address,"도로명 주소를 입력해 주세요.")) return;
		if(CheckCount(f.check1,"수신 거부 체크란에 체크 해 주시기 바랍니다.")) return;
		
		f.action="/page/newsletter_receipt_pro.jsp";
		f.submit();
	}

	function hideReception()
	{		
		popup1.close();
	}
</script>
<div class="footerWrap">
	<div class="footMenu">
		<div class="inner">
			<ul class="">
				<li><a href="http://stdweb2.korean.go.kr/main.jsp" target="_balnk">표준국어대사전</a></li>
				<li><a href="http://www.korean.go.kr/front/onlineQna/onlineQnaList.do?mn_id=61" target="_balnk">온라인 가나다</a></li>
				<li><a href="http://edu.korean.go.kr/servlet/controller.homepage.MainServlet" target="_balnk">국어문화학교</a></li>
				<li><a href="http://www.urimal.kr/urimal/index.jsp" target="_balnk">안녕! 우리말</a></li>
				<li><a href="http://blog.naver.com/areumkor" target="_balnk">이렇게 다듬었어요</a></li>
				<li class="point"><a href="index.jsp?control=page&part=replay">소식지 다시 보기</a></li>
			</ul>
		</div>
	</div>
	<div class="footer">
		<div class="inner">
			<p class="footLogo"><a href="http://www.korean.go.kr/" target="_blank"><img src="img/common/footLogo.png" alt=""/></a></p>
			<%
			 	Contents footer = ContentsDAO.getDAO().getSelectOneBanner("3-4");
			%>
			<%--footer.getContents() --%> 
			<p class="address">
				<%=footer.getContents() %>
			</p>
			 
		</div>
	</div>
</div>
