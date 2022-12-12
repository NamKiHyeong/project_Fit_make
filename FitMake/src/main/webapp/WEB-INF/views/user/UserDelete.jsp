<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>

<style type="text/css">
#deleteContainer {
	display: flex;
	width: 1200px;
	height: 100%;
	margin: 0px auto;
	justify-content: space-between;
}

#deleteDiv {
	width: 1000px;
}

#deletePtag {
	font-size: 26px;
	font-weight: 600;
}

#deleteTableDiv {
	display: flex;
	flex-direction: column;
	align-items: center;
}

#deleteTableDiv table {
	border-collapse: collapse;
	width: 100%;
}

#deleteTableDiv table, th, tr, td {
	border: 1px solid #cbcbcb;
	padding-left: 20px;
}

#deleteTableDiv th {
	padding: 20px 0px 20px 0px;
	width: 180px;
	background: #f5f5f5;
}

.contentInput {
	width: 70%;
	height: 35px;
	padding-left: 11px;
	line-height: 35px;
	background: #f9f9f9;
	border: 1px solid #d6d6d6;
	color: #7e7e7e;
	font-size: 13px;
}

#deleteSubmit {
	padding-top: 30px;
}

#deleteBtn {
	width: 200px;
	background: #d7266d;
	margin-bottom: 70px;
	padding: 10px 0px;
	border: 1px solid #d7266d;
	color: #fff;
	text-align: center;
	font-size: 1em;
	font-weight: bold;
	border-radius: 3px;
	cursor: pointer;
}

#cancelBtn {
	width: 200px;
	background: #fff;
	margin-bottom: 70px;
	padding: 10px 0px;
	border: 1px solid #565656;
	color: #565656;
	text-align: center;
	font-size: 1em;
	font-weight: bold; border-radius : 3px;
	cursor: pointer;
	border-radius: 3px;
}
</style>

<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		$("#deleteBtn").click(function() {
			
			if ($("#deletePwd").val() == null || $("#deletePwd").val() == '') {
				alert("비밀번호를 입력해주세요");
				return false;
			}
			
			confirm("정말로 탈퇴하시겠습니까?");

		});

		$("#cancelBtn").click(function() {
			location.href = "${pageContext.request.contextPath}/user/Info.do";
		});
	});
</script>
</head>

<body>
	<!-- 헤더 include -->
	<jsp:include page="../Header.jsp" />
	<div style="height: 50px;"></div>
	<div id="deleteContainer">
		<!-- LeftNav include -->
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="deleteDiv">
			<!-- Order status include-->
			<jsp:include page="../MyPageNav.jsp" />
			<p id="deletePtag">회원탈퇴</p>
			<form action="../user/deleteCtr.do" method="post">
				<div id="deleteTableDiv">
					<table>
						<tr>
							<th>계정</th>
							<td><input class="contentInput" type="text" name="email"
								value="${_userDto_.email}" readonly></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" class="contentInput" id="deletePwd"
								name="password" placeholder="비밀번호 입력"> <c:if
									test="${msg == false}">
									<span style="font-size: 12px;">· 비밀번호가 맞지 않습니다</span>
								</c:if></td>

						</tr>
					</table>
					<div id="deleteSubmit">
						<input id="deleteBtn" type="submit" value="회원탈퇴"> <input
							id="cancelBtn" type="button" value="취소">
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- footer include -->
	<jsp:include page="../Footer.jsp" />
	
</body>


</html>