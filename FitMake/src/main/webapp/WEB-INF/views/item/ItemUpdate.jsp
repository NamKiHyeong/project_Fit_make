<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정 하는 곳</title>

<link rel="stylesheet" href="/fitmake/resources/css/itemupdate.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div class="diet_wrap">
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
			<div>
				제품명 : <input type="text" name="iName" id="itemName" value = "${itemDto.iName}"><br>
				가격 : <input type="text" name="iSellprice" value = "${itemDto.iSellprice}"><br>
				재고 : <input type="text" name="iCount" value = "${itemDto.iCount}"><br>
				
				<input type="submit" value="수정완료">
				<input type="button" value="뒤로가기" onclick="pageMoveBefore(${itemDto.iNo});">
				<input type="button" value="회원목록으로 이동" onclick="pageMoveListFnc(${itemDto.cNo});">
				<input type="button" value="삭제" onclick='deleteItemFnc(${itemDto.iNo});'><br>
			</div>
			
			제품상세정보 <br>
			<textarea rows="30" cols="20" >${itemDto.iOneDetail}</textarea>
		</form>
	</div>
	
</body>
	
</html>