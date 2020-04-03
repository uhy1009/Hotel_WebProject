<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 찾기</title>
	<!-- Bootstrap core CSS -->
	<link href="resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	<!-- 스타일 CSS -->
	<link href="resources/css/agency.css" rel="stylesheet">
</head>
<% String id = (String)session.getAttribute("searchId"); %>
<body>
<div align="center">
	<a style="margin : 0;" class="navbar-brand js-scroll-trigger" href="index.do">@SpringHotel</a>
	<h1>아이디 찾기</h1>
		<form action="searchId.do" method="post">
			<table>
				<tr height="80px">
					<td>
					<input type="text" name='name' placeholder="이름" required autofocus class="form-control"
					 	   style="width: 300px; height: 50px;"/>
					</td>
				</tr>
				<tr>
					<td>
					<input type="text" name='mail' placeholder="Email" required class="form-control"
					 	   style="width: 300px; height: 50px;"/>
					</td>	
				</tr>
				<tr height="80px">
					<td style="border-bottom: #f8f7f9; border-bottom-style: inset;">
						<input type="submit" value="검색"  class="form-control"
					 	   style="width: 300px; height: 50px; background-color: #A9D0F5;"/>
					</td>
				</tr>
			</table>
			<div style="margin-top: 10;">
				<label><a href="login.do">로그인</a></label>
				<span aria-hidden="true">|</span>
				<label><a href="searchPw.do">패스워드 찾기</a></label>
				<span aria-hidden="true">|</span>
				<label><a href="addmember.do">회원가입</a></label>
			</div>
		<% if(id != "fail" & id != null){ out.println("<p align='center'>회원님의 아이디는<p style='color:blue;margin-top: 15;'>"+ id +"</p> 입니다.</p>"); }
						else if(id == "fail"){ out.println("<p style='color:red;margin-top: 15;' align='center'>가입되지 않은 회원 정보 입니다.</p>"); }%>
		</form>
	</div>
</body>
</html>