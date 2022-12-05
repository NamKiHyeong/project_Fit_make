<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
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
	#orderConfirmRootDiv{
		display: flex;
		width : 1200px;
		margin: 0px auto;
		flex-direction: column;
	}
	#orderConfirmInnerDiv{
		margin: 0px auto;
		width: 1000px;
	}
	#titleDiv{
		margin-top: 100px;
		position: relative;
		overflow: hidden;
	}
	#orderViewTitle{
		font-size: 40px;
		font-weight: 600;
	}
	#orderConfirmSummary, #buyerInfoOuterDiv
	, #deliveryInfoOuterDiv {
		border : 1px solid black;
		border-collapse: collapse;
		border-radius : 5px;
	}
	#totalSummaryOuterDiv{
		border : 1px solid black;
		border-radius : 5px;
		margin-bottom: 50px;
		border-collapse: collapse;
	}
	
	#orderSummaryDiv{
		padding: 5px;
 		display: flex; 
	}
	.orderSummaryTitle{
		font-size: 30px;
		font-weight: 450;
	}
	#orderConfirmDiv{
		position: relative;
		margin: 10px;
		overflow:hidden;
	}
	.orderConfirmP{
		display: table;
		table-layout: fixed;
		width: 100%;
	}
	.orderConfirmItem{
		display:table-cell;
   		vertical-align: middle;
	}
	#buyerInfoTitle{
		font-size: 20px;
		font-weight: 450;
	}
	
	#buyerInfoDiv{
		margin-left: 10px;
	}
 	.buyerInfo{
 		display: table;
		table-layout: fixed;
		width: 100%;
 	} 
 	.buyerInfoContent{
 		display:table-cell;
   		vertical-align: middle;
 	}
 	
 	#deliveryInfoTitle{
		font-size: 20px;
		font-weight: 450;
	}
 	
 	#deliveryInfoDiv{
		margin-left: 10px;
	}
 	.deliveryInfo{
 		display: table;
		table-layout: fixed;
		width: 100%;
 	} 
 	.deliveryInfoContent{
 		display:table-cell;
   		vertical-align: middle;
 	}
	.deliveryAdress{
		width: 300px;
	}
	#totalSummaryDiv{
		margin-left: 10px;	
	}
	.totalSummary{
		font-size: 30px;
		font-weight: 450;
	}
	#totalPrice{
		font-size: 30px;
		font-weight: 450;
	}
	#confirmForm {
		padding: 10px;
		text-align: right;
		
	}
</style>
<title>FitMake</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="orderConfirmRootDiv">
		<div id="orderConfirmInnerDiv">
			<div id="titleDiv">
				<p id="orderViewTitle">주문내역 확인</p>
			</div>
			<div id="orderConfirmSummary">
				<div id="orderSummaryDiv">
					<c:choose>
						<c:when test="${orderConfirmItemList.size() > 1}">
							<span class="orderSummaryTitle">${orderConfirmItemList[0].FM_ITEM_NAME} 외 ${orderConfirmItemList.size() - 1}개</span>
						</c:when>
						<c:otherwise>
							<span class="orderSummaryTitle">${orderConfirmItemList[0].FM_ITEM_NAME}</span>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="orderConfirmDiv">
					<c:forEach var="orderConfirmItem" items="${orderConfirmItemList}">
						<p class="orderConfirmP">
							<span class="orderConfirmItem">${orderConfirmItem.FM_ITEM_NAME}</span>
							<span class="orderConfirmItem">
								<span>${orderConfirmItem.FM_ORDER_DETAIL_COUNT}개</span>
							</span>
							<span class="orderConfirmItem">
								<input class="orderConfirmPrice" type="hidden" 
									value="${(orderConfirmItem.FM_ORDER_DETAIL_PRICE * orderConfirmItem.FM_ORDER_DETAIL_COUNT)}">							
								가격 ${(orderConfirmItem.FM_ORDER_DETAIL_PRICE * orderConfirmItem.FM_ORDER_DETAIL_COUNT)}
							</span>
						</p>
					</c:forEach>
				</div>
			</div>
			<div id="buyerInfoOuterDiv">
				<div id="buyerInfoDiv">
					<p id="buyerInfoTitle">구매자 정보</p>
					<p class="buyerInfo">
						<span class="buyerInfoContent">이름</span>
						<span class="buyerInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_NICKNAME}</span>
						</span>
					</p>
					<p class="buyerInfo">
						<span class="buyerInfoContent">연락처</span>
						<span class="buyerInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_MOBILE}</span>
						</span>
					</p>
				</div>
			</div>
			<div id="deliveryInfoOuterDiv">
				<div id="deliveryInfoDiv">
					<p id="deliveryInfoTitle">배송 정보</p>
					<p class="deliveryInfo">
						<span class="deliveryInfoContent">이름</span>
						<span class="deliveryInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_NICKNAME}</span>
							<span></span>
						</span>
					</p>
					<p class="deliveryInfo">
						<span class="deliveryInfoContent">
							주소
						</span>
						<span class="deliveryInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_ZIP_CODE}</span>
							<span>${orderConfirmMyInfo.FM_USER_ADDRESS}</span>
							<span></span>
						</span>
					</p>
					<p class="deliveryInfo">
						<span class="deliveryInfoContent">
							연락처
						</span>
						<span class="deliveryInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_MOBILE}</span>
							<span></span>
						</span>
					</p>
				</div>
			</div>
			<div id="totalSummaryOuterDiv">
				<div id="totalSummaryDiv">
					<c:choose>
						<c:when test="${orderConfirmItemList.size() > 1}">
							<p class="totalSummary">${orderConfirmItemList[0].FM_ITEM_NAME} 외 ${orderConfirmItemList.size() - 1}개</p>
						</c:when>
						<c:otherwise>
							<p class="totalSummary">${orderConfirmItemList[0].FM_ITEM_NAME}</p>
						</c:otherwise>
					</c:choose>
					<p id="totalPrice">${orderConfirmItemList[0].totalPrice}</p>
				</div>
				<form id="confirmForm">
					<c:if test="${ctNo[0] != -1}">
						<input type="button" id="orderConfirmBtn" value="구매하기">
						<input type="button" id="orderCancelBtn" value="취소">
					</c:if>
					<input type="hidden" name="oNo" value="${oNo}">
					<c:forEach var="ctNo" items="${ctNo}">
						<input type="hidden" name="ctNo" value="${ctNo}">
					</c:forEach>
				<input type="button" value="주문리스트로" onclick="backToOrderListFnc();">
				</form>
			</div>
		</div>
	</div>
</body>
</html>