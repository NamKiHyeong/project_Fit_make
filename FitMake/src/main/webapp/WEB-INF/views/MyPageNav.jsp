<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function() {
		$.ajax({
			url : "../order/count.do",
			type : "get",
			dataType : "json",
			success : function(data) {
				var pendingStr = data.oPending;
				var confirmStr = data.oConfirm;
				var pixedStr = data.oPixed;

				$("#orderPending").html(pendingStr);
				$("#orderConfirm").html(confirmStr);
				$("#orderPixed").html(pixedStr);
			}

		});
	});
</script>
<style type="text/css">
#mypageNav {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	border-left: 5px solid #757e86;
	border-top: 5px solid #757e86;
	border-bottom: 5px solid #757e86;
	border-right: 4px solid #757e86;
	height: 102px;
	width: 435px;
}

.mapageNavDiv {
	width: 100%;
	height: 100%;
	border-right: 1px solid #d5d8da;
	text-align: right;
}

.mapageNavDiv ol {
	margin-top: 30px;
}

.mapageNavDiv li {
	color: #777;
	font-weight: 700;
	margin-right: 40px;
}

.emFont {
	font-size: 22px;
	color: #d12268;
	font-weight: bold;
}
</style>
</head>
<body>
	<div id="mypageNav">
		<div class="mapageNavDiv">
			<ol>
				<li>주문대기</li>
				<li><a class="emFont"
					href="../order/list.do?searchOption=oStatus&searchText=pending"
					id="orderPending"></a> <em>개</em></li>
			</ol>
		</div>
		<div class="mapageNavDiv">
			<ol>
				<li>주문승인</li>
				<li><a class="emFont"
					href="../order/list.do?searchOption=oStatus&searchText=confirm"
					id="orderConfirm"></a> <em>개</em></li>
			</ol>
		</div>
		<div class="mapageNavDiv">
			<ol>
				<li>구매확정</li>
				<li><a class="emFont"
					href="../order/list.do?searchOption=oStatus&searchText=pixed"
					id="orderPixed"></a> <em>개</em></li>
			</ol>
		</div>
	</div>
</body>
</html>