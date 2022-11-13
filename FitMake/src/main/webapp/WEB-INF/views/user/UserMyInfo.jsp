<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>

<style type="text/css">
</style>

<script type="text/javascript">
      
</script>

</head>

<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<h1>내정보</h1>

	이메일
	<input type='text' value="${userDto.email}">
	<br> 닉네임
	<input type='text' value="${userDto.nickName}">
	<br> 비밀번호
	<input type='password' value="${userDto.password}">
	<br> 휴대폰
	<input type='tel' value="${userDto.mobile}">
	<br> 우편번호
	<input type='text' value="${userDto.zipCode}">
	<br> 주소
	<input type='text' value="${userDto.address}">
	<br> 가입일
	<input type='text' value="${userDto.createDate}">
	
	<br> 신체정보
	<br> 성별
	<input type="text" value="${bmiCalc.gender}"> 
	몸무게
	<input type="text" value="${bmiCalc.weight}">
	<br> 키
	<input type="text" value="${bmiCalc.height}">
	<br> BMI
	<input type="text" value="${bmiCalc.bRaw}">
	<br> 목표 BMI
	<input type="text" value="${bmiCalc.goalBmi}">
	<br> 한끼 권장 칼로리
	<input type="text" value="${bmiCalc.goalCalory}">
</body>

</html>