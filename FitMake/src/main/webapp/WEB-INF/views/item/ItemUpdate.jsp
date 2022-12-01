<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정 하는 곳</title>
<link rel="stylesheet" href="/fitmake/resources/css/itemOne.css">
<script type="text/javascript" src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>

<script type="text/javascript">
	function pageMoveBefore(curPage, cNo, iNo){
		var url ="./one.do?curPage=" + curPage + "&cNo=" + cNo + "&iNo=" + iNo;
		location.href = url;
	}
	function deleteItemFnc(iNo, cNo){
    	var deletecheck = confirm("제품을 삭제하시겠습니까?");
      
    	if(deletecheck == true){
    		location.href = "./deleteOne.do?iNo=" + iNo+ '&cNo=' + cNo;
		} else {
			return false;
		}
   }
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	
		<form action ="./updateCtr.do" method = "post" enctype="multipart/form-data">

		<input type="hidden" name="iNo"	value="${itemDto.iNo}"><br>
		<input type="hidden" name="cNo"	value="${itemDto.cNo}"><br>
		<input type="hidden" name="curPage" value="${prevMap.curPage}">
			
		<div class="diet_wrap">	
			<div class="frame">
				<div class="sortImg sort1">
					<c:choose>
						<c:when test="${empty img.FM_ITEM_IMG_NO}">
							<input type="file" id="file" name="file">
		<!-- 					<a href="#this" id="delete" onclick="fileUpdateFnc();">삭제</a><br> -->
						</c:when>
					
						<c:otherwise>
							<input type = "hidden" id="fileIdx" name="fileIdx" value="${img.FM_ITEM_IMG_NO}">
							<img alt="image not fount" src="<c:url value='/image/${img.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
							<a href="javascript:void(0);" onclick="deleteFileFnc(this);">삭제</a><br>
							<input type="file" id="file" name="file">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="sortImg sort2">
					<p><span>제품명</span>		<input class="info" type="text" name="iName" id="iName" value="${itemDto.iName}"></p>
					<p><span>가 &nbsp; 격</span>	<input class="info" type="number" name="iSellprice" value="${itemDto.iSellprice}"></p>
					<p><span>재 &nbsp; 고</span>	<input class="info" type="number" name="iCount" id="iCount" value="${itemDto.iCount}" ></p>
					<p><span>칼로리</span>	 	<input class="info" type="number" name="iCalory" value="${itemDto.iCalory}"></p>
					
					<input class="itemCtr" type="submit" value="수정완료">
					
					<input class="itemCtr" type="button" value="뒤로가기" onclick="pageMoveBefore(${prevMap.curPage}, ${prevMap.cNo}, ${itemDto.iNo});">
					
					<input class="itemCtr" type="button" value="회원목록으로 이동" onclick="pageMoveListFnc(${itemDto.cNo});">
					<input class="itemCtr" type="button" value="삭제" onclick='deleteItemFnc(${itemDto.iNo}, ${prevMap.cNo});'><br>
					<div class="iteminfo">
						<h3>제품상세정보</h3>
						<textarea rows="20" cols="120" name="iOneDetail">
							${itemDto.iOneDetail}
						</textarea>
					</div>
				</div>
			</div>
			
		</div>
	</form>
</body>
	
</html>