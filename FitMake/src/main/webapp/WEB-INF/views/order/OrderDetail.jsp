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
<script type="text/javascript">
</script>
<style type="text/css">
	.orderDetail, .orderDetailPrice{
		padding: 30px;
	}
</style>
<title>주문상세</title>
</head>
<body>

		<jsp:include page="/WEB-INF/views/Header.jsp" />
		
		<div>
			<table>
				<tr>
					<td><h1>주문내역 확인</h1></td>
				</tr>
			</table>
		</div>
			<c:choose>
				<c:when test="${orderDetailItemList.size() > 1}">
					<h4>${orderDetailItemList[0].FM_ITEM_NAME} 외 ${orderDetailItemList.size() - 1}개</h4>
				</c:when>
				<c:otherwise>
					<h4>${orderDetailItemList[0].FM_ITEM_NAME}</h4>
				</c:otherwise>
			</c:choose>
			<c:forEach var="orderDetailItem" items="${orderDetailItemList}">
				<div>
					<table>
							<tr>
								<td class="orderDetail">${orderDetailItem.FM_ITEM_NAME}</td>
								<td class="orderDetail">
									<input type="text" value="${orderDetailItem.FM_ORDER_DETAIL_COUNT}" readonly="readonly">개
								</td>
								<td class="orderDetail">
									<input class="orderDetailPrice" type="hidden" 
										value="${orderDetailItem.FM_ORDER_DETAIL_PRICE * orderDetailItem.FM_ORDER_DETAIL_COUNT}">							
									가격 ${orderDetailItem.FM_ORDER_DETAIL_PRICE * orderDetailItem.FM_ORDER_DETAIL_COUNT}
								</td>
							</tr>
					</table>
				</div>
			</c:forEach>
		
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
			<c:choose>
				<c:when test="${orderDetailItemList.size() > 1}">
					<h4>${orderDetailItemList[0].FM_ITEM_NAME} 외 ${orderDetailItemList.size() - 1}개</h4>
				</c:when>
				<c:otherwise>
					<h4>${orderDetailItemList[0].FM_ITEM_NAME}</h4>
				</c:otherwise>
			</c:choose>
			<br>
			<p>${orderDetailItemList[0].totalPrice}</p>
			<input type="button" onclick="./list.do">
		</div>
		
</body>
</html>