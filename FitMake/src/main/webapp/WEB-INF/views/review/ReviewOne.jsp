<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../Hearder.jsp" />
	
	
	<form action="./update.do" method="get">
		<input type="hidden" name="rNo" value="${reviewDto.rNo}">
		<input type="text" name="rTitle" value="${reviewDto.rTitle}">
		<textarea rows="" cols=""> ${reviewDto.rContent} </textarea>
<!-- 	value는 list - control에서 map or list에 준 것을 앞에 붙이기		 -->
		
		<c:if test="${reviewDto.rNo == uNo}"><input type="button" value="수정하기"></c:if>
	</form>
</body>
</html>