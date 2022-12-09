<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>

<link rel="stylesheet" href="/fitmake/resources/css/reviewOne.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>

</head>
<body>
	<jsp:include page="../Header.jsp" />
	<div style="height: 50px;"></div>
	
	<form action="./update.do" method="get" style="height: 1000px;">
		<input type="hidden" name="rNo" value="${reviewDto.rNo}">
		<input type="hidden" name="iNo" value="${reviewDto.iNo}">
		<input type="hidden" name="curPage" value="${prevMap.curPage}">
		
		<div class="diet_wrap">
			<div class="frame">
				<div class="sortImg sort1">
					<c:forEach var="review" items="${fileList2}">
						<img alt="image not found" src="<c:url value='/image/${review.FM_REVIEW_STORED_NAME}'/>"/><br>
					</c:forEach>
				</div>
				
				<div class="sortImg sort2">
					<h3>제목</h3><input type="text" class="reviewTitle"name="rTitle" value="${reviewDto.rTitle}" readonly="readonly"><br>
					<h3>내용</h3>
					 <textarea style="resize: none;" class="reviewInfo" rows="20" cols="80" name="rContent" readonly="readonly">${reviewDto.rContent}</textarea>
					
					<c:if test="${_userDto_.uNo == reviewDto.uNo}">
						<div id="reviewOneBtnArea">
							<input class="reviewCtr" type="submit" value="수정하기">
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</form>
	<!-- footer 시작 -->
	
	<jsp:include page="../Footer.jsp" />
	
	<!-- footer 끝 -->
</body>
</html>