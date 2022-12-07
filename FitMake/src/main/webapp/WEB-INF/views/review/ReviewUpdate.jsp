<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<link rel="stylesheet" href="/fitmake/resources/css/reviewUpdate.css">
<script type="text/javascript" src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>
<script type="text/javascript">

//------------------------------------
$(document).ready(function() {
	
$("a[id^='delete']").on('click', function(e){ // 삭제 버튼
	e.preventDefault();
	deleteFileFnc($(this));
});


});

function reviewOneFnc(rNo){
//pagingForm에 curPage
var idStr = 'reviewOneForm' + rNo;
var itemOneFormObj = document.getElementById(idStr);

itemOneFormObj.submit();

}
function reviewOneAsc(){
var reviewOneFormObj = document.getElementById("pagingForm");
reviewOneFormObj.submit();
}

//----------------------------------------------------------------
//리스트로 이동
function pageMoveListFnc(iNo) {
location.href="../review/list.do?iNo=" + iNo;
}




//------------------------------------------------------------------

function pageMoveBefore(curPage, iNo, rNo){
		var url ="./one.do?curPage=" + curPage + "&iNo=" + iNo + "&rNo=" + rNo;
		location.href = url;
	}
function pageReviewFnc(rNo){
location.href="../review/add.do?rNo=" + rNo;

}
function pageReviewListFnc(iNo){
location.href="../review/list.do?iNo=" + iNo;
}
//-----------------------------------------------------

// function deleteFileFnc(obj){
// //	      위 -> 아래 
// //	      아래 -> 위
// 	   obj.parent().remove();
// }

// function deleteFileFnc() {
// var obj = $('#fileContent');

// var htmlStr = "";

// htmlStr += '사진 <input name="originalName" id="imageId" type="file">';
// htmlStr += '<a href="#this" id="" onclick="deleteFileFnc();">삭제</a>';

// obj.html(htmlStr);

// $('a[id^="delete"]').on('click', function(e) {
//   e.preventDefault();
//   deleteFileFnc($(this));
// });      

// }

function deleteFileFnc(){
		
   var obj = $('#imgInfo');
   
   var htmlStr = "";
   htmlStr += '<div style="width:400px;margin-left:50px;height:530px;"></div>';
   htmlStr += '사진 <input type="file" id="file" name="file">';
   htmlStr += '<a href="#" onclick="deleteFileFnc();">삭제</a>';
   
   obj.html(htmlStr);

}
function deleteReviewFnc(rNo, iNo){
	var deletecheck = confirm("리뷰를 삭제하시겠습니까?");
  
	if(deletecheck == true){
		location.href = "./deleteOne.do?rNo=" + rNo+ '&iNo=' + iNo;
	} else {
		return false;
	}
}
//-------------------------------------------------------------
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div style="height: 50px;"></div>
	<div id="reviewUpdateDiv">
		<div id="reviewUpdateInnerDiv">
			<form action ="./updateCtr.do" method = "post" enctype="multipart/form-data">
				<input type="hidden" name="iNo" value="${reviewDto.iNo}">
				<input type="hidden" name="rNo" value="${reviewDto.rNo}">
				<input type="hidden" name="uNo" value="${reviewDto.uNo}">
				<input type="hidden" name="curPage" value="${prevMap.curPage}">
				<div class="diet_wrap">
					<div class="frame">
						<div id="imgInfo" class="sortImg sort1">
			<%-- 				<c:choose> --%>
			<%-- 					<c:when test="${empty img.FM_REVIEW_IMG_NO}"> --%>
			<!-- 					<input name="originalName" id="imageId" type="file"> -->
			<!-- 						<a href="#this" id="" onclick="deleteFileFnc();">삭제</a> -->
			<%-- 					</c:when> --%>
			<%-- 					<c:otherwise> --%>
			<%-- 						<input type = "hidden" value="${img.FM_REVIEW_IMG_NO}"> --%>
			<%-- 						<input type = "hidden" value="${img.FM_REVIEW_NO}"> --%>
			<%-- 						<input type = "hidden" value="${img.FM_REVIEW_IMG_NAME}"> --%>
								
			<%-- 						<img alt="image not fount" src="<c:url value='/image/${img.FM_REVIEW_STORED_NAME}'/>"/><br> --%>
			<%-- 						<input type="file" id="file_${obj.index}" name="file_${obj.index}">  --%>
			<!-- 													type="file"가 파일 선택임 -->
			<!-- 						<a href="#this" onclick="deleteFileFnc()">삭제</a><br> -->
			<%-- 						<a href="#this" id="delete_${img.FM_REVIEW_IMG_NO}">삭제</a> --%>
			<%-- 					</c:otherwise> --%>
			<%-- 				</c:choose> --%>
							<input type = "hidden" name="imgNo" value="${fileList2}">
								
							<c:forEach var="review" items="${fileList2}">
								<img alt="image not found" src="<c:url value='/image/${review.FM_REVIEW_STORED_NAME}'/>"/><br>
							</c:forEach>
							<input type="file" id="file" name="file">
							<a href="#" onclick="deleteFileFnc();">삭제</a>
						</div>
						<div class="sortImg sort2">
							<h3>제목</h3>
							<input type="text" class="reviewTitle" name="rTitle" value="${reviewDto.rTitle}"><br>
<!-- 							<p style="padding:20px 0 10px;font-size:18px;font-weight:bold;">내용</p> -->
							<h3>내용</h3>
							<textarea class="reviewInfo" rows="20" cols="80" name="rContent">${reviewDto.rContent}</textarea>
							<div id="reviewUpdateBtnArea">
								<input class="itemCtr" type="submit" value="수정완료">
								
								<input class="itemCtr" type="button" value="뒤로가기" onclick="pageMoveBefore(${prevMap.curPage},${reviewDto.iNo}, ${reviewDto.rNo});">
											
								<input class="itemCtr" type="button" value="회원목록으로 이동" onclick="pageMoveListFnc(${reviewDto.iNo});">
								<input class="itemCtr" type="button" value="삭제" onclick='deleteReviewFnc(${reviewDto.rNo}, ${prevMap.iNo});'>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>