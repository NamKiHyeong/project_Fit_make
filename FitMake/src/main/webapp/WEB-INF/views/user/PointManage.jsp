<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
#userContainerDiv {
	width: 1200px;
	height: 100%;
	margin: 0px auto;
}

#userTableDiv table {
	border-collapse: collapse;
	width: 100%;
}

#userTableDiv table, th, tr, td {
	border: 1px solid #cbcbcb;
	padding-left: 5px;
}

#userTableDiv th {
	background: #f5f5f5;
	padding: 10px 0px 10px 0px;
}
</style>

<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>

</head>

<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="userContainerDiv">
		<h2>포인트관리</h2>
		<div id="userTableDiv">
			<table>
				<tr>
					<th>번호</th>
					<th>닉네임</th>
					<th>충전금액</th>
					<th>보유금액</th>
					<th>충전일</th>
				</tr>
				<c:forEach var="pointMap" items="${pointManage}">
					<tr>
						<td><span>${pointMap.FM_POINT_NO}</span></td>
						<td><span>${pointMap.FM_USER_NICKNAME }</span></td>
						<td><span>+<fmt:formatNumber type="number"
									maxFractionDigits="3" value="${pointMap.FM_POINT_HISTORY}" /></span></td>
						<td><span><fmt:formatNumber type="number"
									maxFractionDigits="3" value="${pointMap.FM_USER_POINT}" /></span></td>
						<td><fmt:formatDate pattern="yyyy년MM월dd일 hh시mm분ss초"
								value="${pointMap.FM_POINT_CRE_DATE}" /></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<jsp:include page="../user/UserPaging.jsp" />
	</div>

	<!-- footer 시작 -->
	
	<jsp:include page="../Footer.jsp" />
	
	<!-- footer 끝 -->
	<div id="pagingSection">
		<form id="pagingForm" action="./pointHistory.do" method="get">
			<input type="hidden" id="curPage" name="curPage"
				value="${uPagingMap.userPaging.curPage}">
		</form>
	</div>
</body>


</html>