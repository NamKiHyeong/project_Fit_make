<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세정보</title>
	<script type="text/javascript">
		function pageMoveListFnc(cNo) {
			location.href="../item/list.do?cNo=" + cNo;
		}
	</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<jsp:include page="/WEB-INF/views/cart/CartSummary.jsp" />
	
	<form action="./update.do" method="get">
		<input type="hidden" name="iNo"	value="${itemDto.iNo}" readonly="readonly"><br>
		<input type="hidden" name="cNo"	value="${itemDto.cNo}"><br>
		<input type="hidden" name="curPage" value="${prevMap.curPage}">
		<div>
			<c:forEach var="item" items="${fileList}">
<%-- 		${row.ORIGINAL_FILE_NAME}(${row.FILE_SIZE}kb)<br> --%>
				<img alt="image not found" src="<c:url value='/image/${item.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
			</c:forEach>
		</div>
		
		
		제품명 : <input type="text" name="iName" id="iName" value="${itemDto.iName}" readonly="readonly"><br>
		가격 : <input type="number" name="iSellprice" value="${itemDto.iSellprice}" readonly="readonly"><br>
<%-- 		개수 : <input type="number" name="iCount" value="${itemDto.iCount}"><br> --%>
		개수 : <input type="number" name="iCount" value="1"><br>
		제품상세정보 :
		<textarea rows="" cols="" readonly="readonly">${itemDto.iOneDetail}</textarea>
		<br>
		
		
		
		<input type="button" value="뒤로가기" onclick="pageMoveListFnc(${itemDto.cNo});">
		<input type="button" value="장바구니">
		<input type="button" value="구매하기">
		<input type="submit" value="수정하기">
		
	</form>
</body>
</html>