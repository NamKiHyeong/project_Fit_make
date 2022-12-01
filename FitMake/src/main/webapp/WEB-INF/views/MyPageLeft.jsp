<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
#container_Nav {
	width: 140px;
    height: 420px;
	border: 1px solid #c3c3c3;
}

#container_Nav ol {
	margin: 6px;
	padding: 10px;
	border-bottom: 1px solid #c3c3c3;
	text-align: left;
	font-size: small;
	line-height: 1.8em;
}

#firstDiv_Nav {
	display: flex;
     justify-content: center;
     align-items: center;
	height: 100px;
	background-color: #d12268;
}

#mypageAtag {
	padding: 40px 25px;
	color: #fff;
	font-size: 18px;
	font-weight: bold;
}
</style>

<script type="text/javascript">
      
      </script>

</head>

<body>
	<div id="container_Nav">
		<div id="firstDiv_Nav">
			<a id="mypageAtag" href="#">마이페이지</a>
		</div>
		<div>
			<ol>
				<li><strong>주문관리</strong></li>
				<li><a href="../order/list.do">주문조회</a></li>
				<li><a href="#">주문취소</a></li>
			</ol>
		</div>
		<div>
			<ol>
				<li><strong>활동 관리</strong></li>
				<li><a href="#">리얼후기</a></li>
				<li><a href="#">상품문의</a></li>
				<li><a href="#">1:1 문의</a></li>
			</ol>
		</div>
		<div>
			<ol>
				<li><strong>정보 관리</strong></li>
				<li><a href="#">내정보 수정</a></li>
				<li><a href="../user/pointHistory.do">충전/사용내역</a></li>
			</ol>
		</div>
	</div>
</body>


</html>