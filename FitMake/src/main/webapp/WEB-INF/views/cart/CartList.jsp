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
		$("#buyBtn").on("click", function() {
			
			var countCheck = $('#itemClassCount').val();
			
			if(countCheck > 0){
				var buyCheck = confirm("구매하시겠습니까?");
				
				if(buyCheck == true){
					$("#addForm").submit();
				} else {
					return false;
				}
			} else{
				alert("장바구니가 비어있습니다.");
				return false;
			}
		});
		
		function getTotalCartSum(){
			var totalPrice = 0;
			$(".cartTotalPriceEach").each(function(){
				totalPrice += $(this).innerHTML;
		    });
			$("#cartTotalPrice").text(totalPrice);
		}
		
		viewCartSummaryFnc();
		getTotalCartSum();
	});
	
	function countUpFnc(cartNo){
		var ctNo = $("#ctNo" + cartNo).val();
		var ModifiedCtCount = parseInt($("#ctCount" + cartNo).val()) + 1;
		
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

				viewCartSummaryFnc();
				location.reload();

			}
		});
	}
	
	function countDownFnc(cartNo){
		if($("#ctCount" + cartNo).val() > 1){
			var ctNo = $("#ctNo" + cartNo).val();
			var ModifiedCtCount = parseInt($("#ctCount" + cartNo).val()) - 1;
			
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
			
					viewCartSummaryFnc();
					location.reload();
				}
			});
		} else {
			var deletecheck = confirm("장바구니에서 삭제하시겠습니까?");
			
			if(deletecheck == true){
				location.href = "./delete.do?ctNo=" + cartNo;
			} else {
				return false;
			}
		}
	}
	
	function deleteCartFnc(cartNo){
		var deletecheck = confirm("장바구니에서 삭제하시겠습니까?");
		
		if(deletecheck == true){
			
			$.ajax({
				url : "../cart/delete.do",
				type : "post",
				dataType : "json",
				data : {"ctNo" : cartNo},
				success : function(data){
					alert("삭제완료");
					viewCartSummaryFnc();
					location.reload();
				}
			})

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
		width : 1000px;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#cartTitle{
		font-size: 26px;
		font-weight: 600;	
	}
	#addForm {
		width: 100%;
		padding: 0px;
	}
	#cartListFormDiv{
 		display: flex; 
		flex-direction: column;
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
		width : 150px;
		height: 150px;
		padding-left: 1.5%;
	}
	.tailHr {
		margin-top: 3%
	}
	.CartItemName {
		text-align: center;
	}
	.countModifyBtn{
		text-align: center;
	}
	.countOuput{
		width: 50px;
		text-align: center;
	}
	.cartCountArea {
		text-align: center;
	}
	.cartPrice{
		text-align: right;
	}
	.cartTotalPriceEach{
		text-align: right;
	}
	.deleteBtnArea{
		text-align: right;
	}
	#emptyCart{
		font-size: 20px;
		font-weight: 450;
		text-align: center;
	}
	#btnSection{
		text-align: right;
	}
</style>
<title>장바구니</title>
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
									<td class="imgArea" rowspan="3"><img alt="image not founded" src="<c:url value='/image/${cartMap.FM_ITEM_STORED_IMG_NAME}'/>"/></td>
									<td class="CartItemName">${cartMap.FM_ITEM_NAME}</td>		
									<td></td>
									<td class="deleteBtnArea"><input type="button" value="X" onclick="deleteCartFnc(${cartMap.FM_CART_NO});"></td>		
								</tr>
								<tr>
									<td></td>
									<td class="cartPrice">단가</td>
									<td class="cartPrice">${cartMap.FM_ITEM_SELLPRICE}</td>
								</tr>
								<tr>
									<td class="cartCountArea">
										<input class="countModifyBtn" id="ctCountDown${cartMap.FM_CART_NO}" type="button" value="∨" 
											onclick="countDownFnc(${cartMap.FM_CART_NO});">
										<input class="countOuput" id="ctCount${cartMap.FM_CART_NO}" type="number" value="${cartMap.FM_CART_COUNT}" 
											name="ctCount" readonly="readonly">
										<input class="countModifyBtn" id="ctCountUp${cartMap.FM_CART_NO}" type="button" value="∧" 
											onclick="countUpFnc(${cartMap.FM_CART_NO});">
									</td>
									<td class="cartPrice">총 금액</td>
									<td class="cartTotalPriceEach">${cartMap.FM_ITEM_SELLPRICE * cartMap.FM_CART_COUNT}</td>
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
				<div>
					<span id="cartTotalPrice"></span> 
				</div>
				<div id="btnSection">
					<input type="hidden" id="itemClassCount" value="${cartMapList.size()}">
					<input class="cartBtn" type="button" id="buyBtn" value="구매하기">
					<input class="cartBtn" type="button" value="이전페이지">
				</div>
			</form>	
		</div>		
	</div>
	
</div>
</body>
</html>