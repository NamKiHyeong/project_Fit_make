<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#container {
	width: 1200px;
	margin: 0 auto;
}

#joinDiv {
	text-align: center;
}

.join_Tag {
	font-weight: bold;
	font-size: 40px;
}
</style>
<title>회원가입 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="container">
		<div id="joinDiv">
			<p class="join_Tag">회원가입</p>
			<form action='./addCtr.do' method='post'>
				이메일
				 <input type='text' name='email'><br>
				닉네임
				 <input type='text' name='nickName'><br>
				비밀번호
				 <input	type='password' name='password'><br>
				휴대폰
				 <input type='text' name='mobile'><br>
				우편번호
				 <input	type='text' name='zipCode'><br>
				주소
				 <input type='text'	name='address'><br>
				신체정보
				 <input type="text" name="">
				<input type='submit' value='회원가입'>
			</form>
		</div>
	</div>
</body>
</html>