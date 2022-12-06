<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<style type="text/css">
#containerMainDiv {
	width: 1200px;
	margin: 0px auto;
}

.paddingPtag {
	padding-top: 40px;
}

.titlePtag {
	color: #222;
	font-size: 33px;
    	font-weight: 540;
	letter-spacing: -0.09em;
}

.ItemArea {
	display: flex;
}

.ItemDiv {
	width: 400px;
	text-align: center;
	padding-bottom: 30px;
}

.ItemImg {
	width: 357px;
	height: 305px;
	border: 1px solid #ddd;
	border-radius: 10px;
	object-fit: cover;
}

.pTitle {
	color: #555;
	text-align: left;
	font-size: 22px;
	font-weight: 560;
	margin-bottom: 0px;
	padding-left: 21px;
	letter-spacing: -0.1em;
}

.pPrice {
	text-align: left;
	font-weight: 500;
	font-size: 1.5em;
	letter-spacing: -0.05em;
	margin-top: 2px;
	padding-left: 21px;
}

#containerImg {
	overflow: hidden;
	background: no-repeat center top;
}

.mainImg {
	display: none;
	margin: 0px auto;
}

.mainImg.on {
	display: block;
}
#reviewDiv {
	margin-bottom: 50px
}
</style>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	const images = document.querySelectorAll('.mainImg');
	let current = 0;

	function showSlide() {
	  for(let i=0; i<images.length; i++) {
	    images[i].classList.remove('on');
	  }
	  current++;
	  if(current > images.length) {
	    current = 1;
	  }
	  images[current - 1].classList.add('on');
	  setTimeout(showSlide, 4000);
	}

	showSlide();
});
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div id="containerImg">
		<img class="mainImg" src="/fitmake/resources/image/salad.jpg" /> <img
			class="mainImg" src="/fitmake/resources/image/dietMeat.jpg" /> <img
			class="mainImg" src="/fitmake/resources/image/sweetpotato.jpg" />
	</div>
	<div id="containerMainDiv">
		<div>
			<p class="titlePtag">
				<a href="../item/list.do?cNo=2">추천상품</a>
			</p>
			<div class="ItemArea">
				<c:forEach var="mainRecommendItem" items="${mainRecommendItemList}">
					<div class="ItemDiv">
						<a href="../item/one.do?iNo=${mainRecommendItem.FM_ITEM_NO}">
							<img class="ItemImg" alt="image not found"
							src="<c:url value='/image/${mainRecommendItem.FM_ITEM_STORED_IMG_NAME}' />" />
						</a>
						<p class="pTitle">${mainRecommendItem.FM_ITEM_NAME}</p>
						<p class="pPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${mainRecommendItem.FM_ITEM_SELLPRICE}"/>원</p>
					</div>
				</c:forEach>
			</div>
			<c:if test="${mainRecommendItem.size() < 1}">
				<div>
					<h2>상품을 등록해주세요</h2>
				</div>
			</c:if>
		</div>
		<div>
			<p class="titlePtag">
				<a href="#">베스트</a>
			</p>
			<div class="ItemArea">
				<c:forEach var="mainBestItem" items="${mainBestItemList}">
					<div class="ItemDiv">
						<img class="ItemImg" alt="image not found"
							src="<c:url value='/image/${mainBestItem.FM_ITEM_STORED_IMG_NAME}' />" />
						<p class="pTitle">${mainBestItem.FM_ITEM_NAME}</p>
						<p class="pPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${mainBestItem.FM_ITEM_SELLPRICE}" />원</p>
					</div>
				</c:forEach>
			</div>
			<c:if test="${mainRecommendItem.size() < 1}">
				<div>
					<h2>상품을 등록해주세요</h2>
				</div>
			</c:if>
		</div>
		<div id="reviewDiv">
			<p class="titlePtag">
				<a href="../review/list.do?cNo=1">리뷰</a>
			</p>
			<div class="ItemArea">
				<c:forEach var="mainReview" items="${mainReviewList}">
					<div class="ItemDiv">
						<img class="ItemImg" alt="image not found"
							src="<c:url value='/image/${mainReview.FM_REVIEW_STORED_NAME}' />" />
						<p class="pTitle">${mainReview.FM_REVIEW_TITLE}</p>
						<p>${mainReview.FM_REVIEW_CONTENT}</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<jsp:include page="../Footer.jsp"/>
</body>
</html>