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
	<input type="hidden" name="uNo" value="${myInfomap.FM_USER_NO}">
	이메일
	<input type='text' value="${myInfomap.FM_USER_EMAIL}" name="email">
	<br> 닉네임
	<input type='text' value="${myInfomap.FM_USER_NICKNAME}" name="nickName">
	<br> 비밀번호
	<input type='password' value="${myInfomap.FM_USER_PASSWORD}" name="password">
	<br> 휴대폰
	<input type='tel' value="${myInfomap.FM_USER_MOBILE}" name="mobile">
	<br> 우편번호
	<input type='text' value="${myInfomap.FM_USER_ZIP_CODE}" name="zipCode">
	<br> 주소
	<input type='text' value="${myInfomap.FM_USER_ADDRESS}" name="address">
	<br> 가입일
	<input type='text' value="${myInfomap.FM_USER_CRE_DATE}" name="createDate">
	<br> 포인트
	<input type="text" value="${myInfomap.FM_USER_POINT}" name="point">
	
	<br> 신체정보
	<br> 성별
	<input type="text" value="${myInfomap.FM_USER_BMI_GENDER}" name="gender"> 
	몸무게
	<input type="text" value="${myInfomap.FM_USER_BMI_WEIGHT}" name="weight">
	<br> 키
	<input type="text" value="${myInfomap.FM_USER_BMI_HEIGHT}" name="height">
	<br> BMI
	<input type="text" value="${myInfomap.FM_USER_BMI_RAW}" name="bRaw">
	<br> 목표 BMI
	<input type="text" value="${myInfomap.FM_USER_GOAL_BMI}" name="goalBmi">
	<br> 한끼 권장 칼로리
	<input type="text" value="${myInfomap.FM_USER_GOAL_CALORY}" name="goalcalory">
</body>

</html>