<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정 하는 곳</title>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

// 	$(document).ready(function(){
// 		$("a[id^='delete']").on('click', function(e){ // 삭제 버튼
// 			e.preventDefault();
// 			deleteFileFnc($(this));
// 		});
// 	});
	
	function pageMoveListFnc(cNo) {
		location.href="../item/list.do?cNo=" +cNo;
	}
	
	function deleteFileFnc(obj){
// 		alert(obj);
		
		$(obj).parent().remove();
	}
	
	function pageMoveBefore(iNo){
		
		var url ="./one.do?no=" + iNo;
		location.href = url;
		
	}
	
	function itemDeleteOneFnc(iNo, cNo){
		var url = "./deleteOne.do?iNo=" + iNo + '&cNo=' + cNo;
		location.href = url;
	}
	
	function fileUpdateFnc(){
		var obj = $('#fileContent');
		var htmlStr = "";
		
		htmlStr += '<div>';
		htmlStr += '<input type="hidden" id="fileIdx" name="fileIdx"';
		htmlStr += ' value="">';
		htmlStr += '<input type="file" id="file0" name="file0">';
		htmlStr += '<a href="#this" id="delete0">삭제</a><br>';
		htmlStr += '</div>';
		
		obj.html=(htmlStr);
		
		$('a[id^="delete"]').on('click', function(e){
			e.preventDefault();
			deleteFileFnc($(this));
		});
	}
	function deleteItemFnc(iNo){
	      var deletecheck = confirm("제품을 삭제하시겠습니까?");
	      
	      if(deletecheck == true){
	         location.href = "./deleteOne.do?iNo=" + iNo + '&cNo=' + cNo;
	      } else {
	         return false;
	      }
	   }
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<jsp:include page="/WEB-INF/views/cart/CartSummary.jsp" />
	<div>
		<form action ="./updateCtr.do" method = "post" enctype="multipart/form-data">
		<input type="hidden" name="iNo"	value="${itemDto.iNo}"><br>
		<input type="hidden" name="cNo"	value="${itemDto.cNo}"><br>
		<input type="hidden" name="curPage" value="${prevMap.curPage}">
			<c:choose>
				<c:when test="${empty img.FM_ITEM_IMG_NO}">
					<input type="file" id="file" name="file">
<!-- 					<a href="#this" id="delete" onclick="fileUpdateFnc();">삭제</a><br> -->
				</c:when>
			
			
			
				<c:otherwise>
<%-- 					<c:forEach var="item" items="${fileList}" varStatus="obj"> --%>
<!-- 					<div> -->
<%-- 						<input type = "hidden" id = "fileIdx_${obj.index}" name="fileIdx" value="${item.FM_ITEM_IMG_NO}"> --%>
<%-- 						<img alt="image not fount" src="<c:url value='/image/${item.FM_ITEM_STORED_IMG_NAME}'/>"/><br> --%>
<%-- 						<input type="file" id="file_${obj.index}" name="file_${obj.index}" > --%>
<%-- 		 				(${row.FILE_SIZE}kb) --%>
<%-- 						<a href="#this" id="delete_${obj.index}">삭제</a><br> --%>
<!-- 					</div> -->
<%-- 					</c:forEach> --%>
				
				<div>
					<input type = "hidden" id="fileIdx" name="fileIdx" value="${img.FM_ITEM_IMG_NO}">
					<img alt="image not fount" src="<c:url value='/image/${img.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
					<a href="javascript:void(0);" onclick="deleteFileFnc(this);">삭제</a><br>
				</div>
					<input type="file" id="file" name="file">
				
				</c:otherwise>
			</c:choose>	
				
			제품명 : <input type="text" name="iName" id="itemName" value = "${itemDto.iName}"><br>
			가격 : <input type="text" name="iSellprice" value = "${itemDto.iSellprice}"><br>
			재고 : <input type="text" name="iCount" value = "${itemDto.iCount}"><br>
			제품상세정보 : 
			<input type="submit" value="수정완료">
			<input type="button" value="뒤로가기" onclick="pageMoveBefore(${itemDto.iNo});">
			<input type="button" value="회원목록으로 이동" onclick="pageMoveListFnc(${itemDto.cNo});">
			<input type="button" value="삭제" onclick='deleteItemFnc(${itemDto.iNo},${itemDto.cNo});'>
			<textarea rows="" cols="" >${itemDto.iOneDetail}</textarea>
		</form>
		
	</div>
	
</body>
	
</html>