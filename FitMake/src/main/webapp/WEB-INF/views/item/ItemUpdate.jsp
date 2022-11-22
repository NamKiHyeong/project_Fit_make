<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정 하는 곳</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("a[id^='delete']").on('click', function(e){ // 삭제 버튼
			e.preventDefault();
			deleteFileFnc($(this));
		});
	});
	function pageMoveListFnc() {
		location.href="./list.do";
	}
	
	function deleteOneFnc(iNo){
		var url = "./deleteOne.do?iNo=" + iNo;
		location.href = url;
	}
	function pageMoveBefore(iNo){
		var url =".selectOne.do?iNo=" + iNo;
		
	}
	function fileImgDeleteFnc(){
		var obj = $('#fileContent');
		var htmlStr = "";
		
		htmlStr += '<div>';
		htmlStr += '<input type="hidden" id="fileIdx" name="fileIdx"';
		htmlStr += ' value="">';
		htmlStr += '<input type="file" id="file0" name="file0">';
		htmlStr += '<a href="#this" id="delete0">삭제</a><br>';
		htmlStr += '</div>';
		
		obj.html=(htmlStr);
		
		$( 'a[id^="delete"]').on('click', function(3){
			e.preventDefault();
			deleteFileFnc($(this));
		}
	}
</script>
</head>
<body>
	<jsp:include page="../Header.jsp" />
	<div>
<!-- 	enctype="multipart/form-data" -->
		<form action ="./updateCtr.do" method = "post" enctype="multipart/form-data">
		<input type="hidden" name="iNo" value="${itemDto.iNo}">
		
			<c:choose>
				<c:when test="${empty fileList}">
				
					<input type="hidden" id="fileIndx" name="fileIdx" value ="">
					<input type="file" id="file0" name="file0">
					<a href="#this" id="delete0" onlick="fileImgDeleteFnc();">삭제</a><br>
				</c:when>
			</c:choose>
			
			
			<c:otherwise>
				<c:forEach var="item" items="${fileList}" varStatus="obj">
				<input type = "hidden" id = "fileIdx_${obj.index}" name="fileIdx" value="${item.FM_ITEM_IMG_NO}">
				<img alt="image not fount" src="<c:url value='/image/${item.fileMap.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
				<input type="file" id="file_${obj.index}" name="file+${obj.index}">
<%-- 				(${row.FILE_SIZE}kb) --%>
				<a href="#this" id="delete_${obj.index}">삭제</a><br>
				</c:forEach>
				
			</c:otherwise>
			제품명 : <input type="text" name="iName" id="itemName" value = "${itemDto.iName}"><br>
			가격 : <input type="text" name="iSellprice" value = "${itemDto.iSellprice}"><br>
			재고 : <input type="text" name="iCount" value = "${itemDto.iCount}"><br>
			제품상세정보 : 
			<input type="submit" value="수정완료">
			<input type="button" value="뒤로가기" onclick="pageMoveBefore();">
			<input type="button" value="회원목록으로 이동" onclick="pageMoveListFnc();">
			<input type="button" value="삭제" onclick='deleteOneFnc(${itemDto.iNo});'>
			
		</form>
		
	</div>
	
</body>
	
</html>