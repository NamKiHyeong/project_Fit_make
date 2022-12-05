<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#history_Container {
	display: flex;
	width: 1200px;
	margin: 0px auto;
	justify-content: space-between;
}


#historytableDiv table {
	border-collapse: collapse;
	border-bottom: 2px solid #737373;
	text-align: center;
	width: 100%;
}
    
#historytableDiv th{
	border-top: 2px solid #737373;
	border-bottom: 1px solid #cbcbcb;
	height: 40px;
}

#historytableDiv tr, td{
	height: 30px;
}

#historyDiv {
	width: 1000px;
}

#topupPtag {
	font-size: 26px;
	font-weight: 600;
}
</style>
<title>FitMake</title>
</head>
<body>
	<jsp:include page="../Header.jsp" />
	<div id="history_Container">
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="historyDiv">
			<jsp:include page="../MyPageNav.jsp" />
			<p id="topupPtag">충전내역</p>
			<div id="historytableDiv">
				<table>
					<tr>
						<th>번호</th>
						<th>구분</th>
						<th>충전금액</th>
						<th>날짜</th>
					</tr>
					<c:forEach var="pointMap" items="${pointList}">
						<tr>
							<td>${pointMap.FM_POINT_NO}</td>
							<td>충전</td>
							<td>+${pointMap.FM_POINT_HISTORY}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm"
									value="${pointMap.FM_POINT_CRE_DATE}" /></td>
						</tr>
					</c:forEach>
				</table>
				<c:if test="${pointList.size() < 1}">
					<p style="font-size: 20px; font-weight: 600; text-align: center;">충전
						내역이 없습니다</p>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>