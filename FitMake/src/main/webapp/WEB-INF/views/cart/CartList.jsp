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

	function countUpFnc(cartNo){
		$("#iCount" + cartNo).val(parseInt($("#iCount" + cartNo).val().valueOf())+1);
	}
	
	function countDownFnc(cartNo){
		$("#iCount" + cartNo).val(parseInt($("#iCount" + cartNo).val().valueOf())-1);
		// 수량이 1 미만이 되면 알람을 띄워 삭제 or 0은 될 수 없다는 유효성 검사를 넣는다
	}
	
	function deleteCartFnc(cartNo){
		location.href = "./delete.do?cNo=" + cartNo;
	}
	
	$(document).ready(function() {
		$("#buyBtn").on("click", function() {
			$("#addForm").submit();
		});
		
	});
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
		<form id="addForm" action="../order/add.do" method="post">
			<c:choose>
				<c:when test="${cartMapList ne null}">
					<c:forEach var="cartMap" items="${cartMapList}">
						<input type="hidden" value="${cartMap.FM_CART_NO}" name="cNo">
						<table>
							<tr>
								<td rowspan="3">img</td>
								<td>${cartMap.FM_ITEM_NAME}</td>		
								<td></td>
								<td><input type="button" value="X" onclick="deleteCartFnc(${cartMap.FM_CART_NO});"></td>		
							</tr>
							<tr>
								<td></td>
								<td>단가</td>
								<td>${cartMap.FM_ITEM_SELLPRICE}</td>
							</tr>
							<tr>
								<td>
									<input id="iCountUp${cartMap.FM_CART_NO}" type="button" value="∨" 
										onclick="countDownFnc(${cartMap.FM_CART_NO});">
									<input id="iCount${cartMap.FM_CART_NO}" type="number" value="${cartMap.FM_CART_COUNT}" 
										name="iCount" readonly="readonly">
									<input id="iCountDown${cartMap.FM_CART_NO}" type="button" value="∧" 
										onclick="countUpFnc(${cartMap.FM_CART_NO});">
								</td>
								<td>총 금액</td>
								<td>${cartMap.FM_ITEM_SELLPRICE * cartMap.FM_CART_COUNT}</td>
							</tr>
						</table>
						<input type="hidden" name="iNo" value="${cartMap.FM_ITEM_NO}">
						<input type="hidden" name="iPrice" value="${cartMap.FM_ITEM_SELLPRICE}">
							<hr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<table>
							<tr>
								<td rowspan="3">장바구니에 담긴 물품이 없습니다</td>
							</tr>
					</table>
				</c:otherwise>
			</c:choose>
			
			<input type="button" id="buyBtn" value="구매하기">
			<input type="button" value="이전페이지">
		</form>			
			
	</div>
</body>
</html>