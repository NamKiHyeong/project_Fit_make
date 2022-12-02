<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 하나 보기</title>

<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>

</head>
<body>
	<jsp:include page="../Header.jsp" />
	
	
	<form action="./update.do" method="get">
		<input type="hidden" name="rNo" value="${reviewDto.rNo}">
		<input type="hidden" name="iNo" value="${reviewDto.iNo}">
		<c:forEach var="review" items="${fileList2}">
			<img alt="image not found" src="<c:url value='/image/${review.FM_REVIEW_STORED_NAME}'/>"/><br>
		</c:forEach>
		<c:if test="${_userDto_.uNo == reviewDto.uNo}">
			<input class="itemCtr" type="submit" value="수정하기">
		</c:if>
		제목 <input type="text" name="rTitle" value="${reviewDto.rTitle}" readonly="readonly">
		내용 <textarea rows="" cols="" readonly="readonly"> ${reviewDto.rContent} </textarea>
<!-- 	value는 list - control에서 map or list에 준 것을 앞에 붙이기		 -->
		
<%-- 		<c:if test="${reviewDto.rNo == uNo}"><input type="button" value="수정하기"></c:if> --%>
	</form>
</body>
</html>