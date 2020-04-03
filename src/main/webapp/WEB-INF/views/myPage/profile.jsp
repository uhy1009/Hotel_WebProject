<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 정보</title>
<%
String error = request.getParameter("error");
String success = request.getParameter("success");
%>
<script>
$(document).ready(function() {
// 유저 삭제 처리	
   $('#deleteUser').on('click', function() {
	if(confirm("아이디를 삭제 하시겠습니까?")){
		if(document.updateForm.password.value != document.updateForm.password_confirm.value){
			$('#updateMsg').hide();
			$('#password').val("");
			$('#password_confirm').val("");
			$('#password').focus();
			$('#checkMsg').html('<p style="color:red" align="center">입력한 비밀번호가 서로 다릅니다.</p>');
		}else{
		$.ajax({
			async: true,
			type : 'POST',
			url : 'deleteUser.do',
			data: {"insertPw" : $('#password').val()},
			success : function(data){
				if (data) {
					alert("아이디가 삭제 되었습니다.");
					window.location.replace("index.do");
				}else{
					$('#updateMsg').hide();
					$('#password').val("");
					$('#password_confirm').val("");
					$('#password').focus();
					$('#checkMsg').html('<p style="color:red" align="center">패스워드를 확인 하세요.</p>');
					}
				}
			});
		}
	}
});
// 매니저 권한 요청 처리
  $('#roleUpdate').on('click', function() {
	if(confirm("매니저 권한을 요청하시겠습니까?")){
		if(document.updateForm.password.value != document.updateForm.password_confirm.value){
			$('#updateMsg').hide();
			$('#password').val("");
			$('#password_confirm').val("");
			$('#password').focus();
			$('#checkMsg').html('<p style="color:red" align="center">입력한 비밀번호가 서로 다릅니다.</p>');
		}else{
		$.ajax({
			async: true,
			type : 'POST',
			url : 'managerRequest.do',
			data: {"insertPw" : $('#password').val()},
			success : function(data) {
				if (data) {
					alert("권한 요청 메시지를 전송했습니다.");
					window.location.replace("profile.do");
				}else{
					$('#updateMsg').hide();
					$('#password').val("");
					$('#password_confirm').val("");
					$('#password').focus();
					$('#checkMsg').html('<p style="color:red" align="center">패스워드를 확인 하세요.</p>');
					}
				}
			});
		}
  	}
});
// 비밀번호 변경 폼 출력	
  $('#showUpdatePwForm').on('click', function() {
	if(confirm("비밀번호를 변경 하시겠습니까?")){
		if(document.updateForm.password.value != document.updateForm.password_confirm.value){
			$('#updateMsg').hide();
			$('#checkMsg').html('<p style="color:red" align="center">입력한 비밀번호가 서로 다릅니다.</p>');
		}else{
		$.ajax({
			async: true,
			type : 'POST',
			url : 'showUpdatePwForm.do',
			data: {"oldPw" : $('#password').val()},
			success : function(data) {
				if (data) {
					$('#updateMsg').hide();
			    	$('#password').attr('readonly',true);
			        $('#password_confirm').attr('readonly',true);
			        $('#showUpdatePwForm').hide();
			    	$('#insertPwForm').show();
			    	$('#checkMsg').html('');
				}else{
					$('#updateMsg').hide();
					$('#password').val("");
					$('#password_confirm').val("");
					$('#password').focus();
				    $('#checkMsg').html('<p style="color:red" align="center">패스워드를 확인 하세요.</p>');
					}
				}
			});
		}
	}
});
	
  $('#updatePw').on('click', function() {
	if(pwChk){
		if(confirm("기존 비밀번호를 변경 하시겠습니까?")){
			$.ajax({
				async: true,
				type : 'POST',
				url : 'updatePw.do',
				data: {"newPw" : $('#changePw').val()},
				success : function(data) {
					alert("비밀번호가 변경 되었습니다.\n다시 로그인 하시길 바랍니다.");
			        window.location.replace("index.do");
					}
			});
		}
	}else{
		$('#updateMsg').hide();
		alert("비밀번호를 확인해 주세요");
		$('changePw').focus();
		}
	});
}); //End function
var pwChk = false;

function insertPw(pw){
	val = pw.value;
	id = document.updateForm.id.value;
	oldPw = document.updateForm.password.value;
	pwChk = false;
	if(val.match(" ") != null){
		msg = '<p style="color:red">패스워드에 공백 문자는 사용할 수 없습니다.</p>'
	}else{
		if (val.length >= 8 && (val >= 'a' && val <= 'z')) {
			if (oldPw == val || id == val) {
				msg = '<p style="color:red">기존 패스워드 및 아이디와<br> 동일하게 사용할 수 없습니다.</p>'
			} else{
				msg = '<p style="color:blue">사용할 수 있는 암호 입니다.</p>';
				pwChk = true;
			}
		} else{
			if(val == ""){
				msg = '';
			}else{
			msg = '<p style="color:red">암호는 소문자 및 숫자 8글자 이상만<br>사용할 수 있습니다.</p>'
			}
		}
	}
	$('#checkMsg').html(msg);
};
</script>
<script>
	function cardInfo() {
		var url = "cardInfo.do?";
		var name = "카드 등록";
		var option = "width = 600px, height = 600px, top = 100px, left = 500px, location = no";
		window.open(url, name, option);
	}
