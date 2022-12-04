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
	#orderRootDiv {
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: space-between;
	}
	#pagingDiv{
		display: flex;
		flex-direction: column;
	}
	#myOrderDiv{
		width : 1000px;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#orderViewTitle{
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
	#orderUpdateDiv{
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
	#orderViewTitleEmpty{
		font-size: 20px;
		font-weight: 600;
		text-align: center;
	}
</style>
<title>내 주문</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div id="orderRootDiv">
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="pagingDiv">
			<div id="myOrderDiv">
				<jsp:include page="../MyPageNav.jsp" />
				<div id="titleDiv">
					<p id="orderViewTitle">주문/배송 조회</p>
				</div>
				
				<form id="orderListForm">
					<c:forEach var="orderMap" items="${orderMapList}">
						<c:if test="${orderMap.oRownum eq '1'}">
							<div id="orderListDiv">
								<div id="orderSummaryDiv">
									${orderMap.FM_ORDER_DATE} 주문
									<span id="orderDetailViewSpan">
										<a href="./detail.do?oNo=${orderMap.FM_ORDER_NO}">
											<span class="viewOrderDetail">주문상세보기</span>
										</a>
									</span>
								</div>
								<div id="orderContainer">
									<div id="orderUpdateDiv">
										<c:choose>
											<c:when test="${orderMap.FM_ORDER_STATUS eq 'pending'}">
												주문대기
													<span>
														<input type="button" value="주문취소">
													</span>
											</c:when>
											<c:when test="${orderMap.FM_ORDER_STATUS eq 'confirm'}">
												주문승인
													<span>
														<input type="button" value="주문취소">
													</span>
												
												
											</c:when>
											<c:when test="${orderMap.FM_ORDER_STATUS eq 'cancel'}">
												주문취소
											</c:when>
											<c:otherwise>
												구매확정
													<span>
														<input type="button" value="리뷰쓰기">
													</span>
											</c:otherwise>
										</c:choose>
									</div>
									<table id="orderTable">
										<tr>
											<td colspan="2" rowspan="3">
												<img alt="image not founed" src="<c:url value='/image/${orderMap.FM_ITEM_STORED_IMG_NAME}'/>">
											</td>
											<td class="orderTableDetail" colspan="2">
												<c:choose>
														<c:when test="${orderMap.oCount == 1}">
																${orderMap.FM_ITEM_NAME}
														</c:when>
														<c:otherwise>
															${orderMap.FM_ITEM_NAME} 외 ${orderMap.oCount-1}개
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
											${orderMap.totalPrice}원
											</td>
										</tr>
									</table>
								</div>
							</div>
						</c:if>
					</c:forEach>
					<c:if test="${orderMapList.size() < 1}">
						<p id="orderViewTitleEmpty">주문 내역이 없습니다</p>
					</c:if>
				</form>
			</div>
		<jsp:include page="/WEB-INF/views/order/OrderPaging.jsp" />
		</div>
	</div>
	
	<div id="pagingSection">
		<form id="pagingForm" action="./list.do" method="get">
			<input type="hidden" id="curPage" name="curPage" value="${oPagingMap.orderPaging.curPage}">
		</form>
	</div>
	
</body>
</html>