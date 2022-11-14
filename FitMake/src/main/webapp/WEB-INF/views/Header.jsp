<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/fitmake/resources/css/header.css">
<title>헤더</title>

</head>
<body>
	<div id="rootDiv">
		<div id="logoInfo_Wrap">
			<div id="headerDiv">
				<ul>
					<c:if test="${_userDto_.email ne null}">
						<li><strong>${_userDto_.nickName}</strong>님&nbsp;&nbsp;</li>
						<li><strong>${_userDto_.point}원</strong>&nbsp;&nbsp;</li>
						<li><a
							href="${pageContext.request.contextPath}/auth/logout.do">로그아웃</a></li>
					</c:if>
				</ul>
			</div>
			<div id="logo_infoDiv">
				<div id="logo">
					<form action="./mainpage/main.do" method="get">

						<a href="${pageContext.request.contextPath}/mainpage/main.do"><img
							alt="메인로고" src="/fitmake/resources/image/mainlogo.png"></a>
					</form>
				</div>
				<div id="infoDiv">
					<c:if test="${_userDto_.email ne null}">
						<ul>
							<li><a href="#"><img alt="포인트관리"
									src="/fitmake/resources/image/point.png"></a></li>
							<li><a href="${pageContext.request.contextPath}/user/Info.do"><img alt="내정보"
									src="/fitmake/resources/image/myinfo.png"></a></li>
							<li><a href="#"><img alt="회원관리"
									src="/fitmake/resources/image/membermanagement.png"></a></li>
							<li><a href="#"><img alt="장바구니"
									src="/fitmake/resources/image/cart.png"></a></li>
						</ul>
					</c:if>
				</div>
			</div>
		</div>
		<div id="menu">
			<div id="navDiv">
				<c:if test="${_userDto_.email ne null}">
					<ul>
						<li><img alt="목록"
							src="/fitmake/resources/image/Kategorie.png"> 전체 카테고리</li>
						<li><a href="#">다이어트</a></li>
						<li><a href="#">식단</a></li>
						<li><a href="#">특가</a></li>
						<li><a href="#">베스트</a></li>
					</ul>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>