<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
em {
	font-style: normal;
    	display: inline-block;
    	padding: 0px 2%;
    	margin-top: 10px;
    	font-size: 0.855em;
    	color: #454545;
    	font-weight: normal;
}

#login_Root_Div {
	width: 1200px;
	margin: 0 auto;
}

#loginDiv {
	text-align: center;
}

.login_fir_Tag {
	font-weight: bold;
	font-size: 40px;
}

.login_sec_Tag {
	font-size: 20px;
	font-weight: bold;
}

.input_Css {
	width: 400px;
	padding: 15px 0px;
	background: #fff;
	color: #000;
	font-size: 1em;
	border: 1px solid #e1e1e1;
	border-radius: 5px;
	text-align: left;
	text-indent: 12px;
	vertical-align: middle;
	outline: medium none;
	font-weight: normal;
}

.input_p_Css input:hover {
	border-radius: 5px;
	border: 1px solid #d7266d
}

#login_input {
	width: 400px;
	background: #d7266d;
	margin-top: 30px;
   	margin-bottom: 30px;
	padding: 10px 0px;
	border: 1px solid #d7266d;
	color: #fff;
	text-align: center;
	font-size: 1em;
	border-radius: 3px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
</script>
<title>로그인 페이지</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="login_Root_Div">
		<div id="loginDiv">
			<p class="login_fir_Tag">로그인</p>
			<p class="login_sec_Tag">Fit_Make!</p>
			<div class="input_p_Css">
				<form action="./loginCtr.do" method="post" id="loginFormDiv">
					<div style="margin-bottom: 20px;">
						<input type="text" class="input_Css" name="email"
							placeholder="이메일 입력">
					</div>
					<div>
						<input type="password" class="input_Css" name="password"
							placeholder="비밀번호 입력">
					</div>
					<input id="login_input" type="submit" value="로그인">
				</form>
			</div>
			<p>
				<a style="font-weight: bold;" href="../user/add.do">회원가입</a><em>ㅣ</em>
				<a href="../user/findId.do">아이디 찾기</a><em>ㅣ</em>
				<a href="../user/findPassword.do">비밀번호 찾기</a>
			</p>
		</div>
	</div>
</body>
</html>