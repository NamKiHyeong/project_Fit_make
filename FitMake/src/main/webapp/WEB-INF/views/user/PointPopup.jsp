<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전 페이지</title>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	function closeTabClick() {
		window.close();
	}
</script>
</head>
<body>
	<h1>포인트 충전</h1>

	<form action="#" method="post">
		<div id="selectContainer">
			<select name="point">
				<option value="">직접입력</option>
				<option value="">5,000</option>
				<option value="">10,000</option>
				<option value="">30,000</option>
				<option value="" selected>50,000</option>
				<option value="">100,000</option>
			</select> <input type="button" value="충전" onclick=""><input
				type="button" value="취소" onclick="closeTabClick();">
		</div>
	</form>
</body>
</html>