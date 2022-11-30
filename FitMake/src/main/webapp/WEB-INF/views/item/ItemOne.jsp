<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세정보</title>

<link rel="stylesheet" href="/fitmake/resources/css/itemOne.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	
	<form id="itemOneForm" action="./update.do" method="get">
		<input type="hidden" name="iNo"	id="iNoInput" value="${itemDto.iNo}" readonly="readonly"><br>
		<input type="hidden" name="cNo"	value="${itemDto.cNo}"><br>
		<input type="hidden" name="curPage" value="${prevMap.curPage}">
		<div class="diet_wrap">
		
			<div class="frame">
				<div class="sortImg">
					<c:forEach var="item" items="${fileList}">
		<%-- 		${row.ORIGINAL_FILE_NAME}(${row.FILE_SIZE}kb)<br> --%>
						<img alt="image not found" src="<c:url value='/image/${item.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
					</c:forEach>
				</div>
				<div class="sortImg" >
					<p>제품명	 <input class="info" type="text" name="iName" id="iName" value="${itemDto.iName}" readonly="readonly"><br></p>
					<p>가 격	 <input class="info" type="number" name="iSellprice" value="${itemDto.iSellprice}" readonly="readonly"></p>
					<p>칼로리	 <input class="info" type="number" name="iCalory" value="${itemDto.iCalory}"></p>
	
					<c:choose>
						<c:when test="${_userDto_.uNo == 1}">
							<p>재 고	 <input class="info" type="number" name="iCount" id="iCount" value="${itemDto.iCount}" readonly="readonly"></p>
						</c:when>
						<c:otherwise>
							<p>개 수	 <input class="info" type="number" name="ctCount" id="ctCountInput" value="1"></p>
						</c:otherwise>
					</c:choose>	
				</div>
			</div>
			
			<input class="itemCtrBack" type="button" value="뒤로가기" onclick="pageMoveListFnc(${itemDto.cNo});">
			<c:if test="${_userDto_.uNo != 1}">
				<input class="itemCtrCenter" type="button" id="addCartBtn" value="장바구니">
				<input class="itemCtr" type="button" id="addOrderBtn" value="구매하기">
				<input class="itemCtr" type="button" value="리뷰쓰기" onclick="pageReviewFnc(${itemDto.iNo});">
				<input class="itemCtr" type="button" value="리뷰목록" onclick="pageReviewListFnc(${itemDto.iNo});">
			</c:if>
			
			<c:if test="${_userDto_.uNo == 1}">
				<input class="itemCtr" type="submit" value="수정하기">
			</c:if>
			<br>
			<div class="iteminfo">
						<h3>제품상세정보</h3>
				<textarea rows="20" cols="100" readonly="readonly">${itemDto.iOneDetail}</textarea>
			</div>
		</div>
	</form>
</body>
</html>