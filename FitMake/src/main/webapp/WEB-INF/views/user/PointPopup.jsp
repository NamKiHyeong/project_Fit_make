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

/* 인풋 type number 표시버튼 없앰 */
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

#priceSelect {
	width: 42%;
	height: 35px;
	padding-left: 11px;
	line-height: 35px;
	background: #f9f9f9;
	border: 1px solid #d6d6d6;
	color: #7e7e7e;
	font-size: 13px;
}

#optionUl {
	width: 218px;
	display: none;
	height: 210px;
	background-color: silver;
	height: 191px;
	margin: 0px;
	padding: 0px;
	background-color: silver;
}

#optionli {
	width: 100%;
	height: 35px;
	border: 1px solid #d6d6d6;
	text-align: right;
}

.optionli {
	width: 100%;
	height: 35px;
	border: 1px solid #d6d6d6;
	text-align: right;
}

#ulDiv {
	position: absolute;
	display: none;
	width: 146px;
	margin-top: 13px;
	background-color: white;
}

.ulPtag {
	font-size: 15px;
}
</style>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	function closeTabClick() {
		opener.parent.location.reload();
		window.close();
	}

	$(document).ready(function() {
		
		// 내가 정한 영역 클릭시 show 제외 부분 클릭시 hide
		$('#priceSelect').click(function(event) {
			event.stopPropagation();
			$("#optionUl").show();
		});
		$(document).click(function() {
			$('#optionUl').hide();
		});
	
		// 직접입력 버튼 클릭시 들어간 밸류값 초기화 후 포커스. 버튼 부분 hide
		$("#optionli").click(function() {
			$("#priceSelect").val("");
			$("#priceSelect").focus();
			$("#optionUl").hide();
		});
		
		// 금액 버튼 클릭시 해당 밸류값 금액 인풋에 담기. 버튼 부분 hide
		$(".optionli").click(function() {
			$("#priceSelect").val($(this).val());
			$("#optionUl").hide();
		});
		
		// 팝업창에서 충전 버튼을 누르면 ajax실행 금액 인풋에 담긴 밸류값을 전송하여 처리
		$("#pointAdd").click(function() {
			var priceSelect = parseInt($("#priceSelect").val());
			if (!confirm("충전하시겠습니까?")) {
				alert("취소하셨습니다.");
			} else {
				$.ajax({
					type : "post",
					dataType : "json",
					url : "pointAdd.do",
					data : {
						"priceSelect" : priceSelect,
						"oNo" : 0
					},
					success : function(data) {
						alert("충전이 완료되었습니다");
						closeTabClick();

					},
					error : function() {
						console.log("오류발생");
					}
				});
			}
		});
	});
</script>
</head>
<body>

	<div id="selectContainer">
		<p id="pTagId">포인트 충전</p>
		<input type="number" id="priceSelect" placeholder="금액입력">
		<div id="popUpDiv">
			<ul id="optionUl">
				<li><button id="optionli" value="0">직접입력</button></li>
				<li><button class="optionli" value="5000">5,000</button></li>
				<li><button class="optionli" value="10000">10,000</button></li>
				<li><button class="optionli" value="30000">30,000</button></li>
				<li><button class="optionli" value="50000">50,000</button></li>
				<li><button class="optionli" value="100000">100,000</button></li>
			</ul>
		</div>
		<div style="float: right;">
			<input type="button" id="pointAdd" value="충전"> <input
				type="button" value="취소" onclick="closeTabClick();">
		</div>
	</div>
</body>
</html>