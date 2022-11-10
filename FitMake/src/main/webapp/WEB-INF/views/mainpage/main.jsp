<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<style>
	#rootDiv2{
		padding-top: 300px;
	}
</style>
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/Header.jsp"/>
	
	<div id="rootDiv2">
		<div>
			<h3><a href ="../item/categorytest.do">다이어트</a></h3>
		</div>
		<div>
			<h3><a>식단</a></h3>
		</div>
	</div>
	
	
</body>
</html>