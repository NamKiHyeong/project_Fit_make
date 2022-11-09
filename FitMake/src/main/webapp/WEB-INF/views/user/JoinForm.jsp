<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#container {
	padding-top: 300px;
	text-align: center;
}
</style>
<title>회원가입 페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="container">
		<h1>회원가입</h1>
		<form action='./addCtr.do' method='post'>
			이메일: <input	type='text' name='email'><br>
			닉네임: <input type='text' name='nickName'><br> 
			비밀번호: <input type='password' name='password'><br>
			휴대폰: <input type='text' name='mobile'><br>
			우편번호: <input type='text' name='zipCode'><br>
			주소: <input type='text' name='address'><br>
			<input type='submit' value='회원가입'>
		</form>
	</div>
</body>
</html>