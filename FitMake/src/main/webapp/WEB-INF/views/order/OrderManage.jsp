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
		
		$('select[name="oStatus"]').each(function() {
			$(this).val($(this).siblings('input').val());
			
			if($(this).val() === 'cancel' || $(this).val() === 'pixed'){
				$(this).attr("disabled", true);				
			}
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
		
		$('#searchOption').val($('#prevSearchOption').val()).prop("selected", true);
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
	#orderRootDiv {
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: center;
	}
	#pagingDiv{
		display: flex;
		flex-direction: column;
	}
	#orderManageDiv{
		width: 1200px;
		
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#orderManageTitle{
		font-size: 26px;
		font-weight: 600;
	}
	#orderListDiv{
		padding: 10px;
		margin: 30px;
		border-top : 1px solid black;
 		display: flex; 
		flex-direction: column;
	}
	#orderManageTable td {
		text-align: center;
	}
	#orderViewTitleEmpty{
		font-size: 20px;
		font-weight: 600;
		text-align: center;
	}
	#fncDiv {
		display:flex;
		justify-content: space-between
	}
	#searchBtn{
		margin-left: 10px;
		width: 100px;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
	#orderUpdateBtn{
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
	<div id="orderRootDiv">
		<div id="pagingDiv">
			<div id="orderManageDiv">
				<div id="titleDiv">
					<p id="orderManageTitle">주문관리</p>
				</div>
			
				<form id="orderListForm">
					<div id="orderListDiv">
						<table id="orderManageTable">
							<tr>
								<td id="titleCheckArea" class="titleTd">
									<input type="checkbox" id="checkAll" value="">
								</td>
								<td class="titleTd">주문날짜</td>
								<td class="titleTd">주문명</td>
								<td class="titleTd">주문금액</td>
								<td class="titleTd">주문자</td>
								<td class="titleTd">운송장</td>
								<td class="titleTd">주문상태</td>
							</tr>
						<c:forEach var="orderMap" items="${orderMapList}">
							<c:if test="${orderMap.oRownum eq '1'}">
								<tr>
									<td id="orderCheckArea">
										<input type="checkbox" id="cbNo${orderMap.FM_ORDER_NO}" name="orderCheckbox" value="${orderMap.FM_ORDER_NO}">
									</td>
									<td id="orderDate">${orderMap.FM_ORDER_DATE}</td>
									<td>
										<a id="orderName" onclick="viewDetailFnc(${orderMap.FM_ORDER_NO})">
											<c:choose>
													<c:when test="${orderMap.oCount == 1}">
															${orderMap.FM_ITEM_NAME}
													</c:when>
													<c:otherwise>
														${orderMap.FM_ITEM_NAME} 외 ${orderMap.oCount-1}개
													</c:otherwise>
											</c:choose>
										</a>
									</td>
									<td>${orderMap.totalPrice}</td>
									<td>${orderMap.FM_USER_NICKNAME}</td>
									<td>1111</td>
									<td>
										<select id="oStatus${orderMap.FM_ORDER_NO}"
											name="oStatus">
												<option value="pending">대기</option>
												<option value="confirm">승인</option>
												<option value="cancel">취소</option>
												<option value="pixed">구매확정</option>
										</select>
										<input type="hidden" id="orderStatus${orderMap.FM_ORDER_NO}" value="${orderMap.FM_ORDER_STATUS}" name="orderStatus">
									</td>
								</tr>
							</c:if>
							</c:forEach>
							<c:if test="${orderMapList.size() < 1}">
								<p id="orderViewTitleEmpty">주문 내역이 없습니다</p>
							</c:if>
							<tr>
								<td>
									<input type="hidden" id="oNoArr" value="" name="oNoArr">
									<input type="hidden" id="oStatusArr" value="" name="oStatusArr">
								</td>
							</tr>
						</table>
					</div>
					<div id="fncDiv">
						<span id="searchSection">
								<select id="searchOption" name="searchOption">
										<option value="user">주문자</option>
									<option value="oStatus">주문상태</option>
								</select>
								<input type="search" id="searchText" name="searchText" value="${searchMap.searchText}">
								<input type="button" id="searchBtn" value="검색">
						</span>
						<span id="btnSection">
							<input id="orderUpdateBtn" type="button" value="수정하기">
						</span>
					</div>
				</form>
			</div>
		<jsp:include page="/WEB-INF/views/order/OrderPaging.jsp" />
		</div>
	</div>
	<!-- footer 시작 -->
	<jsp:include page="../Footer.jsp" />
	<!-- footer 끝 -->
	<div id="pagingSection">
		<form id="pagingForm" action="./list.do" method="get">
			<input type="hidden" id="curPage" name="curPage" value="${oPagingMap.orderPaging.curPage}">
			<input type="hidden" id="prevSearchOption" name="searchOption" value="${searchMap.searchOption}">
			<input type="hidden" id="prevSearchText" name="searchText" value="${searchMap.searchText}">
		</form>
	</div>
	
	<form id="orderDetailForm" method="post">
		<input type="hidden" id="orderNo" value="${orderMap.FM_ORDER_NO}" name="oNo">
	</form>
</body>
</html>