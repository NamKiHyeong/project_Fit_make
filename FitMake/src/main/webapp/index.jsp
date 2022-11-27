<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실험용 페이지</title>
<style type="text/css">
#container {
	text-align: center;
}

#homeImg {
	animation: rotate_image 6s linear infinite, scale1 6s linear infinite;
  	transform-origin: 50% 50%;
  	cursor: pointer;
}

@keyframes scale1 {
  0%   { transform: scale(0) }
  100%  { transform: scale(1) }
}
</style>
<script type="text/javascript">
	function loginMoveFnc() {
		var formObj = document.getElementById("simpleForm");

		formObj.submit();
	}
</script>

</head>
<body>
	<div id="container">
	<form action="auth/login.do" method="get" id="simpleForm">
		<img id="homeImg" alt="Fit-Make" onclick="loginMoveFnc();"
			src="./resources/image/mainlogo.jpg">
	</form>
	</div>
</body>
</html>