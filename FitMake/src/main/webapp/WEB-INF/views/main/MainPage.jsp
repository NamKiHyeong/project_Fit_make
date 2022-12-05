<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<style type="text/css">
#containerMainDiv {
	width: 1200px;
	margin: 0px auto;
}

.titlePtag {
	color: #222;
	font-size: 27px;
	font-weight: 500;
	letter-spacing: -0.09em;
}
</style>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="containerMainDiv">
		<div>
			<p class="titlePtag">
				<a href="../item/list.do?cNo=2">다이어트</a>
			</p>
		</div>
		<div>
			<p class="titlePtag">
				<a href="#">베스트</a>
			</p>
		</div>
		<div>
			<p class="titlePtag">
				<a href="../review/list.do?cNo=1">리뷰</a>
			</p>
		</div>
	</div>
</body>
</html>