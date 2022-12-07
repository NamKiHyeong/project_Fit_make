<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#buyBtn').on('click', function() {
			
			var countCheck = $('#itemClassCount').val();
			
			if(countCheck > 0){
				var buyCheck = confirm('구매하시겠습니까?');
				
				if(buyCheck == true){
					$('input[name="ctCount"]').each(function(){
						$(this).prop('disabled', false);
					});
					$('#addForm').submit();
				} else {
					return false;
				}
			} else{
				alert('장바구니가 비어있습니다.');
				return false;
			}
		});
		
		getTotalCartSum();
		viewCartSummaryFnc();
		
		
	});
	
	function getFocusFnc(cartNo){
		$('#cartImgAnchor'+ cartNo).focus();
	}
	function getTotalCartSum(){
		var totalPrice = 0;
		$('.cartTotalPriceEach').each(function(){
			totalPrice += parseInt($(this).val());
	    });
		
		var totalPriceTrans = new Intl.NumberFormat().format(totalPrice);
		
		$('#cartTotalPrice').text(totalPriceTrans + '원');
	}
	
	function countUpFnc(cartNo){
		var ctNo = $('#ctNo' + cartNo).val();
		var ModifiedCtCount = parseInt($('#ctCount' + cartNo).val()) + 1;
		
		$.ajax({
			type : "POST",
			url : "../cart/update.do",
			dataType : "json",
			data : {
				"ctCount" : ModifiedCtCount,
				"ctNo" : ctNo
			},
			error : function(request, status, error) {
				alert("code:"
						+ request.status
						+ "\n"
						+ "message:"
						+ request.responseText
						+ "\n"
						+ "error:"
						+ error);
			},
			success : function(data) {
				var cartTotalPrice = new Intl.NumberFormat().format(data);
				viewCartSummaryFnc();
				$('#ctCount' + cartNo).val(ModifiedCtCount);
				$('#cartTotalPrice').text(cartTotalPrice+'원');
				getFocusFnc(cartNo);
			}
		})
	}
	
	function countDownFnc(cartNo){
		if($('#ctCount' + cartNo).val() > 1){
			var ctNo = $('#ctNo' + cartNo).val();
			var ModifiedCtCount = parseInt($('#ctCount' + cartNo).val()) - 1;
			
			$.ajax({
				type : "POST",
				url : "../cart/update.do",
				dataType : "json",
				data : {
					"ctCount" : ModifiedCtCount,
					"ctNo" : ctNo
				},
				error : function(request, status, error) {
					alert("code:"
							+ request.status
							+ "\n"
							+ "message:"
							+ request.responseText
							+ "\n"
							+ "error:"
							+ error);
				},
				success : function(data) {
					var cartTotalPrice = new Intl.NumberFormat().format(data);
					viewCartSummaryFnc();
					$('#ctCount' + cartNo).val(ModifiedCtCount);
					$('#cartTotalPrice').text(cartTotalPrice);
					getFocusFnc(cartNo);
				}
			});
		} else {
			var deletecheck = confirm('장바구니에서 삭제하시겠습니까?');
			
			if(deletecheck == true){
				location.href = './delete.do?ctNo=' + cartNo;
			} else {
				return false;
			}
		}
	}
	
	function deleteCartFnc(cartNo){
		var deletecheck = confirm('장바구니에서 삭제하시겠습니까?');
		
		if(deletecheck == true){
			
			$.ajax({
				url : "../cart/delete.do",
				type : "post",
				dataType : "json",
				data : {"ctNo" : cartNo},
				success : function(data){
					alert('삭제완료');
					viewCartSummaryFnc();
					location.reload();
				}
			});

		} else {
			return false;
		}
	}
	
