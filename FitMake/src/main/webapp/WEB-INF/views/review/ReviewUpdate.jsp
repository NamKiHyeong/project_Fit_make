<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정하기</title>

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


function pageReviewFnc(rNo){
location.href="../review/add.do?rNo=" + rNo;

}
function pageReviewListFnc(iNo){
location.href="../review/list.do?iNo=" + iNo;
}
//-----------------------------------------------------

function deleteFileFnc(obj){
//	      위 -> 아래 
//	      아래 -> 위
	   obj.parent().remove();
}

function deleteFileFnc() {
var obj = $('#fileContent');

var htmlStr = "";

htmlStr += '사진 <input name="originalName" id="imageId" type="file">';
htmlStr += '<a href="#this" id="" onclick="deleteFileFnc();">삭제</a>';

obj.html(htmlStr);

$('a[id^="delete"]').on('click', function(e) {
  e.preventDefault();
  deleteFileFnc($(this));
});      

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
	
	
	
	<form action ="./updateCtr.do" method = "post" enctype="multipart/form-data">
	
	<input type="hidden" name="iNo" value="${reviewDto.iNo}">
	<input type="hidden" name="rNo" value="${reviewDto.rNo}">
	<input type="hidden" name="uNo" value="${reviewDto.uNo}">
	
		<c:choose>
			<c:when test="${empty img.FM_REVIEW_IMG_NO}">
			<input name="originalName" id="imageId" type="file">
				<a href="#this" id="" onclick="deleteFileFnc();">삭제</a>
			</c:when>
			<c:otherwise>
			<input type = "hidden" value="${img.FM_REVIEW_IMG_NO}">
			<input type = "hidden" value="${img.FM_REVIEW_NO}">
			<input type = "hidden" value="${img.FM_REVIEW_IMG_NAME}">
			
			<img alt="image not fount" src="<c:url value='/image/${img.FM_REVIEW_STORED_NAME}'/>"/><br>
			<input type="file" id="file_${obj.index}" name="file_${obj.index}"> 
			<!-- 							type="file"가 파일 선택임 -->
			<a href="#this" onclick="deleteFileFnc()">삭제</a><br>
			<a href="#this" id="delete_${img.FM_ITEM_IMG_NO}">삭제</a>
			</c:otherwise>
		</c:choose>
		
		제목 <input type="text" name="rTitle" value="${reviewDto.rTitle}">
		내용 <textarea rows="" cols="" name="rContent"> ${reviewDto.rContent} </textarea>
		
		<input class="" type="submit" value="수정완료">
		<input class="itemCtr" type="button" value="뒤로가기" onclick="pageMoveBefore(${prevMap.iNo}, ${reviewDto.rNo});">
					
		<input class="itemCtr" type="button" value="회원목록으로 이동" onclick="pageMoveListFnc(${reviewDto.iNo});">
		<input class="itemCtr" type="button" value="삭제" onclick='deleteReviewFnc(${reviewDto.rNo}, ${prevMap.iNo});'><br>
	</form>
</body>
</html>