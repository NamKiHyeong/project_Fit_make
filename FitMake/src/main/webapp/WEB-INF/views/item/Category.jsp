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
		<c:when test="${itemList[0] eq null}">
			<h4><a href="./add.do">제품을 추가</a></h4>
		</c:when>
		
		<c:otherwise>
			<c:forEach var="itemDto" items="${itemList}" >
				<c:if test="${itemDto.cNo == 2}">
					<div>
						<form id="itemOneForm" action="./one.do" method="get">
							<a href="#" onclick="itemOneFnc();">
								${itemDto.iName}
							</a>
							<input type="hidden" name="no" value="${itemDto.iNo}">
						</form>					
						가격 : ${itemDto.iSellprice}
						리뷰 : 아직 없음
						<form id="itemDetailForm" method="get">
						</form>
					</div>
				</c:if>
			</c:forEach>
			
		</c:otherwise>
		
	</c:choose>
</body>
</html>