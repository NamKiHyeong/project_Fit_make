<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#mypageNav {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	border-left: 1px solid;
	border-top: 1px solid;
	border-bottom: 1px solid;
	height: 102px;
	width: 435px;
}

.mapageNavDiv {
	height: 100%;
	border-right: 1px solid;
	text-align: right;
}

.mapageNavDiv ol {
	margin-top: 30px;
}

.mapageNavDiv li {
	margin-right: 40px;
}
</style>
</head>
<body>
	<div id="mypageNav">
		<div class="mapageNavDiv">
			<ol>
				<li>주문대기</li>
				<li><a href="#"></a>
					<em>개</em>
				</li>
			</ol>
		</div>
		<div class="mapageNavDiv">
			<ol>
				<li>주문승인</li>
				<li><a href="#"></a><em>개</em></li>
			</ol>
		</div>
		<div class="mapageNavDiv">
			<ol>
				<li>구매확정</li>
				<li><a href="#"></a><em>개</em></li>
			</ol>
		</div>
	</div>
</body>
</html>