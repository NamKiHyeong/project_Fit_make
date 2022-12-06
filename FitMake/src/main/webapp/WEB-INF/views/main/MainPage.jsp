<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<style type="text/css">
/* div { */
/* 	border: 1px solid; */
/* } */
#containerMainDiv {
	width: 1200px;
	margin: 0px auto;
}
.paddingPtag {
	padding-top: 40px;
}
.titlePtag {
	color: #222;
	font-size: 27px;
	font-weight: 500;
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
	text-align: left;
    	font-size: 18px;
    	font-weight: 700;
    	margin-bottom: 0px;
    	padding-left: 21px;
    	letter-spacing: -0.1em;
}
.pPrice {
	font-weight: 700;
    	font-size: 1.5em;
    	letter-spacing: -0.05em;
}
</style>
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="containerMainDiv">
		<div>
			<p class="paddingPtag"></p>
			<p class="titlePtag">
				<a href="../item/list.do?cNo=2">추천상품</a>
			</p>
			<div class="ItemArea">
				<c:forEach var="mainRecommendItem" items="${mainRecommendItemList}"> 
					<div class="ItemDiv">
						<a href="../item/one.do?iNo=${mainRecommendItem.FM_ITEM_NO}">
							<img class="ItemImg" alt="image not found" src="<c:url value='/image/${mainRecommendItem.FM_ITEM_STORED_IMG_NAME}' />"/>
						</a>
					<p class="pTitle">${mainRecommendItem.FM_ITEM_NAME}</p>
					<p class="pPrice">${mainRecommendItem.FM_ITEM_SELLPRICE}원</p>
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
			<p class="paddingPtag"></p>
			<p class="titlePtag">
				<a href="#">베스트</a>
			</p>
			<div class="ItemArea">
				<c:forEach var="mainBestItem" items="${mainBestItemList}"> 
					<div class="ItemDiv">
						<img class="ItemImg" alt="image not found" src="<c:url value='/image/${mainBestItem.FM_ITEM_STORED_IMG_NAME}' />"/>
						<p class="pTitle">${mainBestItem.FM_ITEM_NAME}</p>
						<p class="pPrice">${mainBestItem.FM_ITEM_SELLPRICE}원</p>
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
			<p class="paddingPtag"></p>
			<p class="titlePtag">
				<a href="../review/list.do?cNo=1">리뷰</a>
			</p>
			<div class="ItemArea">
				<c:forEach var="mainReview" items="${mainReviewList}">
					<div class="ItemDiv">
						<img class="ItemImg" alt="image not found" src="<c:url value='/image/${mainReview.FM_REVIEW_STORED_NAME}' />"/>
						<p class="pTitle">${mainReview.FM_REVIEW_TITLE}</p>
						<p>${mainReview.FM_REVIEW_CONTENT}</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>