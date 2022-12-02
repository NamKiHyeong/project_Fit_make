<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문성공</title>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
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
<style type="text/css">
	#orderSuccessDiv{
		width: 1200px;
	}
	#successTextArea{
		text-align: center;
	}
	#orderSuccessText{
		font-size: 50px;
		font-weight: 600;
	}
	#orderSuccessDiv{
		align-items: right;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/Header.jsp" />
		<div id="orderSuccessDiv">
			<p id="successTextArea"><span id="orderSuccessText">주문에 성공하셨습니다.</span></p>
			
			<input id="orderListBtn" type="button" value="주문목록으로">
			<input id="itemListBtn" type="button" value="제품목록으로">
		</div>
	</div>
</body>
</html>