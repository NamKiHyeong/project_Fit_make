<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>

<style type="text/css">
div {
	border: 1px solid;
}

table{
	border-collapse: collapse;
	width: 100%;
}

table, th, tr, td {
	border: 1px solid;
}

th{
	padding: 20px 0px 20px 0px;
    	width: 180px;
}

#container {
	display: flex;
	width: 1200px;
	margin: 0px auto;
	justify-content: space-between;
}
#myInfoDiv {
	width: 1000px;
}
#tableDiv {
	display: flex;
	flex-direction: column;
	align-items: center;
}
#infoBtn {

}

</style>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
      $(document).ready(function () {
		var infoGender = $("#infoGender").val();
		
		if (infoGender == "M") {
			$("#infoGender").val("남성");
		} else if (infoGender == "W") {
			$("#infoGender").val("여성");
		}
	});
</script>

</head>

<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="container">
	<jsp:include page="/WEB-INF/views/MyPageLeft.jsp" />
		<div id="myInfoDiv">
		<div style="height: 100px;"></div>
			<p>내정보 수정</p>
			<div id="tableDiv">
				<table>
					<tr>
						<th>계정</th>
						<td><input type="text" value="${_userDto_.email}" readonly="readonly"></td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><input type="text" value="${_userDto_.nickName}"></td>
					</tr>
					<tr>
						<th>휴대폰 번호</th>
						<td><input type="text" value="${myInfomap.FM_USER_MOBILE}"><input type="button" value="변경"></td>
					</tr>
					<tr>
						<th>현재 비밀번호</th>
						<td><input type="text" value=""><a>비밀번호 변경</a></td>
					</tr>
					<tr>
						<th>신규 비밀번호</th>
						<td><input type="password" value="" placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr>
						<th>신규 비밀번호 확인</th>
						<td><input type="password" value="" placeholder="비밀번호를 한번더 입력하세요"></td>
					</tr>
					<tr>
						<th>구매 포인트</th>
						<td>보유금액 <input type="text" value="${_userDto_.point}">원 <input type="button" value="충전"></td>
					</tr>
					<tr>
						<th>상세 정보</th>
						<td>성별 <input type="text" id="infoGender" value="${myInfomap.FM_USER_BMI_GENDER}"> 키<input type="text" value="${myInfomap.FM_USER_BMI_HEIGHT}"> 몸무게<input type="text" value="${myInfomap.FM_USER_BMI_WEIGHT}"></td>
					</tr>
				</table>
				<div id="infoBtn">
					<input type="button" value="확인"> <input type="button" value="취소">
				</div>
			</div>
		</div>
	</div>
</body>

</html>