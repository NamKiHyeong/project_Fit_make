<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문성공</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#orderListBtn").on("click", function() {
			location.href = "./list.do"
		})
		
		$("#itemListBtn").on("click", function() {
			location.href = "../item/list.do"
		})
	})
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div>
		<span>주문에 성공하셨습니다.</span>
		
		<input id="orderListBtn" type="button" value="주문목록으로">
		<input id="itemListBtn" type="button" value="제품목록으로">
	</div>
</body>
</html>