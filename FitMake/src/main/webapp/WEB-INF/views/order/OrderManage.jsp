<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>주문</title>
</head>
<body>

<%-- 	<jsp:include page="/WEB-INF/views/Header.jsp" /> --%>
	
	<div style="width: 500px; height: 400px; padding-top: 380px; text-align: center; align-items: center;">
		<div>
			<table>
				<tr>
					<th>주문관리</th>
				</tr>
			</table>
		</div>
			<table>
				<tr>
					<td>주문날짜</td>
					<td>주문명</td>
					<td>총금액</td>
					<td>주문자</td>
					<td>운송장</td>
					<td>주문상태</td>
				</tr>
				
				<c:forEach var="orderMap" items="${orderListMap}">			
					<tr>
						<td>${orderMap.FM_ORDER_DATE}</td>
						<td>주문1</td>		
						<td>${orderMap.FM_ORDER_DETAIL_PRICE}</td>		
						<td>${orderMap.FM_USER_NICKNAME}</td>		
						<td>1111</td>		
						<td>${orderMap.FM_ORDER_STATUS}</td>		
					</tr>
				</c:forEach>
			</table>
	</div>
</body>
</html>