</script>
<style type="text/css">
	#cartListRootDiv {
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: space-around;
		flex-direction: column;
		align-items: center;
	}
	#cartDiv{
		width : 1200px;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#cartTitle{
		font-size: 26px;
		font-weight: 600;	
	}
	#cartListFormDiv{
 		display: flex; 
		flex-direction: column;
	}
	#addForm {
		width: 100%;
		padding: 0px;
	}
	.cartItemTable{
		width: inherit;
	}
	.cartBtn {
		align-content: right;
	}
	.hiddenInfo{
		width: 100px;
	}
	.imgArea {
		text-align: center;
		width : 200px;
		height: 200px;
	}
	.imgArea > a > img {
		width: 200px;
    		height: 200px;
    		border: 1px solid silver;
    		border-radius: 10px;
	}
	.tailHr {
		margin-top: 5px;
	}
	.cartItemName {
		text-align: left;
		padding-left: 20px;
		vertical-align: top;
	}
	.countModifyBtn{
		text-align: center;
	}
	.countOuput{
		width: 40px;
    		text-align: right;
   		background-color: white;
    		padding-bottom: 1px;
    		color: black;
    		font-size: 20px;
	}
	.cartCountArea {
		text-align: center;
		width: 150px;
		vertical-align: middle;
		padding-left: 20px;
		
	}
	.cartPrice{
		text-align: right;
	}
	.cartTotalPriceEachTd{
		text-align: right;
		width: 150px;
	}
	.deleteBtnArea{
		text-align: right;
		vertical-align: top;
	}
	#emptyCart{
		font-size: 20px;
		font-weight: 450;
		text-align: center;
	}
	#btnSection{
		text-align: right;
		margin-bottom: 100px;
	}
	#cartTotalPriceDiv{
		font-size: 20px;
		font-weight: 450;
		text-align: right;
		margin: 20px;
	}
	.cartBtn{
		margin-left: 10px;
		width: 100px;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
</style>
<title>FitMake</title>
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
<div id="cartListRootDiv">
	<div id="cartDiv" >
		<div id="titleDiv">
			<p id="cartTitle">장바구니</p>
		</div>
		<div id="cartListFormDiv">
			<form id="addForm" action="../order/add.do" method="post">
			<hr id="headHr">
				<c:choose>
					<c:when test="${cartMapList.size() > 0}">
						<c:forEach var="cartMap" items="${cartMapList}">
							<input class="hiddenInfo" type="hidden" id="ctNo${cartMap.FM_CART_NO}" value="${cartMap.FM_CART_NO}" name="ctNo">
							<table class="cartItemTable">
								<tr>
									<td class="imgArea" rowspan="3">
										<a href="../item/one.do?iNo=${cartMap.FM_ITEM_NO}" >
											<img id="cartImg${cartMap.FM_ITEM_NO}" alt="image not founded" tabindex="${cartMap.FM_ITEM_NO}" src="<c:url value='/image/${cartMap.FM_ITEM_STORED_IMG_NAME}'/>"/>
										</a>
									</td>
									<td colspan="2" class="cartItemName">${cartMap.FM_ITEM_NAME}</td>		
									<td></td>
									<td class="deleteBtnArea">
										<a id="cartImgAnchor${cartMap.FM_CART_NO}" href="#" onclick="deleteCartFnc(${cartMap.FM_CART_NO});">
											<img id="cartImg${cartMap.FM_CART_NO}"alt="image not founded" width="20px" height="20px" src="/fitmake/resources/image/xButton.png">
										</a>
									</td>		
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td class="cartPrice">단가</td>
									<td class="cartPrice">
										<fmt:formatNumber value="${cartMap.FM_ITEM_SELLPRICE}" />원
									</td>
									
								</tr>
								<tr>
									<td class="cartCountArea">
										<a href="#" onclick="countDownFnc(${cartMap.FM_CART_NO});">
											<img alt="image not founded" width="20px" height="20px" src="/fitmake/resources/image/countDownButton.png">
										</a>&nbsp;
										<input class="countOuput" id="ctCount${cartMap.FM_CART_NO}" type="number" value="${cartMap.FM_CART_COUNT}" 
											name="ctCount" readonly="readonly" disabled="disabled">
											&nbsp;
										<a href="#" onclick="countUpFnc(${cartMap.FM_CART_NO});">
											<img alt="image not founded" width="20px" height="20px" src="/fitmake/resources/image/countUpButton.png">
										</a>
									</td>
									<td></td>
									<td class="cartPrice">총 금액</td>
									<td class="cartTotalPriceEachTd">
										<fmt:formatNumber value="${cartMap.FM_ITEM_SELLPRICE * cartMap.FM_CART_COUNT}" />원
										<input type="hidden" class="cartTotalPriceEach" value="${cartMap.FM_ITEM_SELLPRICE * cartMap.FM_CART_COUNT}">
									</td>
								</tr>
							</table>
							<input class="hiddenInfo"  type="hidden" name="iNo" value="${cartMap.FM_ITEM_NO}">
							<input class="hiddenInfo"  type="hidden" name="iSellprice" value="${cartMap.FM_ITEM_SELLPRICE}">
							<hr class="tailHr">
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>
							<p id="emptyCart">장바구니가 비었습니다</p>
						</div>
					</c:otherwise>
				</c:choose>
				<div id="cartTotalPriceDiv">
					<span id="cartTotalPrice"></span> 
				</div>
				<div id="btnSection">
					<input type="hidden" id="itemClassCount" value="${cartMapList.size()}">
					<input class="cartBtn" type="button" id="buyBtn" value="구매하기">
					<input class="cartBtn" type="button" value="메인화면으로" onclick="location.href='../main/main.do'">
				</div>
			</form>	
		</div>		
	</div>
</div>
</body>
</html>