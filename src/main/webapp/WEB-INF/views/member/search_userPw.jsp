<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀번호 찾기</title>
	<!-- Bootstrap core CSS -->
	<link href="resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	<!-- 스타일 CSS -->
	<link href="resources/css/agency.css" rel="stylesheet">
</head>
<% String pw = (String)session.getAttribute("searchPw"); %>
<body>
<div align="center">
	<a style="margin : 0;" class="navbar-brand js-scroll-trigger" href="index.do">@SpringHotel</a>
	<h1>비밀번호 찾기</h1>
		<form action="searchPw.do" method="post">
			<table>
				<tr height="70px">
					<td>
					<input type="text" name='id' placeholder="아이디" required autofocus class="form-control"
					 	   style="width: 300px; height: 50px;"/>
					</td>
				</tr>
				<tr height="70px">
					<td>
					<input type="text" name='name' placeholder="이름" required autofocus class="form-control"
					 	   style="width: 300px; height: 50px;"/>
					</td>
				</tr>
				<tr height="70px">
					<td>
					<input type="text" name='mail' placeholder="Email" required class="form-control"
					 	   style="width: 300px; height: 50px;"/>
					</td>	
				</tr>
				<tr height="70px">
					<td style="border-bottom: #f8f7f9; border-bottom-style: inset;">
					<input type="submit" value="검색"  class="form-control"
					 	   style="width: 300px; height: 50px; background-color: #A9D0F5;"/>
					</td>
				</tr>
			</table>
			<div style="margin-top: 10;">
				<label><a href="login.do">로그인</a></label>
				<span aria-hidden="true">|</span>
				<label><a href="searchId.do">아이디 찾기</a></label>
				<span aria-hidden="true">|</span>
				<label><a href="addmember.do">회원가입</a></label>
			</div>
		<% if(pw != "fail" & pw != null){ out.println("<p align='center' style='color:blue;margin-top: 15;'>등록한 메일로 임시 비밀번호를 전송했습니다.</p>"); }
						else if(pw == "fail"){ out.println("<p style='color:red;margin-top: 15;' align='center'>가입되지 않은 회원 정보 입니다.</p>"); }%>
		</form>
	</div>
</body>
</html>