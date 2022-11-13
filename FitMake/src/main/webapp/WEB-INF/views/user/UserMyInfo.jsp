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
	<input type='text' name='email'>
	<br> 닉네임
	<input type='text' name='nickName'>
	<br> 비밀번호
	<input type='password' name='password'>
	<br> 휴대폰
	<input type='tel' name='mobile'>
	<br> 우편번호
	<input type='text' name='zipCode'>
	<br> 주소
	<input type='text' name='address'>
	<br> 신체정보
	<br> 성별
	<br>
	<input type="text" name="gender"> 몸무게
	<input type="text" name="weight">
	<br> 키
	<input type="text" name="height">
</body>

</html>