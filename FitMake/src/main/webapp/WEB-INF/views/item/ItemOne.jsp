<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<link rel="stylesheet" href="/fitmake/resources/css/itemOne.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div id="itemOneDiv">
		<div id="itemOneOuterWrap">
			<form id="itemOneForm" action="./update.do" method="get">
				<input type="hidden" name="iNo"	id="iNoInput" value="${itemDto.iNo}"><br>
				<input type="hidden" name="cNo"	value="${itemDto.cNo}"><br>
				<input type="hidden" name="curPage" value="${prevMap.curPage}">
				
				<div class="diet_wrap">
					<div class="frame">
						<div class="sortImg sort1">
							<c:forEach var="item" items="${fileList}">
								<img alt="image not found" src="<c:url value='/image/${item.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
							</c:forEach>
						</div>
						<div class="sortImg sort2">
							<p><span>제품명</span>
								<input class="info" type="text" name="iName" id="iName" value="${itemDto.iName}" readonly="readonly" disabled="disabled"><br></p>
							<p><span>가 &nbsp; 격</span>	 
								<input class="info" type="text" value="<fmt:formatNumber value="${itemDto.iSellprice}" />" readonly="readonly" disabled="disabled">
								<input type="hidden" name="iSellprice" value="${itemDto.iSellprice}">
							</p>
							<p>
								<span>칼로리</span>
								<input class="info" type="text" name="iCalory" value="${itemDto.iCalory}Kcal" readonly="readonly" disabled="disabled">
							</p>
			
							<c:choose>
								<c:when test="${_userDto_.uNo == 1}">
									<p><span>재 &nbsp; 고</span>	 <input class="info" type="number" name="iCount" id="iCount" value="${itemDto.iCount}" readonly="readonly"></p>
								</c:when>
								<c:otherwise>
									<p><span>개 &nbsp; 수</span>	 <input class="info" type="number" name="ctCount" id="ctCountInput" value="1"></p>
								</c:otherwise>
							</c:choose>
							
								<input type="hidden" value="${prevMap.cNo}">
								<input type="hidden" value="${prevMap.curPage}">
								
<!-- 								제품 리스트에서 아이템 하나를 클릭했을때 -->
								<c:if test="${prevMap.cNo!=0&&prevMap.curPage!=0}">
									<input class="itemCtr" type="button" value="뒤로가기" onclick="pageMoveListFnc(${prevMap.cNo},${prevMap.curPage});">
								</c:if>
<!-- 								메인에서 아이템 하나를 클릭했을 때 -->
								<c:if test="${prevMap.cNo==0||prevMap.curPage==0}">
									<input class="itemCtr" type="button" value="뒤로가기" onclick="pageMoveMainFnc();">
								</c:if>
							<c:if test="${_userDto_.uNo != 1}">
								<input class="itemCtr" type="button" id="addCartBtn" value="장바구니">
								<input class="itemCtr" type="button" id="addOrderBtn" value="구매하기">
							</c:if>
					
							<c:if test="${_userDto_.uNo == 1}">
								<input class="itemCtr" type="submit" value="수정하기">
							</c:if>
						</div>
					</div>
					<div class="iteminfo">
						<h3>제품상세정보</h3>
						<textarea style="resize: none;" rows="20" cols="120" readonly="readonly" style="padding:15px;">${itemDto.iOneDetail}</textarea>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../Footer.jsp" />
</body>
</html>