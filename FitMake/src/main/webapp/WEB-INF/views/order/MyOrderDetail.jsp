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
		
	});
	
</script>
<style type="text/css">
	#orderDetailRootDiv {
		display: flex;
		width : 1200px;
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
	#orderDetailViewSpan{
		margin: 5px;
		display:flex;
		justify-content: space-between
	}
	#orderTable{
		position: relative;
		width: 100%;
	}
	.orderTableDetail{
		text-align: right;
	}
	#pagingNav {
		display: flex;
	}
</style>
<title>나의 주문상세</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div id="orderDetailRootDiv">
		<jsp:include page="../MyPageLeft.jsp" />
			<div id="myOrderDetailDiv">
				<jsp:include page="../MyPageNav.jsp" />
				<div id="titleDiv">
					<p id="orderDetailViewTitle">주문상세조회</p>
				</div>
				
				<form id="orderListForm">
					<span>${orderDetailItem.FM_ORDER_DATE} 주문</span>
					<div id="orderListDiv">
						<div id="orderSummaryDiv">
							<span id="orderDetailViewSpan">
								<c:choose>
									<c:when test="${orderDetailItem.FM_ORDER_STATUS eq 'pending'}">
										주문대기
										<span>
											<input type="button" value="주문취소">
										</span>
									</c:when>
									<c:when test="${orderDetailItem.FM_ORDER_STATUS eq 'confirm'}">
										주문승인
										<span>
											<input type="button" value="주문취소">
										</span>
									</c:when>
									<c:when test="${orderDetailItem.FM_ORDER_STATUS eq 'cancel'}">
										주문취소
									</c:when>
									<c:otherwise>
										구매확정
										<span>
											<input type="button" value="리뷰쓰기">
										</span>
									</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div id="orderContainer">
							<table id="orderTable">
								<tr>
									<td colspan="2" rowspan="3">
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
									${orderDetailItem.totalPrice}원
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div id="orderSummaryDiv">
						<span>받는사람 정보</span>
						<hr>
						<table>
							<tr>
								<td>
									받는사람
								</td>
								<td>
									${orderDetailMyInfo.FM_USER_NICKNAME}
								</td>
							</tr>
							<tr>
								<td>
									연락처
								</td>
								<td>
									${orderDetailMyInfo.FM_USER_MOBILE}
								</td>
							</tr>
							<tr>
								<td>
									받는주소
								</td>
								<td>
									${orderDetailMyInfo.FM_USER_ADDRESS}
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	
</body>
</html>