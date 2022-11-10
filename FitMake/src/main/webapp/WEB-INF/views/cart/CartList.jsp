<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

</script>
<style type="text/css">
	
</style>
<title>장바구니</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div style="width: 500px; height: 400px; padding-top: 380px; text-align: center; align-items: center;">
		<div>
			<table>
				<tr>
					<th>장바구니</th>
				</tr>
			</table>
			<hr>
		</div>
			<c:forEach var="cartMap" items="${cartMapList}">
				<table>
					<tr>
						<td rowspan="3">img</td>
						<td>${cartMap.FM_ITEM_NAME}</td>		
						<td></td>		
						<td></td>		
					</tr>
					<tr>
						<td></td>
						<td>단가</td>
						<td>${cartMap.FM_ITEM_SELLPRICE}</td>
					</tr>
					<tr>
						<td><input type="range" value="${cartMap.FM_CART_COUNT}"></td>
						<td>총 금액</td>
						<td>${cartMap.FM_ITEM_SELLPRICE * cartMap.FM_CART_COUNT}</td>
					</tr>
				</table>
					<hr>
			</c:forEach>
			
			<input type="button">
			<input type="button">
			
			<form id="detailViewForm" method="post">
				<input id="orderNo" type="hidden" value="" name="oNo">
			</form>
			
			
	</div>
</body>
</html>