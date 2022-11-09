<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#loginDiv {
	padding-top: 300px;
	text-align: center;
}

.login_fir_Tag {
	font-weight: bold;
	font-size: 40px;
}

.login_sec_Tag {
	font-size: 12px;
}
</style>
<script type="text/javascript">
	function joinFnc() {

	}
</script>
<title>로그인 페이지</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="loginDiv">
		<p class="login_fir_Tag">로그인</p>
		<p class="login_sec_Tag">Fit_Make!</p>

		<form action="./loginCtr.do" method="post" id="loginFormDiv">
			<input type="text" name="email" placeholder="이메일 입력"><br>
			<input type="password" name="password" placeholder="비밀번호 입력"><br>
			<input type="submit" value="로그인">
		</form>
		<p>
			<a href="../user/add.do">회원가입</a>
		</p>
	</div>
</body>
</html>