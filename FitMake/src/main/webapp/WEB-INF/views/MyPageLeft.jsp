<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
#container_Nav {
	display: flex;
	flex-direction: column; width : 140px;
	height: 420px;
	border: 1px solid #c3c3c3;
	width: 140px;
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
.nabAtag:hover {
	font-weight: bold;
}
</style>

<script type="text/javascript">
	
</script>
	
</head>

<body>
	<div id="container_Nav">
		<div id="firstDiv_Nav">
			<a id="mypageAtag"
				href="${pageContext.request.contextPath}/user/Info.do">마이페이지</a>
		</div>
		<div>
			<ol>
				<li><strong>주문관리</strong></li>
				<li><a class="nabAtag" href="../order/list.do">주문조회</a></li>
			</ol>
		</div>
		<div>
			<ol>
				<li><strong>활동관리</strong></li>
				<li><a class="nabAtag" href="../review/list.do">리뷰목록</a></li>
				<li><a class="nabAtag" href="../inquiry/list.do">1:1 문의</a></li>
			</ol>
		</div>
		<div>
			<ol>
				<li><strong>정보관리</strong></li>
				<li><a class="nabAtag" href="../user/Info.do">내정보 수정</a></li>
				<li><a class="nabAtag" href="../user/pointHistory.do">포인트내역</a></li>
			</ol>
		</div>
	</div>
</body>


</html>