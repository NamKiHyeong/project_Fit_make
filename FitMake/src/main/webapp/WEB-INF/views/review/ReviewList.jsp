<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>

<link rel="stylesheet" href="/fitmake/resources/css/reviewlist.css">
<script type="text/javascript" src="/fitmake/resources/js/review.js"></script>
<script type="text/javascript">
function deleteReivewFnc(rNo) {
	var deletechech = confirm("리뷰를 삭제하시겠습니까?");
	
	if(deletechech == true){
		location.href = "./deleteOne.do?rNo=" + rNo
	} else{
		return false;
	}
}

function reviewOneFnc(rNo){
	var reviewStr = 'reviewOneForm' + rNo;
	var reviewOneFormObj = document.getElementById(reviewStr);
	
	reviewOneFormObj.submit();
}
	
function deleteReviewFnc(rNo, iNo){
	var deletecheck = confirm("리뷰를 삭제하시겠습니까?");
  
	if(deletecheck == true){
		location.href = "./deleteOne.do?rNo=" + rNo+ '&iNo=' + iNo;
	} else {
		return false;
	}
}
</script>
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
<%-- 	<a href="./add.do?cNo=${pagingMap.cNo}"></a> --%>
	<div>
		<c:forEach var="review" items="${reviewList}">
			<div>
				<form id="reviewOneForm${review.reviewDto.rNo}" action="./one.do" method="get">
				
<%-- 					<input type="hidden" name="cNo" value="${paging.cNo}"> --%>
					<input type="hidden" name="iNo" value="${review.reviewDto.iNo}">
					<input type="hidden" name="rNo" value="${review.reviewDto.rNo}">
					
					<div class="sortImg sort1">
						<img alt="image not found" src="<c:url value='/image/${review.fileMap.FM_REVIEW_STORED_NAME}'/>"/>
					</div>
					<div class="sortImg sort2">
						<p>
						<a href="#" onclick="reviewOneFnc(${review.reviewDto.rNo});">
							제목 : ${review.reviewDto.rTitle}
						</a>
						
							<c:if test="${review.reviewDto.uNo eq _userDto_.uNo}">
								<input class="itemCtr" type="button" value="삭제" onclick='deleteReviewFnc(${review.reviewDto.rNo}, ${review.reviewDto.iNo});'><br>
							</c:if>
						</p>
						<p>내용 : <textarea rows="" cols="">${review.reviewDto.rContent}</textarea> </p>
					</div>
				</form>
			</div>
		</c:forEach>
		
	</div>

</body>
</html>