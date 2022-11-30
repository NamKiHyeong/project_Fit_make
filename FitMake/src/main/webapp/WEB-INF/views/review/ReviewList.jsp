<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>

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

function itemOneFnc(rNo}){
	
	var reviewStr = 'reviewOneForm' + rNo;
	var reviewOneFormObj = document.getElementById("reviewStr");
	
	reviewOneForm.submit();
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
				<form id="reviewForm${review.reviewDto.rNo}" action="./one.do" method="get">
					<input type="hidden" name="iNo" value="${review.reviewDto.iNo}">
					<input type="hidden" name="cNo" value="${paging.cNo}">
					<input type="hidden" name="rNo" value="${review.reviewDto.rNo}">
					
					<div>
						<img alt="image not found" src="<c:url value='/image/${review.fileMap.FM_REVIEW_STORED_NAME}'/>"/>
					</div>
					<p><a href="#" onclick="itemOneFnc(${review.reviewDto.rNo});">제목 : ${review.reviewDto.rTitle}</a>
					<c:if test="${review.reviewDto.uNo eq _userDto_.uNo}">
						<input type="button" value="삭제" onclick='deleteItemFnc(${review.reviewDto.rNo});'>
					</c:if> </p>
					<p>내용 : <textarea rows="" cols="">${review.reviewDto.rContent}</textarea> </p>
				</form>
			</div>
		</c:forEach>
		
	</div>

</body>
</html>