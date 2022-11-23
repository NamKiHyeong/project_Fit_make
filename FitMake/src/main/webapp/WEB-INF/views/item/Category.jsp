<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>특가 더미 사이트(Item list 사이트)</title>
<script type="text/javascript">
	function itemOneFnc(){
		var itemOneFormObj = document.getElementById("itemOneForm");
		
		itemOneFormObj.submit();
	}
	
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	
	<h3>다이어트</h3>
	<h4><a href="./add.do">제품을 추가</a></h4>
	<c:choose>
		<c:when test="${empty itemList}">
			<h4><a href="./add.do">제품을 등록해주세요</a></h4>
		</c:when>
		<c:otherwise>
		
			<c:forEach var="item" items = "${itemList}">
			<div>
				<form id="itemOneForm" action="./one.do" method="get">
					<input type="checkbox">
					<input type="hidden" name="iNo" value="${item.itemDto.iNo}">
					
					${item.fileMap.FM_ITEM_IMG_NAME} <br>
					<img alt="image not found" src="<c:url value='/image/${item.fileMap.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
<%-- 					(${row.FILE_SIZE}kb) --%>
					
					<a href="#" onclick="itemOneFnc();">
						${item.itemDto.iName}
					</a><br>
					가격 : ${item.itemDto.iSellprice}<br>
					리뷰 : 아직 없음<br>
				</form>
			</div>
			
			
			</c:forEach>
			
			
						
			<form id="itemDetailForm" method="get">
			</form>
		</c:otherwise>
	</c:choose>
	
	<jsp:include page="./Paging.jsp"/>	
	
	<form id="pagingForm">
		<input type="hidden" id="curPage" name="curPage" >
<%-- 		value="${pagingMap.itemPaging.curPage}"> --%>
<%-- 		<input type="hidden" name="keyword" value="${searchmap.keyword}"> --%>
<!-- 		<input type="hidden" name="searchoption"  -->
<%-- 			value="${searchmap.searchoption}"> --%>
	</form>
</body>
</html>

