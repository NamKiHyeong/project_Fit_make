<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>특가 더미 사이트(Item list 사이트)</title>
<style type="text/css">
	@media(max-width:1200px){
		.CategoryItem3{
			display:inline-grid;
			width:1fr 1fr 1fr;
			margin: 20px;
	  		padding: 10px;
			color:blue;
		}
	}
	
	
/* 	미디어를 이용해서 최대 3개 최소 2개로 수정하기 */

</style>

<script type="text/javascript">
	function itemOneFnc(){
		var itemOneFormObj = document.getElementById("itemOneForm");
		itemOneFormObj.submit();
	}
	function itemOneAsc(){
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
			<a href="#" onclick="itemOneAsc();">가격순</a><br>
			<a href="#" onclick="itemOneAsc();">리뷰순</a><br>
			<c:forEach var="item" items = "${itemList}">
				<div class="CategoryItem3">
					<form id="itemOneForm" action="./one.do" method="get">
						<input type="checkbox">
						
						<input type="hidden" name="iNo" value="${item.itemDto.iNo}">
						<input type="hidden" name="cNo" value="${item.itemDto.cNo}">
<%-- 						${item.fileMap.FM_ITEM_IMG_NAME} --%>
						<br>
						<img alt="image not found" src="<c:url value='/image/${item.fileMap.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
	<%-- 					(${row.FILE_SIZE}kb) --%>
						
						<a href="#" onclick="itemOneFnc();">
							${item.itemDto.iName}
						</a><br>
						가격 : ${item.itemDto.iSellprice}<br>
						리뷰 : ${item.tiemDto.iCount}<br>
						
						<input type="hidden" name="curPage" value="${pagingMap.itemPaging.curPage}">
					</form>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
	<jsp:include page="./ItemPaging.jsp"/>	
	
	<form action="./list.do" id="pagingForm" method="post">
		<input type="hidden" id="curPage" name="curPage" value="${pagingMap.itemPaging.curPage}">
		<input type="hidden" name="cNo" value="${itemList.get(0).itemDto.cNo}">
<%-- 		<input type="hidden" name="keyword" value="${searchmap.keyword}"> --%>
<%-- 		<input type="hidden" name="searchoption" value="${searchmap.searchoption}"> --%>
	</form>
</body>
</html>

