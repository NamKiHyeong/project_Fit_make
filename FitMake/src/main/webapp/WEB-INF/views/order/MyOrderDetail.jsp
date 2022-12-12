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
		
		$('#searchBtn').on('click', function(){
			var searchOptionVal = $('#searchOption').val();
			var searchTextVal = $('#searchText').val();
			
			location.href = './list.do?searchOption=' + searchOptionVal + '&searchText=' + searchTextVal;
		});
		
		$('.orderDetailUpdateBtn').on('click', function(){
			var checkOrderCancel = confirm("주문을 취소하시겠습니까?");
			
			if(checkOrderCancel == true){
				$('#orderDetailForm').attr('action', './update.do');
				$('#orderDetailForm').attr('method', 'post');
				$('#orderDetailForm').submit();
			} else {
				return false;
			}
		});
		
	});
	
	function writeReviewFnc(oNo){
		var confirmWriteReview = confirm("리뷰 작성페이지로 이동하시겠습니까?");
		
		if(confirmWriteReview == true){
			
			$.ajax({
				type : 'POST',
				url : '../review/check.do',
				dataType : 'json',
				data : {
					'oNo' : oNo},
				error : function(request, status, error) {
					alert('code:' + request.status + '\n' + 'message:'
							+ request.responseText + '\n' + 'error:' + error);
				},
				success : function(data) {
					
					if(data == 0) {
						alert('작성 가능한 리뷰가 없습니다.');
						$('#writeReviewBtn').attr('disabled', true);
						$('#writeReviewBtn').css('background', 'grey');
						$('#writeReviewBtn').css('border', '2px solid grey');
						
						return false;
					} else {
						location.href='../review/add.do?oNo='+oNo;
					}
				}
			})
			
		} else {
			return false;
		}
	}
	
	function orderUpdateFnc(oNo, oStatus){
			
		if(oStatus === '주문취소'){
			var checkOrderCancel = confirm("주문을 취소하시겠습니까?");
			
			if(checkOrderCancel == true){
				$('#oStatusArr').val('cancel');
				$('#orderDetailForm').attr('action', './update.do');
				$('#orderDetailForm').attr('method', 'post');
				$('#orderDetailForm').submit();
			} else {
				return false;
			}
		} else{
			var checkOrderPixed = confirm("구매를 확정하시겠습니까?");
			
			if(checkOrderPixed == true){
				$('#oStatusArr').val('pixed');
				$('#orderDetailForm').attr('action', './update.do');
				$('#orderDetailForm').attr('method', 'post');
				$('#orderDetailForm').submit();
			} else {
				return false;
			}
		}
	}
