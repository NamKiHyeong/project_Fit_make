<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<style type="text/css">
#selectContainer li {
	list-style: none;
}
</style>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	function closeTabClick() {
		window.close();
	}
	
	
	$(document).ready(function () {
		$("#priceSelect").click(function() {
			if ($("#optionUl").is(':visible') == false) {
				$("#optionUl").show();
			} 
		});
		$(".optionli").click(function() {
			$("#priceSelect").val($(this).val());
			$("#optionUl").hide();
		});
		
		$("#pointAdd").click(function() {
		var priceSelect = parseInt($("#priceSelect").val());
			$.ajax({
				type: "post",
				dataType: "json",
				url: "pointAdd.do",
				data: { "priceSelect": priceSelect },
				success: function(data) {
					alert("충전이 완료되었습니다");
					closeTabClick();
					
				},
				error: function() {
					console.log("안됨;");
				}
			});
		});
		
	});
	
	
</script>
</head>
<body>
	<h1>포인트 충전</h1>

	<div id="selectContainer">
		<input type="number" id="priceSelect" placeholder="금액입력">
		<ul id="optionUl" style="display: none;">
			<li><input class="optionli" type="button" value="직접입력"></li>
			<li><input class="optionli" type="button" value="5000"></li>
			<li><input class="optionli" type="button" value="10000"></li>
			<li><input class="optionli" type="button" value="30000"></li>
			<li><input class="optionli" type="button" value="50000"></li>
			<li><input class="optionli" type="button" value="100000"></li>
		</ul>

		<input type="button" id="pointAdd" value="충전"> <input
			type="button" value="취소" onclick="closeTabClick();">
	</div>
</body>
</html>