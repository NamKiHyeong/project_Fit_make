<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>FitMake</title>
<link rel="stylesheet" href="/fitmake/resources/css/itemOne.css">
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>

</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div id="itemOneDiv">
		<div id="itemOneOuterWrap">
			<form action="./addCtr.do" method="post" enctype="multipart/form-data">
				<input type="hidden" value="${cNo}" name="cNo">
				<div class="diet_wrap">
					<div class="frame">
						<c:choose>
							<c:when test="${empty img.FM_ITEM_IMG_NO}">
								<div class="sortImg sort1">
									<input name="originalName" id="imageId" type="file">
		                  			<a href="#this" id="" onclick="deleteFileFnc();">삭제</a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="sortImg sort1">
	<%-- 								<input type = "hidden" value="${img.FM_ITEM_IMG_NO}"> --%>
	<%-- 								<input type = "hidden" value="${img.FM_ITEM_NO}"> --%>
	<%-- 								<input type = "hidden" value="${img.FM_ITEM_IMG_NAME}"> --%>
									
									<img alt="image not fount" src="<c:url value='/image/${img.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
									<input type="file" id="file_${obj.index}" name="file_${obj.index}"> 
		<!-- 							type="file"가 파일 선택임 -->
									<a href="#this" onclick="deleteFileFnc()">삭제</a><br>
									<a href="#this" id="delete_${img.FM_ITEM_IMG_NO}">삭제</a>
								</div>
							</c:otherwise>
						</c:choose>
	<!-- 					<div class="sortImg sort1"> -->
	<!-- 						파일:<input type="file" name="file"> -->
	<!-- 					</div> -->
						
						<div class="sortImg sort2">
							<p><span>제품명</span>		<input class="info" type="text" name="iName"></p>
							<p><span>가 &nbsp; 격</span>	<input class="info" type="number" name="iSellprice"></p>
							<p><span>칼로리</span>	 	<input class="info" type="number" name="iCalory"></p>
							<p><span>재 &nbsp; 고</span>	<input class="info" type="number" name="iCount"></p>
							
							<input  class="itemCtr" type="submit" value="작성">
							<input  class="itemCtr" type="button" onclick="pageMoveListFnc(${cNo});" value="이전페이지로">
							
						</div>
					</div>
					<div class="iteminfo">
						<h3>제품상세정보</h3>
						<textarea rows="20" cols="120" name="iOneDetail">이 제품의 장점은~</textarea>
					</div>
				</div>
			</form>
		</div>
	</div>
	
</body>
	
</html>
