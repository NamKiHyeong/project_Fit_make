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

<script type="text/javascript">
	function itemFnc() {
		var iNameObj = document.getElementById("iName"); 
		var iSellpriceObj = document.getElementById("iSellprice");
		var iCaloryObj = document.getElementById("iCalory");
		var iCountObj = document.getElementById("iCount");
		var iFileObj = document.getElementById("iFile");
		if(iNameObj.value == ""){
			alert("제품명이 없습니다.");
		} else if(iSellpriceObj.value == ""){
			alert("제품 금액이 없습니다.");
		} else if(iCaloryObj.value == ""){
			alert("제품 칼로리가 없습니다.");
		} else if(iCountObj.value == ""){
			alert("제품의 제고 수량이 없습니다.");
		} else if(iFileObj.files.length == 0){
			alert("이미지가 없습니다.");
		} else {
			$("#itemForm").submit();
		}
			
		
		
	}
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div id="itemOneDiv">
		<div id="itemOneOuterWrap">
			<form id="itemForm" action="./addCtr.do" method="post" enctype="multipart/form-data">
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
									
									<img alt="image not fount" src="<c:url value='/image/${img.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
									<input id="iFile" type="file" id="file_${obj.index}" name="file_${obj.index}"> 
		<!-- 							type="file"가 파일 선택임 -->
									<a href="#this" onclick="deleteFileFnc()">삭제</a><br>
									<a href="#this" id="delete_${img.FM_ITEM_IMG_NO}">삭제</a>
								</div>
							</c:otherwise>
						</c:choose>
						
						<div class="sortImg sort2">
						
						<input type="text" value="${curPage}">
						<input type="text" value="${cNo}">
							<p><span>제품명</span>		<input id="iName" name="iName" class="info" type="text"></p>
							<p><span>가 &nbsp; 격</span>	<input id="iSellprice" name="iSellprice" class="info" type="number"></p>
							<p><span>칼로리</span>	 	<input id="iCalory" name="iCalory" class="info" type="number" name="iCalory"></p>
							<p><span>재 &nbsp; 고</span>	<input id="iCount" name="iCount" class="info" type="number"></p>
							
							<input class="itemCtr" type="button" value="작성" onclick="itemFnc();">
							
							<input  class="itemCtr" type="button" onclick="pageMoveListFnc(${cNo},${curPage});" value="이전페이지로">
							
						</div>
					</div>
					<div class="iteminfo">
						<h3>제품상세정보</h3>
						<textarea style="resize: none;" rows="20" cols="120" name="iOneDetail">이 제품의 장점은~</textarea>
					</div>
				</div>
			</form>
		</div>
	</div>
	
</body>
	
</html>