</script>
<style type="text/css">
td label {margin: 0;}
td input {height:40;}
tr td {height:50;}
</style>
</head>
<body>
   <jsp:include page="/WEB-INF/views/include/menu.jsp" />
   <div class="container">
      <div class="menu-left">
         <section class="menu-section">
            <ul>
               <li class="menu-active">
                  <a href="#"><i class="fas fa-user-cog"></i>회원 정보</a>
               </li>
               <li class="menu-inactive" style="border-right-color: #003580;">
                  <a href="bookingsList.do"><i class="fas fa-list-alt"></i>예약 관리</a>
               </li>
               <li class="menu-inactive">
                  <a href="calendar.do"><i class="far fa-calendar-alt"></i>캘린더</a>
               </li>
               <li class="menu-inactive">
                  <a href="reviews.do"><i class="fas fa-star"></i>이용 후기</a>
               </li>
            </ul>
         </section>
      </div>
      <!-- main 시작 -->
      <div class="main">
         <!-- filter-Section 시작 -->
         <div class="filter-Section">
            <form action="updateUser.do" method="post" name="updateForm">
            <table>
            <tr align="center">
				<td><label>아이디</label></td>
				<td><input type="text" name="id" id="id" value="${userInform.id }" readonly style="width: 100%;"></td>
            </tr>
            <tr align="center">
				<td><label>성 명</label></td>
				<td><input type="text" name="name" value="${userInform.name }" style="width: 100%;"></td>
            </tr>
            <tr align="center">
            	<td><label>비밀번호</label></td>
            	<td><input type="password" name="password" id="password" style="width: 100%;"></td>
            	<td><button type="button" id="showUpdatePwForm" class="btn btn-primary text-uppercase js-scroll-trigger"
                         style="margin-left: -60;">변경</button>
               </td>
            </tr>
            <tr align="center">
				<td><label>비밀번호확인</label></td>
				<td><input type="password" name="password_confirm" id="password_confirm" style="width: 100%;"></td>
            </tr>
            <tr align="center" style="display: none;" id="insertPwForm">
            	<td><label>변경비밀번호</label></td>
				<td><input type="password" name="changePw" id="changePw" style="width: 100%;" placeholder="새로운 비밀번호" onkeyup="insertPw(this)"></td>
				<td><button type="button" id="updatePw" class="btn btn-primary text-uppercase js-scroll-trigger"
                         style="margin-left: -60;">변경</button>
               </td>
            </tr>
            <tr align="center">
				<td><label>이메일</label></td>
				<td><input type="text" name="mail" maxlength="50" value="${userInform.mail }" style="width: 100%;"></td>
            </tr>
            <tr align="center">
				<td colspan="2">
					<input class="btn btn-primary text-uppercase js-scroll-trigger" type="submit" value="수정">
					<input class="btn btn-light text-uppercase js-scroll-trigger" type="reset" value="취소">
					<button type="button" id="deleteUser" class="btn btn-danger text-uppercase js-scroll-trigger" >계정삭제</button>
					<c:if test="${userInform.mangerRequest eq 'N'}">
						<button type="button" id="roleUpdate" class="btn btn-warning text-uppercase js-scroll-trigger" >매니저권한요청</button>
					</c:if>
					<!-- 카드 등록 if문 넣기 -->	
					<button type="button" class="btn btn-info text-uppercase js-scroll-trigger" onclick="cardInfo()" >카드등록</button><br>
				</td>
				<c:if test="${userInform.mangerRequest eq 'Y' && userInform.role eq 'guest'}">
					<tr align="center">
						<td colspan="2">
							<label style="color: blue">매니저 권한 요청 날짜 (<fmt:formatDate value="${userInform.requestDate}" pattern="yyyy/MM/dd/ HH:mm" />) </label>
						</td>
					</tr>
				</c:if>
				<c:if test="${userInform.role eq 'manager'}">
					<tr align="center">
						<td colspan="2">
							<label style="color: blue">OO호텔 매니저</label>
						</td>
					</tr>
				</c:if>
				<tr id="updateMsg" align="center">
					<td colspan="2">
					<% if (error != null) out.println("<p style='color:red;margin-top: 15;' align='center'>비밀번호를 확인하세요</p>"); %>
					<% if (success != null) out.println("<p style='color:blue;margin-top: 15;' align='center'>회원 정보가 수정 되었습니다.</p>"); %>
					</td>
				<tr>
				<tr align="center">
					<td colspan="2">
					<div id="checkMsg"></div>
					</td>
				</tr>
             </table>
            </form>
         </div>
      </div>
   </div>
   <jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>