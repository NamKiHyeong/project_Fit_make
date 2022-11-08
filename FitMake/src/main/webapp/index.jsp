<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
li {
	list-style: none;
}

#rootDiv {
	width: 100%;
	height: 100%;
}

#headerDiv {
	width: 100%;
	height: 25px;
}

#headerDiv ul {
	position: absolute;
	right: 0px;
	margin: 0px;
}

#headerDiv ul li {
	font-size: 13px; background-color : white;
	float: left;
	background-color: white;
}

#headerDiv a:link {
	width: 50px;
}

#logo_infoDiv {
	margin-top: 22px;
	text-align: center;
}

#infoDiv {
	position: absolute;
	right: -18px;
	top: 65px;
	width: 200px;
	height: 34px;
}

#infoDiv ul li{
	width: 40px;
	float: left;
}
#menu {
	width: 100%;
	height: 35px;
	text-align: center;
}

#menu ul li { /* menu -> ul -> li 태그의 스타일링 */
	background-color: white;
	list-style: none;
	float: left;
	line-height: 30px;
	text-align: center;
}

#menu a:link {
	width: 190px;
	text-decoration: none;
	display: block;
	color: black;
	font-weight: bold;
}

#menu .link:hover {
	background-color: white;
	color: #ff42e7;
}

#footerDiv {
	border: 1px solid black;
}
</style>
</head>
<body>
	<div id="rootDiv">
		<div id="headerDiv">
			<ul>
				<li><a href="#">홍길동</a></li>
				<li><a href="#">로그아웃</a></li>
			</ul>
		</div>
		<div id="logo_infoDiv">
			<a href="#"><img alt="메인로고" src="./img/mainlogo.png"></a>
		</div>
		<div id="infoDiv">
			<ul>
				<li><a href="#"><img alt="포인트관리" src="./img/point.png"></a></li>
				<li><a href="#"><img alt="내정보" src="./img/myinfo.png"></a></li>
				<li><a href="#"><img alt="회원관리"
						src="./img/membermanagement.png"></a></li>
				<li><a href="#"><img alt="장바구니" src="./img/cart.png"></a></li>
			</ul>
		</div>
		<div id="menu">
			<ul>
				<li><a href="#">전체 카테고리</a></li>
				<li><a href="#">다이어트</a></li>
				<li><a href="#">식단</a></li>
				<li><a href="#">특가</a></li>
				<li><a href="#">베스트</a></li>
			</ul>
		</div>
	</div>
</body>
</html>