<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 수정 하는 곳</title>
<script type="text/javascript">
	function pageMoveListFnc() {
		location.href="./list.do";
	}
	
	function deleteOneFnc(iNo){
		var url = "./deleteOne.do?iNo=" + iNo;
		location.href = url;
	}
</script>
</head>
<body>
	<jsp:include page="../Header.jsp" />
	<div>
<!-- 	enctype="multipart/form-data" -->
		<form action ="./updateCtr.do" method = "post">
		<input type="hidden" name="iNo" value="${itemDto.iNo}">
			제품명 : <input type="text" name="iName" id="itemName" value = "${itemDto.iName}"><br>
			가격 : <input type="text" name="iSellprice" value = "${itemDto.iSellprice}"><br>
			재고 : <input type="text" name="iCount" value = "${itemDto.iCount}"><br>
			제품상세정보 : 
			<input type="submit" value="수정완료">
			<input type="button" value="회원목록으로 이동" onclick="pageMoveListFnc();">
			<input type="button" value="삭제" onclick='deleteOneFnc(${itemDto.iNo});'>
		</form>
		
	</div>
	
</body>
	
</html>