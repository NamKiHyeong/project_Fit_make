<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<style type="text/css">
	#roodDiv2{
		padding-top: 300px;
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp"/>
	
	<div id="roodDiv2">
		<div>
		<a href="./categorytest.do"><h2>특가</h2></a>
		<a href="./itemtest.do"><h4>제품을 등록해주세요</h4></a>
		
		</div>
		<div>
		<a href="#"><h2>베스트</h2></a>
		<a href="#"><h4>제품을 등록해주세요</h4></a>
		
		</div>
	</div>
</body>
</html>