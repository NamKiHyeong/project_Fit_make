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
			<c:forEach var="cartMap" items="${cartListMap}">
				<table>
					<tr>
						<td rowspan="3">img</td>
						<td>제품명(단품)</td>		
						<td></td>		
						<td></td>		
					</tr>
					<tr>
						<td></td>
						<td>단가</td>
						<td>단가가격</td>
					</tr>
					<tr>
						<td><input type="range" value="숫자를 입력하세요"></td>
						<td>총 금액</td>
						<td>총 금액 가격</td>
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