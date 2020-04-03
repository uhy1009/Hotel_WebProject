<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
// 아이디 중복 체크 동작
var isChk = false;
var pwChk = false;
var idChk = false;
var mailChk = false;
var code = null;
var msg = '';

$(document).ready(function() {
   $('#checkId').on('click', function() {
      $.ajax({
         async: true,
         type : 'POST',
         url : 'getUserConfirm.do',
         data: {"userid" : $('#id').val()},
            success : function(data) {
            if (data) {
               $('#checkMsg').html('<p style="color:blue">사용 가능한 아이디입니다.</p>');
               isChk = true;
               $("#password").focus();
            } else {
               $('#checkMsg').html('<p style="color:red">사용 중인 아이디거나<br>사용할 수 없는 아이디입니다.</p>');
               isChk = false;
               $('#confirmEmail').show();
               $('#mailCode').hide();
               $('#mail').val("");
               $("#id").focus();
            }
         }
      });//End ajax
   });//End on
// 이메일 인증
  $('#confirmEmail').on('click', function() {
	if(document.addMemberForm.mail.value == ""){
		alert("메일을 입력 하세요.");
		$('#mail').focus();
  	}else{
		if(isChk==false){
    		alert('아이디 중복체크를 해주세요');
			return false;
    	}else{
			$.ajax({
			async: true,
			type : 'POST',
			url : 'assignMail.do',
			data: {"userMail" : $('#mail').val()},
			success : function(data) {
					if(data != "fail"){
			    			code = data;
			    			mailChk = true;
			    			$('#confirmEmail').hide();
			    			$('#mailCode').show();
			    			$('#checkMsg').html('<p style="color:blue">인증 메일을 전송 했습니다.</p>');
	            		}else{
							alert("이미 사용중인 이메일 입니다.");
							$("#mail").focus();
							mailChk = false;
						}
					}
				});//End ajax
			}
		}
	});
});
// 회원 가입시 아이디 중복 체크 여부 확인

function checkFrm() {
	if (confirm("회원가입 하시겠습니까?")) {
		if(mailChk == false){
			alert("이메일 인증은 필수 입니다.");
			return false;
		}else{
			if (isChk == false) {
				alert('아이디 중복체크를 해주세요');
				return false;
			}else{
					if(document.addMemberForm.mailCode.value == code){
					alert("회원가입을 축하합니다");
					return true;
					}else{
					alert("이메일 인증 번호가 다릅니다.");
					return false;
				}
			}
		}
	}else{
		return false;
	}
}

function insertId(id){
	val = id.value;
	if (val.match(" ") != null) {
			msg = '<p style="color:red">아이디에 공백 문자는 사용할 수 없습니다.</p>'
			idChk = false;
		} else{
			msg = '';
			idChk = true;
		}
	if(val == ""){
		msg = '';
	}else{
	$('#checkMsg').html(msg);
	}
};

function insertPw(pw){
	val = pw.value;
	id = document.addMemberForm.id.value;
	if(val.match(" ") != null){
		msg = '<p style="color:red">패스워드에 공백 문자는 사용할 수 없습니다.</p>'
		pwChk = false;
	}else{
		if (val.length >= 8 && (val >= 'a' && val <= 'z')) {
			if (id == val) {
				msg = '<p style="color:red">아이디와 패스워드가 같습니다.</p>'
				pwChk = false;
			} else{
				msg = '<p style="color:blue">사용할 수 있는 암호 입니다.</p>';
				pwChk = true;
			}
		} else{
			if(val == ""){
				msg = '';
			}else{
			msg = '<p style="color:red">암호는 소문자 및 숫자 8글자 이상만<br>사용할 수 있습니다.</p>'
			pwChk = false;
			}
		}
	}
	$('#checkMsg').html(msg);
};
</script>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<!-- Bootstrap core CSS -->
   <link href="resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
   <!-- 스타일 CSS -->
   <link href="resources/css/agency.css" rel="stylesheet">
</head>
<body>
   <div align="center">
      <label><a class="navbar-brand js-scroll-trigger" href="index.do">@SpringHotel</a></label>
		<h1> 회원가입 </h1>
         <form action="addmember.do" name="addMemberForm" method="post" onsubmit="return checkFrm()">
         <table>
            <tr>
               <td>
               <input type="text" name="id" id="id" placeholder="아이디" class="form-control" onkeyup="insertId(this)" required autofocus
                      style="width: 300px; height: 50px; margin: 10;"/>
               </td>
               <td>
               <button type="button" id="checkId" class="btn btn-primary text-uppercase js-scroll-trigger"
                         style="margin-left: -110;">중복확인</button>
               </td>
            </tr>
            <tr>
               <td>
               <input type="password" id="password" name="password" placeholder="비밀번호" class="form-control" onkeyup="insertPw(this)" required
                      style="width: 300px; height: 50px; margin: 10;"/>
               </td>   
            </tr>
            <tr>
               <td>
               <input type="text" name="name" placeholder="이름" class="form-control" required
                      style="width: 300px; height: 50px; margin: 10;"/>
               </td>
            </tr>
            <tr>
               <td>
               <input type="text" name="mail" id="mail" maxlength="50" placeholder="Email" class="form-control" required
                      style="width: 300px; height: 50px; margin: 10;"/>
               </td>
               <td>
               <button type="button" id="confirmEmail" class="btn btn-primary text-uppercase js-scroll-trigger"
                       style="margin-left: -110;">메일인증</button>
               </td>
            </tr>
            <tr>
				<td>
				<input type="text" name="mailCode" id="mailCode" placeholder="인증번호" class="form-control"
					   style="width: 300px; height: 50px; margin: 10; display: none;"/>
				</td>
            </tr>
            <tr align="center">
               <td style="border-bottom: #f8f7f9; border-bottom-style: inset;">
               <input type="submit" value="가입하기" class="form-control"
					 	   style="width: 300px; height: 50px; background-color: #A9D0F5; margin: 10;"/>
               </td>
            </tr>
            <tr>
            	<td align="center" height="50">
            	<a href="login.do">로그인</a>
            	</td>
            </tr>
            <tr>
	            <td align="center">
	               <div id="checkMsg"></div>
	            </td>
            </tr>
         </table>
      </form>
   </div>         
</body>
</html>