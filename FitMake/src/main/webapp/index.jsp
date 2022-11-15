<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실험용 페이지</title>
<style type="text/css">
#simpleForm {
	width: 1200px;
	text-align: center;
}
#spyImg {
	width: 50%;
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
	<form action="auth/login.do" id='simpleForm' method="get">
		<img onclick="loginMoveFnc();" id="spyImg"
			alt="산업스파이" src="./resources/image/SPY.jpg">
	</form>

</body>
</html>