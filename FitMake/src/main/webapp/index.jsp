<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실험용 페이지</title>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
.notosanskr * { 
 font-family: 'Noto Sans KR', sans-serif;
}

html, body{
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0px;
	padding: 0px;
	height: 100%;
}
#container {
	width: 1200px;
	height: 100%;
	margin: 0px auto;
}
#mainDiv {
	width: 1000px;
	padding: 338px 100px 100px 100px;
	margin: 0px auto;
	text-align: center;
}
#pTag {
	font-size: 40px;
	font-weight: bold;
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
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	window.onload = function () {
		
		setTimeout(function() {
			location.href = 'auth/login.do';
		}, 3000);
		
	}
	$("html").click(function() {
		location.href = 'auth/login.do';
	});
	

</script>

</head>
<body>
	<div id="container">
		<div id="mainDiv">
		<img id="homeImg" alt="Fit-Make" src="./resources/image/mainlogo.jpg">
		<p id="pTag">FitMake에 오신걸 환영합니다!</p>
		화면 클릭시 홈페이지 이동 또는 3초뒤 홈페이지로 갑니다!
		</div>
	</div>
</body>
</html>