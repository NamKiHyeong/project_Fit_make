<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세정보</title>
</head>
<body>
	
	
	<form action="./update.do" method="get">
		<input type="hidden" name="iNo"	value="${itemDto.iNo}"><br>
		<c:forEach var="item" items="${fileList}">
<%-- 		${row.ORIGINAL_FILE_NAME}(${row.FILE_SIZE}kb)<br> --%>
		<img alt="image not found" src="<c:url value='/image/${item.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
		</c:forEach>
		제품명 : <input type="text" name="iName" id="iName" value="${itemDto.iName}"><br>
		가격 : <input type="number" name="iSellprice" value="${itemDto.iSellprice}"><br>
		제고 : <input type="number" name="iCount" value="${itemDto.iCount}"><br>
		제품상세정보 :
<%-- 		<input name="iOneDetail" value="${itemDto.iOneDetail}"> --%>
		<textarea rows="" cols="" >${itemDto.iOneDetail}</textarea>
		<br>

		<input type="submit" value="수정하기">
	</form>
</body>
</html>