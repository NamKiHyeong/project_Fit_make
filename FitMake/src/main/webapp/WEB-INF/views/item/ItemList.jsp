<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>

<link rel="stylesheet" href="/fitmake/resources/css/itemList.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div style="height: 50px;"></div>
	<div class="diet_wrap">
		<div class="infoTop">
			<p id="categoryPtitle">${categoryName}</p>
			<input class="itemCtr" type="button" id="addCartBtn" value="장바구니 추가">
			<div class="serachGo">
				<form action="./list.do">
					<input type="hidden" name="cNo" value="${pagingMap.cNo}">
					<input type="text" name="keyword" style= "padding: 10px 15px; margin-right: 7px; font-size: 14px;box-sizing:border-box;" value="${searchMap.keyword}">
					<input class="itemCtr" type="submit" value="검색">
				</form>
			</div>
		</div>
		
		<c:choose>
			<c:when test="${empty itemList}">
				<h4><a href="./add.do?cNo=${pagingMap.cNo}">제품을 등록해주세요</a></h4>
			</c:when>
			
			<c:otherwise>
				<div class="sortOrder">
					<ul class="sortOrderbox">
						<li><c:if test="${_userDto_.uNo == 1}"><a href="./add.do?cNo=${pagingMap.cNo}" class="sortOrdervv" style="color: aqua;">제품 추가</a></c:if></li>
						<li><a href="./list.do?cNo=${pagingMap.cNo}&older=1" class="sortOrdervv" onclick="itemOneAsc();">낮은 가격순</a></li>
						<li><a href="./list.do?cNo=${pagingMap.cNo}&older=2" class="sortOrdervv" onclick="itemOneAsc();">높은 리뷰순</a></li>
					</ul>
				</div>
				
				<div id="frame">
					<c:forEach var="item" items = "${itemList}">
						<div class="CategoryItem">
							<form id="itemOneForm${item.getiNo()}" action="./one.do" method="get">
								<div style="text-align: left">
									<input class="itemListCB" type="checkbox" name="iCkBox" value="${item.getiNo()}">
									<input type="hidden" name="iNo" value="${item.getiNo()}">
									<input type="hidden" name="cNo" value="${item.getcNo()}">
									<input type="hidden" name="curPage" value="${pagingMap.itemPaging.curPage}">
									<input type="hidden" name="keyword" value="${searchMap.keyword}">
								</div>
								<div class="sortImg">
									<a class="iImgATag" href=# onclick="itemOneFnc(${item.getiNo()});" >
										<img class="iImg" alt="image not found" src="<c:url value='/image/${item.getiImgStoredName()}'/>"/>
									</a>
									<br>
								</div>
								<p class="content">
									<a href="#" onclick="itemOneFnc(${item.getiNo()});">
										${item.getiName()}
									</a>
								</p>
								<p class="itemBoundary">가격 : <fmt:formatNumber value="${item.getiSellprice()}" />원</p>
<%-- 								<p>리뷰 : ${item.review}</p> --%>
							</form>
						</div>
					</c:forEach>
				</div>
				</c:otherwise>
			</c:choose>
			
		</div>
	<jsp:include page="./ItemPaging.jsp"/>
	<jsp:include page="../Footer.jsp" />
	<form action="./list.do" id="pagingForm" method="post">
		<input type="hidden" id="curPage" name="curPage" value="${pagingMap.itemPaging.curPage}">
		<input type="hidden" name="cNo" value="${pagingMap.cNo}">
		<input type="hidden" name="keyword" value="${searchmap.keyword}">
	</form>
</body>
</html>

