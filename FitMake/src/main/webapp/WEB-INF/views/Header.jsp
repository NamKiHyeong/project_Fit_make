<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/fitmake/resources/css/header.css">
<title>FitMake</title>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/header.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		
		var headerDiv = $("#headerDiv");
		if (${_userDto_.email != null}) {
			headerDiv.css("background", "#ebebeb");
		} else {
			headerDiv.css("background", "#fff");
		}
		
	});
	
</script>
</head>
<body>
	<div id="rootDiv">
		<div id="logoInfo_Wrap">
			<div id="headerDiv">
				<ul>
					<c:if test="${_userDto_.email ne null}">
						<li><strong id="nicknameChk"></strong>님 <em>ㅣ</em></li>
						<li><strong id="pointChk"></strong> <em>ㅣ</em></li>
						<li></li>
						<li><a
							href="${pageContext.request.contextPath}/auth/logout.do">로그아웃</a></li>
					</c:if>
				</ul>
			</div>
			<div id="logo_infoDiv">
				<div id="logo">
					<form action="./mainpage/main.do" method="get">

						<a href="${pageContext.request.contextPath}/main/main.do"><img
							alt="메인로고" src="/fitmake/resources/image/mainlogo.jpg"></a>
					</form>
				</div>
				<div id="infoDiv">
					<c:if test="${_userDto_.email ne null}">
						<ul>
							<li><a
								href="${pageContext.request.contextPath}/user/pointHistory.do"><img
									alt="포인트관리" src="/fitmake/resources/image/point.png"></a></li>
							<li><a
								href="${pageContext.request.contextPath}/user/Info.do"><img
									alt="내정보" src="/fitmake/resources/image/myinfo.png"></a></li>
							<li><a
								href="${pageContext.request.contextPath}/order/list.do"><img
									alt="주문관리" src="/fitmake/resources/image/membermanagement.png"></a></li>
							<li class="dropdownCart"><a
								href="${pageContext.request.contextPath}/cart/list.do"
								data-toggle="collaspe"> <img alt="장바구니"
									src="/fitmake/resources/image/cart.png">
							</a>
								<div>
									<span class="" aria-hidden="true"></span>
									<div id="cartList">
										<table style="width: 100%" aria-hidden="true">
											<tbody id="cartView" aria-hidden="true">

											</tbody>
										</table>
										<hr />
										<div style="text-align: right">
											<span style="font-size: 22px;"> total : <span
												id="cartPrice"></span></span>
										</div>
									</div>
								</div></li>
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
						<li><a href="${pageContext.request.contextPath}/item/list.do?cNo=2">추천상품</a></li>
						<li><a href="#">베스트</a></li>
					</ul>
				</c:if>
			</div>
		</div>
	</div>
	<div id="padding_Div"></div>
</body>
</html>