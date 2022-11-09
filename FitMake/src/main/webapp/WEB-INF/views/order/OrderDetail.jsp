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
<title>주문</title>
</head>
<body>

	<%-- 	<jsp:include page="/WEB-INF/views/Header.jsp" /> --%>

		<div>
			<table>
				<tr>
					<td><h1>주문내역 확인</h1></td>
				</tr>
			</table>
		</div>
		
		<div>
			<h4>주문내역 이름(ex: 건강한 닭가슴살 샐러드 외 2개)</h4>
			<table>
<%-- 				<c:forEach var="orderMap" items="${orderMapList}"> --%>
					<tr>
						<td>제품명</td>
						<td>갯수</td>
						<td>가격</td>
					</tr>
<%-- 				</c:forEach> --%>
			</table>
		</div>
		
		<div>
			<h4>구매자정보</h4>
			이름			<input value="" readonly="readonly"><br>
			연락처 		<input value="" readonly="readonly"><br>
		</div>
		
		<div>
			<h4>배송정보</h4>
			이름			<input value="" readonly="readonly"><br>
			주소 		<input value="" readonly="readonly"><br>
				 		<input value="" readonly="readonly"><br>
			연락처		<input value="" readonly="readonly"><br>
		</div>
		
		<div>
			<span>주문이름</span><br>
			<p>총금액</p>
		</div>
		
</body>
</html>