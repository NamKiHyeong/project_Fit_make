<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		for(var i = 0; i < ${orderMapList.size()}; i++){
			$('#oStatus'+ i).val($('#orderStatus'+ i).val());
		}
		
		$('#orderUpdateBtn').on('click', function(){
			$('#orderListForm').attr('action', './update.do');
			$('#orderListForm').submit();
		})
		
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
table {
	width: 1200px;
}

td {
	width: 200px;
}
</style>
<title>주문관리</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />

	<div style="width: 1500px; height: 1000px;">
		<div>
			<table>
				<tr>
					<th>주문관리</th>
				</tr>
			</table>
		</div>

		<table>
			<tr>
				<td></td>
				<td>주문날짜</td>
				<td>주문명</td>
				<td>주문금액</td>
				<td>주문자</td>
				<td>운송장</td>
				<td>주문상태</td>
			</tr>
		</table>
		
		<form id="orderListForm" method="post">
			<c:forEach var="orderMap" items="${orderMapList}">
				<table>
					<c:if test="${orderMap.oRownum eq '1'}">
						<tr>
							<td><input type="checkbox"></td>
							<td>${orderMap.FM_ORDER_DATE}</td>
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
							<td>${orderDetailMyInfo.FM_USER_NICKNAME}</td>
							<td>1111</td>
							<td>
								<select id="oStatus${orderMap.FM_ORDER_NO}"
									name="oStatus">
										<option value="wait">대기</option>
										<option value="confirm">승인</option>
										<option value="cancel">취소</option>
								</select>
							</td>
						</tr>
					</c:if>
				</table>
				<input type="hidden" id="orderStatus${orderMap.FM_ORDER_NO}" value="${orderMap.FM_ORDER_STATUS}" name="orderStatus">
			</c:forEach>
			<div>
				<input id="orderUpdateBtn" type="button" value="수정하기">
				<input id="orderDeleteBtn" type="button" value="삭제하기">
			</div>
		</form>
	</div>
		<form id="orderDetailForm" method="post">
			<input type="hidden" id="orderNo" value="${orderMap.FM_ORDER_NO}" name="oNo">
		</form>
</body>
</html>