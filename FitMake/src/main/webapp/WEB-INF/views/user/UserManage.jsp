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
	width: 800px;
	margin: 0px auto;
}
#userTableDiv {
	width: 600px;
	margin: 0px auto;
}
</style>

<script type="text/javascript">
	
</script>

</head>

<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="userContainerDiv">
		<h2>회원관리</h2>
		<div id="userTableDiv">
			<table>
				<tr>
					<th>번호</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>포인트</th>
					<th>성별</th>
					<th>가입일</th>
				</tr>
				<c:forEach var="userMap" items="${userMapList}">
				<tr>
					<td>${userMap.FM_USER_NO}</td>
					<td>${userMap.FM_USER_NICKNAME }</td>
					<td>${userMap.FM_USER_EMAIL }</td>
					<td>${userMap.FM_USER_MOBILE }</td>
					<td>${userMap.FM_USER_POINT }</td>
					<td>${userMap.FM_USER_BMI_GENDER }</td>
					<td>
					<fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
									value="${userMap.FM_USER_CRE_DATE}" /></td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<jsp:include page="../user/UserPaging.jsp" />
	</div>
	
	
	
	
	<div id="pagingSection">
		<form id="pagingForm" action="./Info.do" method="get">
			<input type="hidden" id="curPage" name="curPage"
				value="${uPagingMap.userPaging.curPage}">
		</form>
	</div>
</body>


</html>