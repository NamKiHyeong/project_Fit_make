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
	$(document).ready(function(){

		$("#orderConfirmBtn").on("click", function(){
			var checkOrderConfirm = confirm("구매 하시겠습니까?");
			
			if(checkOrderConfirm == true){
				$("#confirmForm").attr("action", "./confirm.do");
				$("#confirmForm").attr("method", "post");
				$("#confirmForm").submit();
			} else {
				return false;
			}
		})
		
		$("#orderCancelBtn").on("click", function() {
			var checkOrderCancel = confirm("구매를 취소 하시겠습니까?");
			
			if(checkOrderCancel == true){
				$("#confirmForm").attr("action", "./cancel.do");
				$("#confirmForm").attr("method", "post");
				$("#confirmForm").submit();
			}
		})
	})
	
	function backToOrderListFnc(){
		location.href = './list.do';
	}
	
	function backToCartListFnc(){
		location.href = '../cart/list.do';
	}
</script>
<style type="text/css">
	.orderDetail, .orderDetailPrice{
		padding: 30px;
	}
	#rootDivObj{
		width : 80%;
/* 		padding: 5%; */ /* 나중에 이걸로 중앙으로 조정한다 */
		align-content: center;
		text-align: left;
 		align-items: left;
	}
	#headTitle {
		font-size: 40px;
	}
	#headTable {
		width: 80%;
		margin-top: 5%;
		margin-left: 3%;
		padding-left: 6.5%;
		text-align: left;
	}
	#headHr {
		width: 80%;
		margin-left: 10%;
		margin-top: 2.4%
	}
	#orderSummaryDiv {
		width: 75%;
		margin-top: 3%;
		margin-left: 10%;
		padding: 3%;
		border: 1px solid black;
	}
	#buyerInfoDiv {
		width: 75%;
		margin-top: 3%;
		margin-left: 10%;
		padding: 3%;
		border: 1px solid black;
	}
	#deliveryInfoDiv {
		width: 75%;
		margin-top: 3%;
		margin-left: 10%;
		padding: 3%;
		border: 1px solid black;
	}
	#totalSummaryDiv {
		width: 75%;
		margin-top: 3%;
		margin-left: 10%;
		padding: 3%;
		border: 1px solid black;
	}
	.orderSummaryTitle {
		
	}
</style>
<title>주문상세</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div id="rootDivObj">
		<div id="titleDiv">
			<table id="headTable">
				<tr>
					<th id="headTitle">주문상세</th>
				</tr>
			</table>
			<hr id="headHr">
		</div>
		<div id="orderSummaryDiv">
			<c:choose>
				<c:when test="${orderDetailItemList.size() > 1}">
					<h4 class="orderSummaryTitle">${orderDetailItemList[0].FM_ITEM_NAME} 외 ${orderDetailItemList.size() - 1}개</h4>
				</c:when>
				<c:otherwise>
					<h4 class="orderSummaryTitle">${orderDetailItemList[0].FM_ITEM_NAME}</h4>
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
		</div>
		<div id="buyerInfoDiv">
			<h4>구매자정보</h4>
			이름			<input value="${orderDetailMyInfo.FM_USER_NICKNAME}" readonly="readonly"><br>
			연락처 		<input value="${orderDetailMyInfo.FM_USER_MOBILE}" readonly="readonly"><br>
		</div>
		
		<div id="deliveryInfoDiv">
			<h4>배송정보</h4>
			이름			<input value="${orderDetailMyInfo.FM_USER_NICKNAME}" readonly="readonly"><br>
			주소 		<input value="${orderDetailMyInfo.FM_USER_ZIP_CODE}" readonly="readonly"><br>
				 		<input value="${orderDetailMyInfo.FM_USER_ADDRESS}" readonly="readonly"><br>
			연락처		<input value="${orderDetailMyInfo.FM_USER_MOBILE}" readonly="readonly"><br>
		</div>
		<br>
		<div id="totalSummaryDiv">
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
		</div>
			<form id="confirmForm">
				<c:if test="${cNo[0] != 0}">
					<input type="button" id="orderConfirmBtn" value="구매하기">
					<input type="button" id="orderCancelBtn" value="취소">
				</c:if>
				<input type="hidden" name="oNo" value="${oNo}">
				<c:forEach var="cNo" items="${cNo}">
					<input type="hidden" name="cNo" value="${cNo}">
				</c:forEach>
			</form>
			<input type="button" value="주문리스트로" onclick="backToOrderListFnc();">
	</div>
</body>
</html>