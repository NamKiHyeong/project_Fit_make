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
		
		viewCartSummaryFnc();
		
	});
	
	function countUpFnc(cartNo){
		var ctNo = $("#ctNo" + cartNo).val();
		var ModifiedCtCount = parseInt($("#ctCount" + cartNo).val()) + 1;
		
		$.ajax({
			type : "POST",
			url : "../cart/updateex.do",
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
				url : "../cart/updateex.do",
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
		width: 1200px;
		margin: 0px auto;
	}
	#headHr {
/* 		margin-left: 6.5%; */
		margin-top: 3%
	}
	#headTable {
		width: 80%;
		margin-top: 5%;
/* 		margin-left: 3%; */
/* 		padding-left: 6.5%; */
		text-align: left;
	}
	#headTitle {
		font-size: 40px;
	}
	#cartItemTable, #addForm {
		width: 80%;
		height: 15%;
/* 		margin-left: 5%; */
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
/* 		margin-left: 6.5%; */
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
	
<div id="cartListRootDiv" align="center">
	<div id="textDivObj" >
		<div id="titleDivObj">
			<table id="headTable">
				<tr>
					<th id="headTitle">장바구니</th>
				</tr>
			</table>
		</div>
		<input type="button" value="인쿼리" onclick="location.href='../inquiry/list.do'">
		<form id="addForm" action="../order/add.do" method="post">
		<hr id="headHr">
			<c:choose>
				<c:when test="${cartMapList.size() > 0}">
					<c:forEach var="cartMap" items="${cartMapList}">
						<input class="hiddenInfo" type="hidden" id="ctNo${cartMap.FM_CART_NO}" value="${cartMap.FM_CART_NO}" name="ctNo">
						<table id="cartItemTable">
							<tr>
								<td id="imgArea" rowspan="3"><img alt="image not founded" src="<c:url value='/image/${cartMap.FM_ITEM_STORED_IMG_NAME}'/>"/></td>
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
									<input class="countModifyBtn" id="ctCountDown${cartMap.FM_CART_NO}" type="button" value="∨" 
										onclick="countDownFnc(${cartMap.FM_CART_NO});">
									<input class="countOuput" id="ctCount${cartMap.FM_CART_NO}" type="number" value="${cartMap.FM_CART_COUNT}" 
										name="ctCount" readonly="readonly">
									<input class="countModifyBtn" id="ctCountUp${cartMap.FM_CART_NO}" type="button" value="∧" 
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
	
</div>
</body>
</html>