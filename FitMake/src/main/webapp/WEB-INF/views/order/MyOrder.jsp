<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script> -->
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('select[name="oStatus"]').each(function() {
			$(this).val($(this).siblings('input').val());
		});
		
		$('#orderUpdateBtn').on('click', function(){
			$('#orderListForm').attr('action', './update.do');
			$('#orderListForm').attr('method', 'post');
			
			var oNoArr = [];
			var oStatusArr = [];
			
			$('input:checkbox[name="orderCheckbox"]').each(function() {
				
				if(this.checked == true){
					oNoArr.push(this.value);
					oStatusArr.push($('#oStatus'+ this.value).val());					
				}
			});
			
			$('#oNoArr').val(oNoArr);
			$('#oStatusArr').val(oStatusArr);
			
			$('#orderListForm').submit();
		});
				
		$('#checkAll').on('click', function(){			
			
			$('input:checkbox[name="orderCheckbox"]').each(function() {
				this.checked = $('#checkAll').is(':checked');
			});
			
		});
		
		$('#searchBtn').on('click', function(){
			var searchOptionVal = $('#searchOption').val();
			var searchTextVal = $('#searchText').val();
			
			location.href = './list.do?searchOption=' + searchOptionVal + '&searchText=' + searchTextVal;
		});
		
		$("#searchOption").val("${searchMap.searchOption}").prop("selected", true);
	});
	
	function viewDetailFnc(oNo){
		var orderDetailFormObj = $('#orderDetailForm');
		var orderNoObj = $('#orderNo');
		
		orderNoObj.val(oNo);
		orderDetailFormObj.attr('action', './detail.do');
		orderDetailFormObj.submit();
	}
	
</script>
<style type="text/css">
	form > div {
		border: 1px solid black;
	}
	#orderRootDiv {
		width : 1200px;
		margin: 0px auto;
		align-content: left;
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
		width: 75%;
		margin-left: 10%;
		margin-top: 2.4%
	}
	#orderListForm{
		width: 80%;
		height: 15%;
		margin-left: 5%;
		padding: 0px;
	}
	#fncDiv{
		text-align: right;
		margin-top: 2%; 
	}
	#searchSection {
		float: left;
		width: 40%;
		text-align: left;
		margin-left: 5%;
	}
	#btnSection{
		float: right;
		width: 30%;
		text-align: right;
	}
	.viewOrderDetail{
		
		text-align: right;
	}
</style>
<title>내 주문</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div id="orderRootDiv">
		<div id="titleDiv">
			<table id="headTable">
				<tr>
					<th id="headTitle">주문/배송 조회</th>
				</tr>
			</table>
			<hr id="headHr">
		</div>
		
		<form id="orderListForm">
			<c:forEach var="orderMap" items="${orderMapList}">
				<c:if test="${orderMap.oRownum eq '1'}">
					<div>
						<p>${orderMap.FM_ORDER_DATE} 주문<span class="viewOrderDetail"><a href="#">주문상세보기</a></span></p>
						<div>
							<c:choose>
									<c:when test="${orderMap.FM_ORDER_STATUS eq 'pending'}">
										<p>주문대기
											<span>
												<input type="button" value="주문취소">
											</span>
										</p>
									</c:when>
									<c:when test="${orderMap.FM_ORDER_STATUS eq 'confirm'}">
										<p>주문승인
											<span>
												<input type="button" value="주문취소">
											</span>
										</p>
									</c:when>
									<c:when test="${orderMap.FM_ORDER_STATUS eq 'cancel'}">
										<p>주문취소
										</p>
									</c:when>
									<c:otherwise>
										<p>구매확정
											<span>
												<input type="button" value="리뷰쓰기">
											</span>
										</p>	
									</c:otherwise>
								</c:choose>
								
							<table>
								<tr>
									<td colspan="2" rowspan="3">
										<img alt="image not founed" src="<c:url value='/image/${orderMap.FM_ITEM_STORED_IMG_NAME}'/>">
									</td>
									<td colspan="2">
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
										${FM_ORDER_DETAIL_COUNT}
									</td>
									<td>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</form>
	</div>
	
		<jsp:include page="/WEB-INF/views/order/OrderPaging.jsp" />
	<div id="pagingSection">
		<form id="pagingForm" action="./list.do" method="get">
			<input type="hidden" id="curPage" name="curPage" value="${oPagingMap.orderPaging.curPage}">
			<input type="hidden" name="searchOption" value="${searchMap.searchOption}">
			<input type="hidden" name="searchText" value="${searchMap.searchText}">
		</form>
	</div>
	
	<form id="orderDetailForm" method="post">
		<input type="hidden" id="orderNo" value="${orderMap.FM_ORDER_NO}" name="oNo">
	</form>
</body>
</html>