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

<script type="text/javascript">
      
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
						<td>이메일</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><input type="text" value="닉네임"></td>
					</tr>
					<tr>
						<th>휴대폰 번호</th>
						<td><input type="text" value="휴대폰 번호"><input type="button" value="변경"></td>
					</tr>
					<tr>
						<th>현재 비밀번호</th>
						<td><input type="text" value="비밀번호 입력"><a>비밀번호 변경</a></td>
					</tr>
					<tr>
						<th>신규 비밀번호</th>
						<td><input type="password" value="신규 비밀번호 입력"></td>
					</tr>
					<tr>
						<th>신규 비밀번호 확인</th>
						<td><input type="password" value="비밀번호 확인"></td>
					</tr>
					<tr>
						<th>구매 포인트</th>
						<td>보유금액 <input type="text">원 <input type="button" value="충전"></td>
					</tr>
					<tr>
						<th>상세 정보</th>
						<td>나이 <input type="text"> 키<input type="text"> 몸무게<input type="text"></td>
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