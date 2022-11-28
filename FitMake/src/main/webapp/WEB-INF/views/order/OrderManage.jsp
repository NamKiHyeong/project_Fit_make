<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		for(var i = 0; i < ${orderMapList.size()}; i++){
			$('#oStatus'+ i).val($('#orderStatus'+ i).val());
		}
		
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
	#rootDivObj {
		width : 80%;
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
	.titleTd{
		width: 10%;
	}
	#orderListForm{
		width: 80%;
		height: 15%;
		margin-left: 5%;
		padding: 0px;
	}
	#orderManageTable{
		height: 15%;
		text-align: center;
		margin-left: 6%;
		padding: 0px;
	}
	#titleCheckArea{
		width: 5%;
	}
	#orderCheckArea{
		width: 3%;
	}
	#orderDate{
		width: 15%;
		text-align: center;
	}
	#btnDiv{
		text-align: right;
		margin-top: 2%;
	}
</style>
<title>주문관리</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />

	<div id="rootDivObj">
		<div id="titleDiv">
			<table id="headTable">
				<tr>
					<th id="headTitle">주문관리</th>
				</tr>
			</table>
			<hr id="headHr">
		</div>
		
		<form id="orderListForm">
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
							<td>${orderDetailMyInfo.FM_USER_NICKNAME}</td>
							<td>1111</td>
							<td>
								<select id="oStatus${orderMap.FM_ORDER_NO}"
									name="oStatus">
										<option value="pending">대기</option>
										<option value="confirm">승인</option>
										<option value="cancel">취소</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" id="orderStatus${orderMap.FM_ORDER_NO}" value="${orderMap.FM_ORDER_STATUS}" name="orderStatus">
								
							</td>
						</tr>
					</c:if>
					</c:forEach>
					<tr>
						<td>
							<input type="hidden" id="oNoArr" value="" name="oNoArr">
							<input type="hidden" id="oStatusArr" value="" name="oStatusArr">
						</td>
					</tr>
				</table>
			<div id="btnDiv">
				<input id="orderUpdateBtn" type="button" value="수정하기">
			</div>
		</form>
	</div>
	
<%-- 	<jsp:include page="./OrderPaging.jsp"/>	 --%>
	
		<form id="orderDetailForm" method="post">
			<input type="hidden" id="orderNo" value="${orderMap.FM_ORDER_NO}" name="oNo">
		</form>
</body>
</html>