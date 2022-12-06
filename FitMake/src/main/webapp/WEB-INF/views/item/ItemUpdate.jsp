<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>
<link rel="stylesheet" href="/fitmake/resources/css/itemUpdate.css">
<script type="text/javascript" src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>

<script type="text/javascript">
// 	window.onload = function() {
// 		var itemFormSubmitBtnObj = document.getElementById('itemFormSubmitBtn');
// 		itemFormSubmitBtnObj.addEventListener('click', function(e) {
// 			e.preventDefault();
// 			alert(this.id);
// 			var iOneDetailObj = document.getElementById('iOneDetail');
// 			alert(iOneDetailObj.value.indexOf('&nbsp;'));
// 			alert($.trim(iOneDetailObj.value));
// 			iOneDetailObj.value = $.trim(iOneDetailObj.value);
// 			document.getElementById('itemFormObj').submit();
// 		});
// 		var iOneDetailObj = document.getElementById('iOneDetailObj');
// 		var tempIOneDetail = document.getElementById('tempIOneDetail');
// 		iOneDetailObj.value = tempIOneDetail.value;
// 	}

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
	

	function deleteFileFnc(){
		
	   var obj = $('#imgInfo2');
	   
	   var htmlStr = "";
	   htmlStr += '<div style="height: 400px;"></div>';
	   htmlStr += '사진 <input type="file" id="file" onchange="" name="file">';
	   htmlstr += '<a href="#" onclick="deleteFileFnc();">삭제</a>';
	   
	   obj.html(htmlStr);

	}
	function imgEmptyCheckFnc(){
		var itemImgObj = document.getElementById("itemImgNo"); 
		
		if(itemImgObj == null){
			alert("사진이 없습니다.");
		} else{
			var itemUpdateCtrFormObj = document.getElementById("itemFormObj");
			itemUpdateCtrFormObj.submit();
		} 
		
		
	}
</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div id="itemUpdateDiv">
		<div id="itemUpdateOuterWrap">
			<form id='itemFormObj' action ="./updateCtr.do" method = "post" enctype="multipart/form-data">
		
				<input type="hidden" name="iNo"	value="${itemDto.iNo}"><br>
				<input type="hidden" name="cNo"	value="${itemDto.cNo}"><br>
				<input type="hidden" name="curPage" value="${prevMap.curPage}">
					
				<div class="diet_wrap">	
					<div class="frame">
						<div id="imgInfo" class="sortImg sort1">
							<input id="itemImgNo" type = "hidden" name="imgNo" value="${img.FM_ITEM_IMG_NO}">
		<!-- 					<div id="imgInfo2"> -->
							<img id="itemImg" alt="image not fount" src="<c:url value='/image/${img.FM_ITEM_STORED_IMG_NAME}'/>"/><br>
		<!-- 					</div> -->
							<input type="file" id="file" name="file">
							<a href="#" onclick="deleteFileFnc();">삭제</a>
						</div>
						
						<div class="sortImg sort2">
							<p><span>제품명</span>		<input class="info" type="text" name="iName" id="iName" value="${itemDto.iName}"></p>
							<p><span>가 &nbsp; 격</span>	<input class="info" type="number" name="iSellprice" value="${itemDto.iSellprice}"></p>
							<p><span>칼로리</span>	 	<input class="info" type="number" name="iCalory" value="${itemDto.iCalory}"></p>
							<p><span>재 &nbsp; 고</span>	<input class="info" type="number" name="iCount" id="iCount" value="${itemDto.iCount}" ></p>
							
							<input id='itemFormSubmitBtn' class="itemCtr" type="button" onclick="imgEmptyCheckFnc()" value="수정완료">
							
							<input class="itemCtr" type="button" value="뒤로가기" onclick="pageMoveBefore(${prevMap.curPage}, ${prevMap.cNo}, ${itemDto.iNo});">
							
							<input class="itemCtr" type="button" value="회원목록으로 이동" onclick="pageMoveListFnc(${itemDto.cNo});">
							<input class="itemCtr" type="button" value="삭제" onclick='deleteItemFnc(${itemDto.iNo}, ${prevMap.cNo});'><br>
						</div>
						<div class="iteminfo">
							<h3>제품상세정보</h3>
							<textarea rows="20" cols="120" id='iOneDetail' name="iOneDetail">${itemDto.iOneDetail}</textarea>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
	
</html>