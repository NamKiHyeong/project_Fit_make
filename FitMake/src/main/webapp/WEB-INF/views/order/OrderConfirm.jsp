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
	
		$('#orderConfirmBtn').on('click', function(){
			var checkOrderConfirm = confirm('구매 하시겠습니까?');
			
			if(checkOrderConfirm == true){
				var uPointStr = $('#pointChk').text(); 
				var uPoint = parseInt(uPointStr.substring(0, uPointStr.indexOf(" 원")));
				var totalPrice = parseInt($('#orderTotalPrice').val());
				
				if(totalPrice > uPoint) {
					alert("보유 포인트가 부족합니다.");
					return false;
				} else{
					$('#confirmForm').attr('action', './confirm.do');
					$('#confirmForm').attr('method', 'post');
					$('#confirmForm').submit();
				} 
				
			} else {
				return false;
			}
		})
		
		$('#orderCancelBtn').on('click', function() {
			var checkOrderCancel = confirm('구매를 취소 하시겠습니까?');
			
			if(checkOrderCancel == true){
				$('#confirmForm').attr('action', './cancel.do');
				$('#confirmForm').attr('method', 'post');
				$('#confirmForm').submit();
			}
		})
	})
	
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
		margin-top: 0px;
		position: relative;
		overflow: hidden;
	}
	#orderViewTitle{
		font-size: 40px;
		font-weight: 600;
	}
	#orderConfirmSummary{
		border : 1px solid black;
		border-collapse: collapse;
		border-radius : 5px;
		padding: 10px;
	}
	#buyerInfoOuterDiv, #deliveryInfoOuterDiv {
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
		width: 90%;
		text-align: center;
	}
	.orderConfirmItemName{
		display:table-cell;
   		vertical-align: middle;
   		border-right: 1px solid black;
		padding-left: 20px;
		text-align: left;
	}
	.orderConfirmItem{
		display:table-cell;
   		vertical-align: middle;
   		border-right: 1px solid black;
		padding-left: 20px;
	}
	#buyerInfoTitle{
		font-size: 20px;
		font-weight: 450;
	}
	#buyerInfoDiv{
		position: relative;
		margin: 10px;
		padding-left: 10px;
		padding-right: 10px;
	}
 	.buyerInfo{
 		display: table;
		table-layout: fixed;
		width: 100%;
		border: 1px solid black;
		padding-left: 20px;
 	} 
 	.buyerInfoContentHead{
 		display:table-cell;
 		width: 75px;
 		text-align: center;
 		border-right: 1px solid black;
   		vertical-align: middle;
   		background: #f5f5f5;
		padding: 20px 0px 20px 0px; 
 	}
 	.buyerInfoContent{
 		display:table-cell;
   		vertical-align: middle;
   		padding: 20px 20px 20px 20px;
 	}
 	
 	#deliveryInfoTitle{
		font-size: 20px;
		font-weight: 450;
	}
 	
 	#deliveryInfoDiv{
		position: relative;
		margin: 10px;
		padding-left: 10px;
		padding-right: 10px;
	}
 	.deliveryInfo{
 		display: table;
		table-layout: fixed;
		width: 100%;
		border: 1px solid black;
		padding-left: 20px;
 	} 
 	.deliveryInfoContentHead{
 		display:table-cell;
 		width: 75px;
 		border-right: 1px solid black;
 		text-align: center;
   		vertical-align: middle;
   		background: #f5f5f5;
		padding: 20px 0px 20px 0px;
 	}
 	.deliveryInfoContent{
 		display:table-cell;
   		vertical-align: middle;
   		padding: 20px 20px 20px 20px;
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
		padding-right: 40px;
		text-align: right;
	}
	#confirmForm {
		padding: 10px;
		text-align: right;
	}
	#orderCancelBtn, #orderConfirmBtn{
		margin-left: 10px;
		width: 100px;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
	#totalSummaryDiv{
		padding-left: 10px;
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
							<span class="orderConfirmItemName">${orderConfirmItem.FM_ITEM_NAME}</span>
							<span class="orderConfirmItem">
								<span>${orderConfirmItem.FM_ORDER_DETAIL_COUNT}개</span>
							</span>
							<span class="orderConfirmItem">
								<input class="orderConfirmPrice" type="hidden" 
									value="${(orderConfirmItem.FM_ORDER_DETAIL_PRICE * orderConfirmItem.FM_ORDER_DETAIL_COUNT)}">							
								<fmt:formatNumber value="${(orderConfirmItem.FM_ORDER_DETAIL_PRICE * orderConfirmItem.FM_ORDER_DETAIL_COUNT)}" />원  
							</span>
						</p>
					</c:forEach>
				</div>
			</div>
			<div id="buyerInfoOuterDiv">
				<div id="buyerInfoDiv">
					<p id="buyerInfoTitle">구매자 정보</p>
					<p class="buyerInfo">
						<span class="buyerInfoContentHead">이름</span>
						<span class="buyerInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_NICKNAME}</span>
						</span>
					</p>
					<p class="buyerInfo">
						<span class="buyerInfoContentHead">연락처</span>
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
						<span class="deliveryInfoContentHead">이름</span>
						<span class="deliveryInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_NICKNAME}</span>
							<span></span>
						</span>
					</p>
					<p class="deliveryInfo">
						<span class="deliveryInfoContentHead">
							주소
						</span>
						<span class="deliveryInfoContent">
							<span>${orderConfirmMyInfo.FM_USER_ZIP_CODE}</span>
							<span>${orderConfirmMyInfo.FM_USER_ADDRESS}</span>
							<span></span>
						</span>
					</p>
					<p class="deliveryInfo">
						<span class="deliveryInfoContentHead">
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
					<p id="totalPrice"><fmt:formatNumber value="${orderConfirmItemList[0].totalPrice}" />원</p>
				</div>
				<form id="confirmForm">
					<input type="hidden" name="orderTotalPrice" id="orderTotalPrice" value="${orderConfirmItemList[0].totalPrice}">
					<input type="button" id="orderConfirmBtn" value="구매하기">
					<input type="button" id="orderCancelBtn" value="취소">
					<input type="hidden" name="oNo" value="${oNo}">
					<c:forEach var="ctNo" items="${ctNo}">
						<input type="hidden" name="ctNo" value="${ctNo}">
					</c:forEach>
				</form>
			</div>
		</div>
	</div>
</body>
</html>