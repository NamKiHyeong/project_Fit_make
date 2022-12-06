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
			<div id="recommendItemArea">
				<c:forEach var="mainRecommendItem" items="${mainRecommendItemList}"> 
					<div>
						${mainRecommendItem.FM_ITEM_NO}
					</div>
					<div>
						${mainRecommendItem.FM_CATEGORY_NO}
					</div>
					<div>
						${mainRecommendItem.FM_ITEM_NAME}
					</div>
					<div>
						<a href="../item/one.do?iNo=${mainRecommendItem.FM_ITEM_NO}">
							<img class="recommendImg" alt="image not found" src="<c:url value='/image/${mainRecommendItem.FM_ITEM_STORED_IMG_NAME}' />"/>
						</a>
					</div>
					<div>
						${mainRecommendItem.FM_ITEM_SELLPRICE}
					</div>
				</c:forEach>
			</div>
			<div>
				<h2>상품을 등록해주세요</h2>
			</div>
		</div>
		<div>
			<p class="paddingPtag"></p>
			<p class="titlePtag">
				<a href="#">베스트</a>
			</p>
			<div id="bestItemArea">
				<c:forEach var="mainBestItem" items="${mainBestItemList}"> 
					<div>
						${mainBestItem.FM_ITEM_NO}
					</div>
					<div>
						${mainBestItem.FM_CATEGORY_NO}
					</div>
					<div>
						${mainBestItem.FM_ITEM_NAME}
					</div>
					<div>
						<img class="bestItem" alt="image not found" src="<c:url value='/image/${mainBestItem.FM_ITEM_STORED_IMG_NAME}' />"/>
					</div>
					<div>
						${mainBestItem.FM_ITEM_SELLPRICE}
					</div>
				</c:forEach>
			</div>
			<div>
				<h2>상품을 등록해주세요</h2>
			</div>
		</div>
		<div>
			<p class="paddingPtag"></p>
			<p class="titlePtag">
				<a href="../review/list.do?cNo=1">리뷰</a>
			</p>
			<div id="reviewListArea">
				<c:forEach var="mainReview" items="${mainReviewList}">
					<div>
						<img class="bestItem" alt="image not found" src="<c:url value='/image/${mainReview.FM_REVIEW_STORED_NAME}' />"/>
					</div>
					<div>
						${mainReview.FM_REVIEW_TITLE}
					</div>
					<div>
						${mainReview.FM_REVIEW_CONTENT}
					</div>
				</c:forEach>
			</div>
			<div>
				<h2>리뷰를 등록해주세요</h2>
			</div>
		</div>
	</div>
</body>
</html>