</script>
<style type="text/css">
	#orderDetailRootDiv {
		display: flex;
		width : 1200px;
		height : 100%;
		margin: 0px auto;
		justify-content: space-between;
	}
	#myOrderDetailDiv{
		width : 1000px;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#orderDetailViewTitle{
		font-size: 26px;
		font-weight: 600;
	}
	#orderListDiv{
		border: 1px solid black;
		border-radius: 10px;
		padding: 10px;
		margin: 30px;
 		display: flex; 
		flex-direction: column;
	}
	#orderSummaryDiv{
		margin: 5px;
		display:flex;
		justify-content: space-between
	}
	#orderContainer{
		border: 1px solid black;
		border-radius: 10px;
		padding: 10px;
		margin: 10px;
	}
	#orderTable{
		position: relative;
		width: 100%;
	}
	.orderTableDetail{
		text-align: right;
	}
	.orderStatuswWithBtn{
		width: 900px;
		display: flex;
		justify-content: space-between;
	}
	.buyerInfo{
		width: 80px;
	}
	#myOrderDetailImg, #myOrderDetailImg > img{
		width : 300px;
		height: 200px;
	}
	
	#myOrderDetailImg > img {
		border: 1px solid #ddd;
		border-radius: 10px;
		object-fit: cover;
	}
	
	.orderDetailCancelBtn, .orderDetailPixedBtn{
		margin-left: 10px;
		width: auto;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
	#writeReviewBtn{
		margin-left: 10px;
		width: auto;
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
	<div style="height: 50px;"></div>
	<div id="orderDetailRootDiv">
		<jsp:include page="../MyPageLeft.jsp" />
			<div id="myOrderDetailDiv">
				<jsp:include page="../MyPageNav.jsp" />
				<div id="titleDiv">
					<p id="orderDetailViewTitle">주문상세조회</p>
				</div>
				
				<form id="orderDetailForm">
					<c:forEach var="orderDetailItem" items="${orderDetailItemList}" varStatus="status">
						<span>${orderDetailItem.FM_ORDER_DATE} 주문</span>
						<div id="orderListDiv">
							<div id="orderSummaryDiv">
								<input type="hidden" name="oNoArr" value="${orderDetailItem.FM_ORDER_NO}">
								<input type="hidden" name="oStatusArr" value="">
								<c:choose>
									<c:when test="${orderDetailItem.FM_ORDER_STATUS eq 'pending'}">
										<div class="orderStatuswWithBtn">
											주문대기
											<span>
												<input class="orderDetailCancelBtn" type="button" value="주문취소" onclick="orderUpdateFnc(${orderDetailItem.FM_ORDER_NO}, this.value);">
											</span>
										</div>
									</c:when>
									<c:when test="${orderDetailItem.FM_ORDER_STATUS eq 'confirm'}">
										<div class="orderStatuswWithBtn">
											주문승인
											<span>
												<input class="orderDetailCancelBtn" type="button" value="주문취소" onclick="orderUpdateFnc(${orderDetailItem.FM_ORDER_NO}, this.value);">
											</span>
											<span>
												<input class="orderDetailPixedBtn" type="button" value="구매확정" onclick="orderUpdateFnc(${orderDetailItem.FM_ORDER_NO}, this.value);">
											</span>
										</div>
									</c:when>
									<c:when test="${orderDetailItem.FM_ORDER_STATUS eq 'cancel'}">
										<div class="orderStatuswWithBtn">
											주문취소
										</div>
									</c:when>
									<c:otherwise>
										<div class="orderStatuswWithBtn">
											구매확정
											<span>
												<input id="writeReviewBtn" type="button" value="리뷰쓰기" onclick="writeReviewFnc(${orderDetailItem.FM_ORDER_NO})">
											</span>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div id="orderContainer">
								<table id="orderTable">
									<tr>
										<td id="myOrderDetailImg" colspan="2" rowspan="3">
											<img alt="image not founed" src="<c:url value='/image/${orderDetailItem.FM_ITEM_STORED_IMG_NAME}'/>">
										</td>
										<td class="orderTableDetail" colspan="2">
											<c:choose>
												<c:when test="${orderDetailItem.oCount == 1}">
														${orderDetailItem.FM_ITEM_NAME}
												</c:when>
												<c:otherwise>
													${orderDetailItem.FM_ITEM_NAME} 외 ${orderDetailItem.oCount-1}개
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
										<td>
										</td>
										<td>
										</td>
									</tr>
									<tr>
										<td>
										</td>
										<td class="orderTableDetail">
											<fmt:formatNumber value="${orderDetailItem.totalPrice}" />원
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div id="">
							<span>받는사람 정보</span>
							<hr>
							<table>
								<tr>
									<td class="buyerInfo">
										받는사람
									</td>
									<td >
										${orderDetailMyInfo.FM_USER_NICKNAME}
									</td>
								</tr>
								<tr>
									<td class="buyerInfo">
										연락처
									</td>
									<td>
										${orderDetailMyInfo.FM_USER_MOBILE}
									</td>
								</tr>
								<tr>
									<td class="buyerInfo">
										받는주소
									</td>
									<td>
										${orderDetailMyInfo.FM_USER_ADDRESS}
									</td>
								</tr>
							</table>
						</div>
					</c:forEach>
				</form>
			</div>
		</div>
	<!-- footer 시작 -->
	<jsp:include page="../Footer.jsp" />
	<!-- footer 끝 -->
</body>
</html>