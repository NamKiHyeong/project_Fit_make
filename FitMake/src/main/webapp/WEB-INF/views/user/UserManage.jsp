<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>

<style type="text/css">
#userContainerDiv {
	width: 1200px;
	min-height: 100%;
	margin: 0px auto;
}

#userTableDiv table {
	border-collapse: collapse;
	width: 100%;
}

#userTableDiv table, 
#userTableDiv th, 
#userTableDiv tr, 
#userTableDiv td {
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
<script type="text/javascript">
	$(document).ready(function() {

		$('.userGender').each(function() {
			var userGender = $(this).text();
			if (userGender == "M") {
				$(".userGender").text("남성");
			} else if (userGender == "W") {
				$(".userGender").text("여성");
			}
		});
	});
</script>

</head>

<body>
	<!-- 헤더 시작 -->
	<jsp:include page="../Header.jsp" />
	<!-- 헤더 끝 -->
	<div id="userContainerDiv">
		<h2>회원관리</h2>
		<div id="userTableDiv">
			<table>
				<tr>
					<th>번호</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>집주소</th>
					<th>포인트</th>
					<th>성별</th>
					<th>가입일</th>
				</tr>
				<c:forEach var="userMap" items="${userMapList}">
					<c:if test="${userMap.FM_USER_NO != 1}">
					<tr>
						<td><span>${userMap.FM_USER_NO}</span></td>
						<td><span>${userMap.FM_USER_NICKNAME }</span></td>
						<td><span>${userMap.FM_USER_EMAIL }</span></td>
						<td><span>${userMap.FM_USER_MOBILE }</span></td>
						<td><span>${userMap.FM_USER_ADDRESS }</span></td>
						<td style="text-align: right;"><span><fmt:formatNumber type="number"
									maxFractionDigits="3" value="${userMap.FM_USER_POINT}" />원</span></td>
						<td><span class="userGender">${userMap.FM_USER_BMI_GENDER }</span></td>
						<td style="text-align: right;"><fmt:formatDate pattern="yyyy년MM월dd일 hh시mm분ss초"
								value="${userMap.FM_USER_CRE_DATE}" /></td>
					</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
		<jsp:include page="../user/UserPaging.jsp" />
	</div>


	<!-- footer 시작 -->
	
	<jsp:include page="../Footer.jsp" />
	
	<!-- footer 끝 -->
	<div id="pagingSection">
		<form id="pagingForm" action="./Info.do" method="get">
			<input type="hidden" id="curPage" name="curPage"
				value="${uPagingMap.userPaging.curPage}">
		</form>
	</div>
</body>


</html>