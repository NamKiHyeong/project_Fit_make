<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<link rel="stylesheet" href="/fitmake/resources/css/usermyinfo.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/myinfo.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#submitInp").click(function() {
			confirm("회원정보를 수정하시겠습니까?");
			if ($("#existingPwd").val() == null || $("#existingPwd").val() == '') {
				alert("비밀번호를 입력해주세요")
				return false;
			}
			$("#updateForm").submit();
		});
		
		$("#cancelInp").click(function () {
			location.href = "../user/Info.do";
		});
	});
</script>
</head>

<body>
	<jsp:include page="../Header.jsp" />
	<div style="height: 50px;"></div>
	<div id="container">
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="myInfoDiv">
			<jsp:include page="../MyPageNav.jsp" />
			<div id="updateDelete">
				<p id="myInfoP">내정보 수정</p>
				<a href="../user/userDelete.do"><span id="myInfoSpan">회원탈퇴</span></a>
			</div>
			<form action="./userUpdate.do" method="post" id="updateForm">
			<div id="tableDiv">
				<table>
					<tr>
						<th>계정</th>
						<td>${_userDto_.email}</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td><input type="text" class="npInp" id="nickNameChk" name="nickName"
							value="${myInfomap.FM_USER_NICKNAME}" placeholder="fitmake"><span
							id="result_check_Nickname"></span></td>
					</tr>
					<tr>
						<th>휴대폰 번호</th>
						<td><input class="mpInp" type="text"
							value="${myInfomap.FM_USER_MOBILE}" readonly></td>
					</tr>
					<tr>
						<th>현재 비밀번호</th>
						<td><input type="password" class="npInp" name="password" id="existingPwd"
							placeholder="현재 비밀번호를 입력해주세요"><a id="pwdView"
							onclick="viewPwdChange();">비밀번호 변경</a></td>
					</tr>
					<tr id="trpwd1" style="display: none;">
						<th>신규 비밀번호</th>
						<td><input type="password" name="newpassword" class="npInp" id="new_user_pwd"
							placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr id="trpwd2" style="display: none;">
						<th>신규 비밀번호 확인</th>
						<td><input type="password" class="npInp"
							id="new_user_pwd_check" placeholder="비밀번호를 한번더 입력하세요"><span
							id="result_check_Re_pwd"></span></td>
					</tr>
					<tr>
						<th>보유 포인트</th>
						<td><input type="text" class="mpInp" id="myPonit"
							value="${myInfomap.FM_USER_POINT}" readonly>원 <input
							type="button" id="topupBtn" value="충전" onclick="showPopup();"></td>
					</tr>
					<tr>
						<th>상세 정보</th>
						<td>성별 <input type="text" id="infoGender" class="detailInp"
							value="${myInfomap.FM_USER_BMI_GENDER}" readonly> 키 <input
							type="text" class="detailInp"
							value="${myInfomap.FM_USER_BMI_HEIGHT}" readonly> 몸무게 <input
							type="text" class="detailInp"
							value="${myInfomap.FM_USER_BMI_WEIGHT}" readonly></td>
					</tr>
				</table>
				<div id="infoBtn">
					<input id="submitInp" type="button" value="수정"> <input
						id="cancelInp" type="button" value="취소">
				</div>
				<input type="hidden" name="uNo" value="${_userDto_.uNo}">
			</div>
			</form>
		</div>
	</div>
		<!-- footer 시작 -->
	
		<jsp:include page="../Footer.jsp" />
	
		<!-- footer 끝 -->
</body>

</html>