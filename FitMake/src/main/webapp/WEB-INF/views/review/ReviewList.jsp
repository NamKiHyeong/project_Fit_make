<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>
</head>
<body>
	<jsp:include page="../Header.jsp" />
	
	<h3>리뷰 목록</h3>
	
	<div>
		<ul>
			<li><a>리뷰 높은 순</a></li>
			<li><a>리뷰 낮은 순</a></li>
		</ul>
	</div>
	
	<div>
		<c:forEach var="review" items="${reviewList}">
			<div>
				<from id="reviewForm${reivew.reviewDto.rNo}" action="./one.do" method="get">
					<input type="hidden" name="iNo" value="${review.reviewDto.iNo}">
					<input type="hidden" name="cNo" value="${review.reviewDto.cNo}">
					<input type="hidden" name="rNo" value="${review.reviewDto.rNo}">
<%-- 					<input type="hidden" name="curPage" value="${}" --%>
					<p>제목 : ${review.reviewDto.rTitle}</p>
					<p>내용 : ${review.reviewDto.rContent}</p>
				</from>
			</div>
			
		</c:forEach>
		
	</div>

</body>
</html>