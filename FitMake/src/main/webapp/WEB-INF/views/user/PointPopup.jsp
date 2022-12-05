<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<style type="text/css">
#
#selectContainer {
	
}

#selectContainer li {
	list-style: none;
}

#pTagId {
	font-size: 30px;
	font-weight: 600;
}

#popUpDiv {
	height: 200px;
}

#optionUl {
	width: 135px;
}
</style>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	function closeTabClick() {
		window.close();
	}

	$(document).ready(function() {
		$("#priceSelect").click(function() {
			if ($("#optionUl").is(':visible') == false) {
				$("#optionUl").show();
				$('#optionUl').animate({
					height : '100px'
				}, 300, 'swing');
			}
		});

		$(".optionli").click(function() {
			$("#priceSelect").val($(this).val());
			$("#optionUl").hide();
		});

		$("#pointAdd").click(function() {
		var priceSelect = parseInt($("#priceSelect").val());

			var priceSelect = parseInt($("#priceSelect").val());
			$.ajax({
				type : "post",
				dataType : "json",
				url : "pointAdd.do",
				data : {
					"priceSelect" : priceSelect
				},
				success : function(data) {
					alert("충전이 완료되었습니다");
					closeTabClick();

				},
				error : function() {
					console.log("안됨;");
				}
			});
		});

	});
</script>
</head>
<body>

	<div id="selectContainer">
		<p id="pTagId">포인트 충전</p>
		<input type="number" id="priceSelect" placeholder="금액입력">
		<div id="popUpDiv">
			<ul id="optionUl" style="display: none; height: 0px;">
				<li><input class="optionli" type="button" value="직접입력"></li>
				<li><input class="optionli" type="button" value="5000"></li>
				<li><input class="optionli" type="button" value="10000"></li>
				<li><input class="optionli" type="button" value="30000"></li>
				<li><input class="optionli" type="button" value="50000"></li>
				<li><input class="optionli" type="button" value="100000"></li>
			</ul>
		</div>

		<input type="button" id="pointAdd" value="충전"> <input
			type="button" value="취소" onclick="closeTabClick();">
	</div>
</body>
</html>