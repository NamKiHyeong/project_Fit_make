<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
	.orderDetail{
		padding: 30px;
	}
</style>
<title>주문상세</title>
</head>
<body>

	<%-- 	<jsp:include page="/WEB-INF/views/Header.jsp" /> --%>

		<div>
			<table>
				<tr>
					<td><h1>주문내역 확인</h1></td>
				</tr>
			</table>
		</div>
		
		<div>
			<h4>주문내역 이름(ex: 건강한 닭가슴살 샐러드 외 2개)</h4>
			<c:forEach var="orderDetailMap" items="${orderDetailItemList}">
				<table>
						<tr>
							<td class="orderDetail">${orderDetailMap.FM_ITEM_NAME}</td>
							<td class="orderDetail">${orderDetailMap.FM_ORDER_DETAIL_COUNT}</td>
							<td class="orderDetail">${orderDetailMap.FM_ORDER_DETAIL_PRICE}</td>
						</tr>
				</table>
			</c:forEach>
		</div>
		
		<div>
			<h4>구매자정보</h4>
			이름			<input value="${orderDetailMyInfo.FM_USER_NICKNAME}" readonly="readonly"><br>
			연락처 		<input value="${orderDetailMyInfo.FM_USER_MOBILE}" readonly="readonly"><br>
		</div>
		
		<div>
			<h4>배송정보</h4>
			이름			<input value="${orderDetailMyInfo.FM_USER_NICKNAME}" readonly="readonly"><br>
			주소 		<input value="${orderDetailMyInfo.FM_USER_ZIP_CODE}" readonly="readonly"><br>
				 		<input value="${orderDetailMyInfo.FM_USER_ADDRESS}" readonly="readonly"><br>
			연락처		<input value="${orderDetailMyInfo.FM_USER_MOBILE}" readonly="readonly"><br>
		</div>
		<br>
		<div>
			<span>주문이름</span><br>
			<p>총가격</p>
		</div>
		
</body>
</html>