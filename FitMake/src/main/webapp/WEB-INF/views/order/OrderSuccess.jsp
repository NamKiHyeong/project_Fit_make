<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
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
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: space-around;
		flex-direction: column;
		align-content: center;
		align-items: center;
		
	}
	#orderSuccessInnerDiv{
 		margin-top: 200px; 
 		text-align: center; 
		width : 1000px;
	}
	#successBtn{
		text-align: right;
 		
	}
	#successTextArea{
		font-size: 50px;
		font-weight: 600;
	}
	#orderSuccessDiv{
		align-items: right;
	}
	#successBtn{
		margin-top: 200px;
	}
	
</style>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/Header.jsp" />
		<div id="orderSuccessDiv">
			<div id="orderSuccessInnerDiv">
				<div id="successTextDiv">
					<p id="successTextArea">주문에 성공하셨습니다.</p>
				</div>
				<div id="successBtn">
					<input id="orderListBtn" type="button" value="주문목록으로">
					<input id="itemListBtn" type="button" value="제품목록으로">
				</div>
			</div>
		</div>
	</div>
</body>
</html>