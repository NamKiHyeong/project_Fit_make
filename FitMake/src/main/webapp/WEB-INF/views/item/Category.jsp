<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/fitmake/resources/css/diet.css">
<title>특가 더미 사이트(Item list 사이트)</title>
<style type="text/css">
 	
/*
	frame에 margin이 max에는 없고 min에는 있는 margin 때문에
	1450~1550 부분에 에러가 생김
	css 할 때 마무리 하기
*/
/*	#frame{
		display:grid;
		grid-template-columns:1fr 1fr 1fr;
		margin-left: 50px;
		margin-top: 30px;
	}
	
/* 	.CategoryItem{ */
/* 		width:400px; */
/* 		height:300px; */
/* 		margin: 20px; */
/*   		padding: 10px; */
/* 		color:blue; */
/* 	} */
	
/*	li{
		display: inline;
		padding: 20px;
	}
	#frame p{
		margin-left: 20px;
  		padding-left: 10px;
		text-align: left;
	}
	.sortOrder{
		float: right;
    	display: inline-block;
	}
	.itemBoundary{
		border-top:1px solid; 
		border-bottom:1px solid; 
		padding-top: 5px;
	}
	p{
		margin: 2px;
		margin-left: 1px;
	}
/* 	미디어를 이용해서 최대 3개 최소 2개로 수정하기 */

</style>

<script type="text/javascript">




	function itemOneFnc(no){
		//pagingForm에 curPage
		
		var idStr = 'itemOneForm' + no
		var itemOneFormObj = document.getElementById(idStr);
		
		itemOneFormObj.submit();
		
	}
	function itemOneAsc(){
		var itemOneFormObj = document.getElementById("pagingForm");
		itemOneFormObj.submit();
	}
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div class="diet_wrap">
		<h3>다이어트</h3>
		<h4><a href="./add.do">제품을 추가</a></h4>
		<c:choose>
			<c:when test="${empty itemList}">
				<h4><a href="./add.do">제품을 등록해주세요</a></h4>
			</c:when>
			
			<c:otherwise>
				<div class="sortOrder">
					<ul class="sortOrderbox">
						<li><a href="./list.do?cNo=${pagingMap.cNo}&older=1" class="sortOrdervv" onclick="itemOneAsc();">낮은 가격순</a></li>
						<li><a href="./list.do?cNo=${pagingMap.cNo}&older=2" class="sortOrdervv" onclick="itemOneAsc();">높은 리뷰순</a></li>
					</ul>
				</div>
				
	<!-- 			@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
				<div id="frame">
					<c:forEach var="item" items = "${itemList}">
						<div class="CategoryItem">
							<form id="itemOneForm${item.itemDto.iNo}" action="./one.do" method="get">
	<!-- 							<input type="checkbox"> -->
								<input type="hidden" name="iNo" value="${item.itemDto.iNo}">
								<input type="hidden" name="cNo" value="${item.itemDto.cNo}">
								<input type="hidden" name="curPage" value="${pagingMap.itemPaging.curPage}">
								<input type="hidden" name="keyword" value="${searchMap.keyword}">
								<div class="sortImg"><img alt="image not found" src="<c:url value='/image/${item.fileMap.FM_ITEM_STORED_IMG_NAME}'/>"/><br></div>
								
			<%-- 					(${row.FILE_SIZE}kb) --%>
								
								<p><a href="#" onclick="itemOneFnc(${item.itemDto.iNo});">${item.itemDto.iName}</a></p>
								<p class="itemBoundary">가격 : ${item.itemDto.iSellprice}</p>
								<p>리뷰 : ${item.itemDto.iCount}</p>
								
							</form>
						</div>
					</c:forEach>
				</div>
			</div>
<!-- 			@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
		</c:otherwise>
		
	</c:choose>
	
	<form action="./list.do">
		<input type="hidden" name="cNo" value="${pagingMap.cNo}">
		<input type="text" name="keyword" value="${searchMap.keyword}">
		<input type="submit" value="검색">
<!-- 		src="/fitmake/resources/image/keyword.png" alt="제출버튼" -->
	</form>
	
	<jsp:include page="./ItemPaging.jsp"/>	
	
	<form action="./list.do" id="pagingForm" method="post">
		<input type="hidden" id="curPage" name="curPage" value="${pagingMap.itemPaging.curPage}">
		<input type="hidden" name="cNo" value="${pagingMap.cNo}">
		<input type="hidden" name="keyword" value="${searchmap.keyword}">
	</form>
</body>
</html>

