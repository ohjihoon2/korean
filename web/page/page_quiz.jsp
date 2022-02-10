<%@page import="kr.urimal365.dto.QuizQuestion"%>
<%@page import="java.util.List"%>
<%@page import="kr.urimal365.dao.QuizViewDAO"%>
<%@page import="kr.urimal365.dto.QuizView"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xml:lang="ko" lang="ko">
<%
	int idx = 0;
	try{ idx = Integer.parseInt(request.getParameter("idx")); } catch( NumberFormatException ex ){}

	int totalpplayCount = QuizViewDAO.getDAO().applyCount().getCnt();
	
	boolean is_preview = session.getAttribute("admin_user_id") != null || "Y".equals(request.getParameter("preview"));
	
	QuizView quiz = null;
	
	if (idx > 0 && is_preview) {
		quiz = QuizViewDAO.getDAO().previewQuiz(idx);		
	} else {
		quiz = QuizViewDAO.getDAO().getQuiz();
	}
	
%>
<html>
<body class="kr-quizwrapper">
	<div class="kr-quizwrap quiz_body">
		<!-- 우리말 달인 타이틀 -->
		<div class="quiz_tit">
			<strong><%=quiz.getYm()%></strong>
			<div><img src="/images/quiz/quiz_tit.png" alt="우리말 달인" /></div>
			<p>
				<%--
				어느덧 한 해의 절반이 지나갔습니다.<br />
				올해 1월에 계획한 일들은 잘 지켜 가고 있나요?<br />
				다소 더디게 진행되더라도 조바심 내지 말고 차근차근 해 나가세요!<br />
				잠시 쉬면서 우리말 달인 문제를 풀어 보는 것도 좋겠지요.<br />
				7월의 우리말 달인, 시작합니다!
				--%>
				<%=quiz.getDescription()%>
			</p>
		</div>
		
		<!-- 퀴즈 전체 영역-->
		<form name="aform" method="POST">
		<input type="hidden" name="quiz_idx" id="quiz_idx" value="<%="" + quiz.getIdx()%>"/>
		<input type="hidden" name="quiz_apply_idx" id="quiz_apply_idx" value=""/>
		<input type="hidden" name="final_grade" id="final_grade" value=""/>
		
		<div class="quiz_body_wrap">
			
			<!-- 이용현황 -->
			<div class="status"><strong><%=totalpplayCount%></strong> 명이 우리말 달인에 참여하였습니다.</div>
			
			<!-- 퀴즈 풀이 전체 영역 -->
			<div class="quiz_board">
		
				<!-- 마스코트 이미지 -->
				<img src="/images/quiz/bg_mascot01.png" alt="" class="mascot01" />
				<img src="/images/quiz/bg_mascot02.png" alt="" class="mascot02" />
				
				<!-- 퀴즈 대기 상태 -->
				<div id="quiz_wait" class="quiz_wait">
					
					<div class="wait_tit"><strong class="blue">‘바른 말’</strong>과 <strong class="red">‘틀린 말’</strong>을 골라 주세요!</div>
		
					<p>1문제당 10초씩 총 10문제를 풀어 주셔야 응모가 가능합니다.</p>
		
					<a href="javascript:requestQuizStart();"><img src="/images/quiz/btn_quiz_start.png" alt="퀴즈 풀기" /></a>
					
				</div>
				
				<!-- 퀴즈 시작 상태 -->			
				<div id="quiz_start" class="quiz_start" style="display:none;">
		
					<!-- 문제 -->
					<%
						List<QuizQuestion> questionList = QuizViewDAO.getDAO().quizQuestionList(quiz.getIdx());
						boolean result = false;
						int i = 0;
						for (QuizQuestion question : questionList ){
					%>
					<input type="hidden" name="right_answer<%=i%>" id="right_answer<%=i%>" value="<%=question.getRightAnswer()%>"/>
					<input type="hidden" name="answer<%=i%>" id="answer<%=i%>" value=""/>
					<input type="hidden" name="result<%=i%>" id="result<%=i%>" value=""/>
					<div class="question" id="quiz<%=i%>" style="display:none;">
						<p class="type"><%=question.getNum()%>.<%=question.getTitle()%></p>
						<p class="txt"><%=question.getSubtitle()%></p>
					</div>
					<%
						i++; }
					%>
					<!-- 정답 -->
					<div class="answer">
						<div class="o"><a href="javascript:onAnswer('O');"><img src="/images/quiz/btn_o.png" alt="맞다" /></a></div>						
							<!-- 제한 시간 -->
							<dl class="time_limit">
								<dt>제한 시간</dt>
								<dd><img id="img_second" src="/images/quiz/No05.png" alt="5" /></dd>
							</dl>
						<div class="x"><a href="javascript:onAnswer('X');"><img src="/images/quiz/btn_x.png" alt="아니다" /></a></div>
					</div>
					
					<!-- 획득점수 -->
					<dl class="scoreboard">
						<dt>획득 점수</dt>
						<dd class="ico">
							<% 
								int j = 0;
								for(QuizQuestion question : questionList){ 
							%>
							<%--
							<span class="correct"></span>
							<span class="incorrect"> </span>
							--%>
							<span id="answer_correct<%=i%>" class="empty"></span>
							<% i++; } %>						
						</dd>
					</dl>
				</div>			
			</div>
			<!-- //퀴즈 풀이 영역 -->
			
			<!-- 퀴즈 도움말 -->
			<div class="quiz_bottom_txt">
				<p class="tips">10초 안에 동그라미표 또는 가위표를 선택해 주세요.</p>
		
				<div class="score_info ico">
					<span class="correct"></span> <strong>정답</strong>
					<span class="incorrect"></span> <strong>오답</strong>
				</div>
			</div>
		
			<!-- 정답 팝업 -->
			<div id="quiz_popup_correct" class="quiz_popup correct">
				<div class="quiz_popup_inner">
					<strong class="ox_tit">정답입니다.</strong>
					<div class="mascot"><a href="javascript:goNextQuiz();"><img src="/images/quiz/correct.png" alt="정답" /></a></div>
				</div>
			</div>
		
			<!-- 오답 팝업 -->
			<div id="quiz_popup_incorrect" class="quiz_popup incorrect">
				<div class="quiz_popup_inner">
					<strong class="ox_tit">틀렸습니다.</strong>
					<div class="mascot"><a href="javascript:goNextQuiz();"><img src="/images/quiz/incorrect.png" alt="오답" /></a></div>
				</div>
			</div>
		
			<!-- 결과 팝업 -->
			<div id="quiz_popup_result" class="quiz_popup result">
				<div class="quiz_popup_inner">
					<div class="popup_logo"><img src="/images/quiz/popup_logo.png" alt="쉼표 마침표. 우리말 달인" /></div>
					<div id="popup_score" class="popup_score">0점</div>
					<div id="result_txt1" class="result_txt" style="display:none">당신은 우리말을 사랑하는 진짜 <strong class="blue">달인!</strong></div>
					<div id="result_txt2" class="result_txt" style="display:none">혹시 당신은 걸어 다니는 국어사전?</div>
					<div id="result_txt3" class="result_txt" style="display:none">≪쉼표, 마침표.≫와 함께 우리말을 더 열심히<br /> 공부해 볼까요?</div>
					<div id="result_txt4" class="result_txt" style="display:none">분발하세요. 세종대왕님이 <strong>보고 계셔요!</strong></div>
					<div id="result_txt5" class="result_txt" style="display:none">당신을 우리말 파괴자로 임명합니다!</div>
					<div id="mascot1" class="mascot" style="display:none"><img src="/images/quiz/rating01.png" alt="최상" /></div>
					<div id="mascot2" class="mascot" style="display:none"><img src="/images/quiz/rating02.png" alt="상" /></div>
					<div id="mascot3" class="mascot" style="display:none"><img src="/images/quiz/rating03.png" alt="중" /></div>
					<div id="mascot4" class="mascot" style="display:none"><img src="/images/quiz/rating04.png" alt="하" /></div>
					<div id="mascot5" class="mascot" style="display:none"><img src="/images/quiz/rating05.png" alt="최하" /></div>
					<div class="popup_btns">
						<button onclick="resultShareFacebook(); return false;" class="facebook"><i class="fa fa-facebook" aria-hidden="true"></i> <span>공유하기</span></button>
						<button onclick="viewRightAnswer(); return false;"><i class="fa fa-list-alt" aria-hidden="true"></i> <span>해설 보기</span></button>
						<button onclick="window.location='quiz.jsp'; return false;"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i> <span>다시 도전하기</span></button>
						<button onclick="viewApplication(); return false;"><i class="fa fa-check" aria-hidden="true"></i> <span>응모하기</span></button>
					</div>
				</div>
			</div>
		
			<!-- 응모 팝업 -->
			<div id="quiz_popup_application" class="quiz_popup application">
				<div class="quiz_popup_inner">
					<div class="popup_logo"><img src="/images/quiz/popup_logo.png" alt="쉼표 마침표. 우리말 달인" /></div>
					<dl class="quiz_input">
						<dt>이름 :</dt>
						<dd><input type="text" name="application_name" id="application_name" placeholder="이름을 입력해 주세요." /></dd>
					</dl>
					<dl class="quiz_input">
						<dt>휴대전화 :</dt>
						<dd><input type="text" name="application_phone" id="application_phone" placeholder="휴대전화 번호를 입력해 주세요." /></dd>
					</dl>
					<dl class="quiz_input">
						<dt>이메일 :</dt>
						<dd><input type="text" name="application_email" id="application_email" placeholder="전자 우편 주소를 입력해 주세요." /></dd>
					</dl>
					<div class="agree_txt">
						<strong>1. 개인 정보의 수집 및 이용 목적</strong><br />
						- 서비스 이용 시 본인의 확인<br /><br />
		
						<strong>2. 수집하려는 개인 정보의 항목</strong><br />
						- 이름, 이메일, 모바일 전화번호<br />
						 * 수집한 개인 정보는 당첨자 안내에 활용됩니다.<br /><br />
		
						<strong>3. 개인 정보의 보유 및 이용 기간</strong><br />
						- 입력하신 개인 정보는 1년간 보유·이용됩니다.<br /><br />
		
						<strong>4. 동의거부권 및 동의 거부에 따른 불이익</strong><br />
						- 가입자는 개인 정보 수집•이용에 대하여 거부할 수 있는 권리가 있습니다. 단, 이에 대한 동의를 거부할 경우에는 당첨자 선발 대상으로 선정되지 않습니다.
						
						<br><br>
						<strong>5. 상품 발송</strong><br>
						- 상품은 당첨자에 한해서 지급됩니다. 응모 시 입력한 전화번호로 상품이 발송되며, 전화번호를 잘못 기입하여 상품을 수령하지 못할 경우 다시 지급되지 않습니다.
						
					</div>
					<div class="quiz_popup_check"><input type="checkbox" name="agree_yn" id="agree_yn" value="Y"/> <label for="agree"> 개인 정보 처리 방침을 확인하였으며, 이에 동의합니다.</label></div>
					<div class="popup_btns">
						<button onclick="backResult('quiz_popup_application'); return false;"><i class="fa fa-backward" aria-hidden="true"></i> <span>돌아가기</span></button>
						<button onclick="submitApplication(); return false;"><i class="fa fa-check" aria-hidden="true"></i> <span>제출하기</span></button>
					</div>
				</div>
			</div>
		
			<!-- 해답 팝업 -->
			<div id="quiz_popup_explanation" class="quiz_popup explanation">
				<div class="quiz_popup_inner">
					<div class="popup_logo"><img src="/images/quiz/popup_logo.png" alt="쉼표 마침표. 우리말 달인" /></div>
					<div class="tit">정답 확인</div>
					
					<div class="explanation_list">
						<%
							for( QuizQuestion question : questionList ){
						%>
						<dl>
							<dt><%=question.getNum()%>. <strong class="<%=("O".equals(question.getRightAnswer()))?"correct":"incorrect"%>"><%=question.getRightAnswer()%></strong></dt>
							<dd><%=question.getContents()%></dd>
						</dl>
						<%
							}
						%>
					</div>
		
					<div class="popup_btns">
						<button onclick="backResult('quiz_popup_explanation'); return false;"><i class="fa fa-backward" aria-hidden="true"></i> <span>돌아가기</span></button>
						<button><i class="fa fa-thumbs-o-up" aria-hidden="true"></i> <span>다시 도전하기</span></button>
					</div>
				</div>
			</div>
			
		</div>
		<input type="hidden" name="quiz_current_idx" id="quiz_current_idx" value="0"/>
		<input type="hidden" name="quiz_cnt" id="quiz_cnt" value="<%=questionList.size()%>"/>
		</form>
		<!-- //퀴즈 전체 영역-->
		
		<!-- 읽어주세요 -->
		<div class="quiz_readme">
			<%=quiz.getContents()%>
		</div>
		
		<!--dummy-->
		<div id="dummy" style="display:none;"></div>
		<script src="/_js/common.js"></script>
		<script>
			var is_loadlist = false;
			function requestQuizStart()
			{			
				var f = document.aform;
				var quiz_idx = f.quiz_idx.value;
		
				if( is_loadlist ) return; 
				is_loadlist = true;
				
				var url = "ajax/quiz_start.jsp?quiz_idx="+quiz_idx;			
		
				$.get( url, function(data) {			 				
					$("#dummy").html(data);
					is_loadlist = false;
				}).fail(function() {
				    is_loadlist = false;
				});
			}
		
			function onQuizStart(quiz_apply_idx)
			{			
				var f = document.aform;
				f.quiz_apply_idx.value = quiz_apply_idx;
		
				$("#quiz_wait").hide();
				$("#quiz_start").show();
				onQuiz(0);
			}
			
			function onQuiz( idx,seq ) 
			{
				//현재 idx와 다른 경우 종료			
				if( $("#quiz_current_idx").val() != idx ) { return; }
		
				if( seq == undefined ) { seq=10; }
		
		
				var f = document.aform;
		
				//마지막 문항 이후 결과 보여주기
				var quiz_cnt = parseInt(f.quiz_cnt.value);			
				if( idx+1 > quiz_cnt) {
					calcGrade();				
					return; 
				}
		
				var selvalue = $("#answer"+idx).val();			
		
				if( selvalue=="" ) {
					if( seq > 0 ) {				
						setTimeout( function(){ onQuiz(idx, seq-1 ); },1000);			
						$("#img_second").attr("src","/images/quiz/No0"+seq+".png");			
					}		
					
					for( var i=0; i<quiz_cnt; i++ ){
						$("#quiz"+i).hide();	
					}
					if( !$("#quiz"+idx).is(":visible") ) { $("#quiz"+idx).show(); }
		
								
					if( seq == 0 ) { //틀림처리
						onIncorrect( idx );
					}
				}
			}
		
			function onAnswer( gbn )
			{
				var f = document.aform;
				var idx = parseInt(f.quiz_current_idx.value);
				$("#answer"+idx).val(gbn);			
				if( gbn==$("#right_answer"+idx).val() ){
					onCorrect( idx );
				} else {
					onIncorrect( idx );
				}
			}
		
			function goNextQuiz( )
			{
				$("#quiz_popup_correct").removeClass("show");
				$("#quiz_popup_incorrect").removeClass("show");
		
				var f = document.aform;
				var idx = parseInt(f.quiz_current_idx.value);
		
				//현재 인덱스 번호 저장
				$("#quiz_current_idx").val(idx+1);
		
				onQuiz(idx+1);
			}
		
		
		
			function onCorrect( idx ){
				$("#result"+idx).val("Y");			
				$("#quiz_popup_correct").addClass("show");
				$("#answer_correct"+idx).removeClass("empty");
				$("#answer_correct"+idx).addClass("correct");
		
				<%--3초 지나면 다음으로 넘어가는거 클릭하면 넘어가는거 하고 같이 쓰기 어려 움 해당 뷰가 없는(보이지 않는 경우만 실행하도록 조건이 필요함)--%>
				//setTimeout( function(){ goNextQuiz(); }, 3000);			
			}
		
			function onIncorrect( idx ){					
				$("#result"+idx).val("N");			
				$("#quiz_popup_incorrect").addClass("show");
				$("#answer_correct"+idx).removeClass("empty");
				$("#answer_correct"+idx).addClass("incorrect");			
		
				<%--3초 지나면 다음으로 넘어가는거 클릭하면 넘어가는거 하고 같이 쓰기 어려 움 해당 뷰가 없는(보이지 않는 경우만 실행하도록 조건이 필요함)--%>
				//setTimeout( function(){ goNextQuiz(); }, 3000);			
			}
		
			function calcGrade()
			{
				var f = document.aform;
				var quiz_cnt = parseInt(f.quiz_cnt.value);			
				var sum=0;
				for( var i=0; i<quiz_cnt; i++) {
					if( $("#result"+i).val() == "Y" ) { sum++; }
				}
				
				var grade=5;
				if( sum >= 10 ) {
					grade=1;
				} else if( sum >= 8 ) {
					grade=2;
				} else if( sum >= 5 ) {
					grade=3;
				} else if( sum >= 3 ) {
					grade=4;
				} else {
					grade=5;
				}
							
		
				f.final_grade.value = grade;						
				var quiz_apply_idx = f.quiz_apply_idx.value;
				var url = "ajax/quiz_end.jsp?quiz_apply_idx="+quiz_apply_idx+"&score="+sum+"&grade="+grade;			
		
				$.get( url, function(data) {			 				
					$("#result_txt"+grade).show();
					$("#mascot"+grade).show();
					
					$("#popup_score").html(sum+"점");
					$("#quiz_popup_result").addClass("show");
		
					is_loadlist = false;
				}).fail(function() {
				    is_loadlist = false;
				});
			}
		
			function viewRightAnswer()
			{
				$("#quiz_popup_explanation").addClass("show");
			}
		
			function viewApplication()
			{			
				$("#quiz_popup_application").addClass("show");
			}
		
			function submitApplication()
			{			
				var f = document.aform;
			
				if(CheckEmpty(f.application_name, "이름을 입력해 주세요.")) return;
				if(CheckEmpty(f.application_phone, "휴대전화 번호를 입력해 주세요.")) return;
				if(CheckEmpty(f.application_email, "전자 우편 주소를 입력해 주세요.")) return;
				if(CheckCount(f.agree_yn, "개인 정보 처리 방침에 동의해 주세요."))return;
		
				f.action="page/quiz_application_pro.jsp"; 
				f.submit();
			}
		
			function backResult( lid ){			
				$("#"+lid).removeClass("show");			
				$("#quiz_popup_result").addClass("show");			
			}
		</script>
		
		
		<script>			    
		 	//real appid: 417122328302013
		 	<%
		 		String facebook_appid = "";
		 		if( "220.120.99.66".equals(request.getServerName()) ){ 
		 			facebook_appid = "1292467600767477";  //개발서버 및 test id
		 		} else {
		 			facebook_appid = "417122328302013";
		 		}
		 	%>
			window.fbAsyncInit = function() {  	  	
			    FB.init({
			      appId      : '<%=facebook_appid%>',
			      xfbml      : true,
			      version    : 'v2.6'
			    });
			};
		
			(function(d, s, id){
		     var js, fjs = d.getElementsByTagName(s)[0];
		     if (d.getElementById(id)) {return;}
		     js = d.createElement(s); js.id = id;
		     js.src = "//connect.facebook.net/en_US/sdk.js";
		     fjs.parentNode.insertBefore(js, fjs);
		   	}(document, 'script', 'facebook-jssdk'));
		
		
			function resultShareFacebook()
			{
				var f = document.aform;
				var grade = f.final_grade.value;		
		
				var imageurl = "";
				var description = "우리말 달인 응답 결과";
				var caption = "";
		
				if(grade=="1") {
					imageurl="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/images/quiz/facebook_rating01.png";
					caption=$("#result_txt1").text();
				} else if(grade=="2") {
					imageurl="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/images/quiz/facebook_rating02.png";
					caption=$("#result_txt2").text();
				} else if(grade=="3") {
					imageurl="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/images/quiz/facebook_rating03.png";
					caption=$("#result_txt3").text();
				} else if(grade=="4") {
					imageurl="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/images/quiz/facebook_rating04.png";
					caption=$("#result_txt4").text();
				} else {
					imageurl="http://<%=request.getServerName()%>:<%=request.getServerPort()%>/images/quiz/facebook_rating05.png";
					caption=$("#result_txt5").text();
				}
		
				FB.ui(
				{
				  method: 'share',			  
				  picture: imageurl,
				  caption: caption,
				  description: description,			  
				  href: document.URL
				}, function(response){});
			}
		</script>
	</div>
</body>

</html>