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
		
		$("#testbtn").on("click", function(){
			
			var testArr = { 
					"iNo" : $("#testiNo").val(),
					"iCount" : 3
			};
			
			$.ajax({
				type : "POST",
				url : "../cart/addex.do",
				dataType : "json",
				data : testArr,
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

					if (data == 1) {
						//팝업으로 띄우는 방법을 알아볼 것
// 						cartHeaderView();
						// toastr css를 사용해도 되는지 알아볼 것
// 						toastr.options.preventDuplicates = true;
// 						toastr.success("예시");

						alert("장바구니 추가완료");
					} else if (data == 2) {

						alert("이미 추가 된 상품입니다");
					}

				}
			});
			
		});
		
		viewCartSummaryFnc();
		
	});
	
	function countUpFnc(cartNo){
		$("#cCount" + cartNo).val(parseInt($("#cCount" + cartNo).val().valueOf())+1);
		$("#cNoVal").val($("#cNo" + cartNo).val());
		$("#cCountVal").val($("#cCount" + cartNo).val());
		$("#cartUpdateForm").submit();
	}
	
	function countDownFnc(cartNo){
		if($("#cCount" + cartNo).val() > 1){
			$("#cCount" + cartNo).val(parseInt($("#cCount" + cartNo).val().valueOf())-1);
			$("#cNoVal").val($("#cNo" + cartNo).val());
			$("#cCountVal").val($("#cCount" + cartNo).val());
			$("#cartUpdateForm").submit();
		} else {
			var deletecheck = confirm("장바구니에서 삭제하시겠습니까?");
			
			if(deletecheck == true){
				location.href = "./delete.do?cNo=" + cartNo;
			} else {
				return false;
			}
		}
	}
	
	function deleteCartFnc(cartNo){
		var deletecheck = confirm("장바구니에서 삭제하시겠습니까?");
		
		if(deletecheck == true){
			location.href = "./delete.do?cNo=" + cartNo;
		} else {
			return false;
		}
	}
	
</script>
<style type="text/css">
	#headHr {
		margin-left: 6.5%;
		margin-top: 3%
	}
	#rootDivObj{
		width : 80%;
		align-content: left;
		text-align: right;
 		align-items: left; 
	}
	#headTable {
		width: 80%;
		margin-top: 5%;
		margin-left: 3%;
		padding-left: 6.5%;
		text-align: left;
	}
	#headTitle {
		font-size: 40px;
	}
	#cartItemTable, #addForm {
		width: 80%;
		height: 15%;
		margin-left: 5%;
		padding: 0px;
	}
	.cartBtn {
		align-content: right;
	}
	.hiddenInfo{
		width: 100px;
	}
	#imgArea {
		text-align: center;
		width : 150px;
		height: 150px;
		padding-left: 1.5%;
	}
	#tailHr {
		margin-left: 6.5%;
		margin-top: 3%
	}
	#CartItemName {
		text-align: left;
	}
	.countModifyBtn{
		text-align: center;
	}
	.countOuput{
		width: 50px;
		text-align: center;
	}
	#cartCountArea {
		text-align: left;
	}
	#emptyTable{
		width: 80%;
		height: 15%;
		padding: 0px;
	}
	#emptyRow{
		text-align: center;
	}
</style>
<title>장바구니</title>
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/Header.jsp" />
<%-- 	<jsp:include page="/WEB-INF/views/cart/CartSummary.jsp" /> --%>
	
	<div id="rootDivObj">
		<div id="titleDivObj">
			<table id="headTable">
				<tr>
					<th id="headTitle">장바구니</th>
				</tr>
			</table>
			
		</div>
		<form id="addForm" action="../order/add.do" method="post">
		<hr id="headHr">
			<c:choose>
				<c:when test="${cartMapList.size() > 0}">
					<c:forEach var="cartMap" items="${cartMapList}">
						<input class="hiddenInfo" type="hidden" id="cNo${cartMap.FM_CART_NO}" value="${cartMap.FM_CART_NO}" name="cNo">
						<table id="cartItemTable">
							<tr>
								<td id="imgArea" rowspan="3">img</td>
								<td id="CartItemName">${cartMap.FM_ITEM_NAME}</td>		
								<td></td>
								<td><input type="button" value="X" onclick="deleteCartFnc(${cartMap.FM_CART_NO});"></td>		
							</tr>
							<tr>
								<td></td>
								<td>단가</td>
								<td>${cartMap.FM_ITEM_SELLPRICE}</td>
							</tr>
							<tr>
								<td id="cartCountArea">
									<input class="countModifyBtn" id="cCountUp${cartMap.FM_CART_NO}" type="button" value="∨" 
										onclick="countDownFnc(${cartMap.FM_CART_NO});">
									<input class="countOuput" id="cCount${cartMap.FM_CART_NO}" type="number" value="${cartMap.FM_CART_COUNT}" 
										name="cCount" readonly="readonly">
									<input class="countModifyBtn" id="cCountDown${cartMap.FM_CART_NO}" type="button" value="∧" 
										onclick="countUpFnc(${cartMap.FM_CART_NO});">
								</td>
								<td>총 금액</td>
								<td>${cartMap.FM_ITEM_SELLPRICE * cartMap.FM_CART_COUNT}</td>
							</tr>
						</table>
						<input class="hiddenInfo"  type="hidden" name="iNo" value="${cartMap.FM_ITEM_NO}">
						<input class="hiddenInfo"  type="hidden" name="iPrice" value="${cartMap.FM_ITEM_SELLPRICE}">
						<hr id="tailHr">
					</c:forEach>
				</c:when>
				<c:otherwise>
					<table id="emptyTable">
							<tr>
								<td id="emptyRow" rowspan="3">장바구니에 담긴 물품이 없습니다</td>
							</tr>
					</table>
				</c:otherwise>
			</c:choose>
			<span id="cartTotalPrice"></span>  
			<input type="hidden" id="itemClassCount" value="${cartMapList.size()}">
			<input class="cartBtn" type="button" id="buyBtn" value="구매하기">
			<input class="cartBtn" type="button" value="이전페이지">
		</form>			
	</div>
	
	<input type="button" id="testbtn" value="카트테스트">
	<input type="hidden" id="testiNo" value="3">
	
	<div>
		<form id="cartUpdateForm" action="./update.do" method="post">
			<input type="hidden" name="cNo" id="cNoVal" value="">
			<input type="hidden" name="cCount" id="cCountVal" value="">
		</form>
	</div>
</body>
</html>