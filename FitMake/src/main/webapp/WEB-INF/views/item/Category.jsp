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
<%-- 	<jsp:include page="../Header.jsp"/> --%>
	
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
					${item.fileMap.FM_ITEM_IMG_NAME} <br>
					<img alt="image not found" src="<c:url value='/image/${item.fileMap.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
				</form>
			</div>
			<a href="#" onclick="itemOneFnc();">
				${item.itemDto.iName}
			</a>
			<input type="hidden" name="no" value="${item.itemDto.iNo}">
			가격 : ${item.itemDto.iSellprice}<br>
			리뷰 : 아직 없음<br>
			</c:forEach>
			
			
						
			<form id="itemDetailForm" method="get">
			</form>
		</c:otherwise>
	</c:choose>
		
</body>
</html>

