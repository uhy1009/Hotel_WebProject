<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>매니저 요청 확인</title>
<style type="text/css">
a {
	text-decoration: none;
	font-size: 20px;
	font-weight: normal;
	line-height: 17px;
	color: #555555;
	text-align: center;
	padding: 13px 0;
	font-family: 'NanumFont2';
}

.event_search {
	float: left;
	width: 100%;
	margin-top: 40px;
	padding: 0 0 10px 0;
}

.event_search table {
	float: right;
	margin-right: 190px;
}

.event_box {
	align-content: center;
	width: 80%;
}

.event_list {
	width: 100%;
	float: left;
}

.event_list th {
	text-align: center;
	font-family: 'NanumFont1';
	color: #767676;
	font-size: 13px;
	background-color: #f9f9f9;
	border-bottom: 1px solid #e9e9e9;
	line-height: 17px;
	padding: 13px 0;
	border-top: 1px solid #e9e9e9
}

.event_list td {
	font-weight: normal;
	line-height: 17px;
	color: #555555;
	text-align: center;
	padding: 13px 0;
	border-bottom: 1px solid #e9e9e9;
	font-family: 'NanumFont2';
}

.event_list td.title {
	text-align: left;
	padding: 11px 0 8px 12px;
}

.event_list td a {
	font-weight: normal;
	line-height: 17px;
	color: #555555;
	text-align: center;
	padding: 13px 0;
	font-family: 'NanumFont2';
}
</style>
<script>
function managerGrant(id) {
	if (confirm("권한을 승인 하시겠습니까?")){
		alert("권한을 부여했습니다.")
		window.location.replace("managerGrant.do?id="+id);
	}
}
function grantCancle(id) {
	if (confirm("요청을 거부 하시겠습니까?")){
		alert("요청을 삭제 했습니다.")
		window.location.replace("grantCancle.do?id="+id);
	}
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/menu.jsp" />
	<form style="margin-top: 180px;">
		<div align="center">
		<h1>매니저 요청 리스트</h1>
			<table border="1" cellpadding="0" cellspacing="0" width="1200" class="request_List">
				<tr height="50" align="center">
					<th width="15%"
						style="background-color:#81DAF5; font-size: 20px">아이디</th>
					<th width="15%"
						style="background-color:#81DAF5; font-size: 20px">이름</th>
					<th width="20%"
						style="background-color:#81DAF5; font-size: 20px">이메일</th>
					<th width="15%"
						style="background-color:#81DAF5; font-size: 20px">가입날짜</th>
					<th width="15%"
						style="background-color:#81DAF5; font-size: 20px">요청날짜</th>
					<th width="20%" colspan="2"
						style="background-color:#81DAF5; font-size: 20px">권한</th>
				</tr>
				<c:forEach items="${requestUserList}" var="user">
					<tr height="50" align="center">
						<th>${user.id }</th>
						<th>${user.name }</th>
						<th>${user.mail }</th>
						<th><fmt:formatDate value="${user.regDate}" pattern="yyyy/MM/dd/ hh:mm" /></th>
						<th><fmt:formatDate value="${user.requestDate}" pattern="yyyy/MM/dd/ hh:mm" /></th>
						<th><button type="button" class="btn btn-success text-uppercase js-scroll-trigger" onclick="managerGrant('${user.id}')">승인</button>
							<button type="button" class="btn btn-secondary text-uppercase js-scroll-trigger" onclick="grantCancle('${user.id}')">취소</button></th>
					</tr>
				</c:forEach>
			</table>
		</div>
	</form>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>