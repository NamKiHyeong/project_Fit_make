<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>특가 더미 사이트(Item list 사이트)</title>

<link rel="stylesheet" href="/fitmake/resources/css/item.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div class="diet_wrap">
		<h3>다이어트</h3>
		<h4><a href="./add.do?cNo=${pagingMap.cNo}">제품을 추가</a></h4>
		<c:choose>
			<c:when test="${empty itemList}">
				<h4><a href="./add.do?cNo=${pagingMap.cNo}">제품을 등록해주세요</a></h4>
				
			</c:when>
			
			<c:otherwise>
				<div class="sortOrder">
					<ul class="sortOrderbox">
						<li><a href="./list.do?cNo=${pagingMap.cNo}&older=1" class="sortOrdervv" onclick="itemOneAsc();">낮은 가격순</a></li>
						<li><a href="./list.do?cNo=${pagingMap.cNo}&older=2" class="sortOrdervv" onclick="itemOneAsc();">높은 리뷰순</a></li>
					</ul>
				</div>
				
				<div id="frame">
					<c:forEach var="item" items = "${itemList}">
						<div class="CategoryItem">
							<form id="itemOneForm${item.itemDto.iNo}" action="./one.do" method="get">
								<input type="checkbox" name="iCkBox" value="${item.itemDto.iNo}">
								<input type="hidden" name="iNo" value="${item.itemDto.iNo}">
								<input type="hidden" name="cNo" value="${item.itemDto.cNo}">
								<input type="hidden" name="curPage" value="${pagingMap.itemPaging.curPage}">
								<input type="hidden" name="keyword" value="${searchMap.keyword}">
								<div class="sortImg">
									<img class="iImg" alt="image not found" src="<c:url value='/image/${item.fileMap.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
								</div>
								<p class="content"><a href="#" onclick="itemOneFnc(${item.itemDto.iNo});">${item.itemDto.iName}</a></p>
								<p class="itemBoundary">가격 : ${item.itemDto.iSellprice}</p>
								<p>리뷰 : ${item.itemDto.iCount}</p>
								
							</form>
						</div>
					</c:forEach>
				</div>
				</c:otherwise>
				
			</c:choose>
		</div>
		<input type="button" id="addCartListBtn" value="장바구니 추가">
	
	<form action="./list.do">
		<input type="hidden" name="cNo" value="${pagingMap.cNo}">
		<input type="text" name="keyword" value="${searchMap.keyword}">
		<input type="submit" value="검색">
<!-- 		src="/fitmake/resources/image/keyword.png" alt="제출버튼" -->
	</form>
	
	<jsp:include page="./ItemPaging.jsp"/>	
	
	<form action="./list.do" id="pagingForm" method="post">
		<input type="hidden" id="curPage" name="curPage" value="${pagingMap.itemPaging.curPage}">
		<input type="hidden" name="cNo" value="${pagingMap.cNo}">
		<input type="hidden" name="keyword" value="${searchmap.keyword}">
	</form>
</body>
</html>

