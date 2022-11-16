<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세정보</title>
</head>
<body>
	
	
	<form action="./update.do" method="get">
		<input type="hidden" name="iNo"	value="${itemDto.iNo}"><br>
		제품명 : <input type="text" name="iName" id="iName" value="${itemDto.iName}"><br>
		가격 : <input type="number" name="iSellprice" value="${itemDto.iSellprice}"><br>
		제고 : <input type="number" name="iCount" value="${itemDto.iCount}"><br>
		제품상세정보 : $("#oneDetail");
<!-- 		제품상세정보에 텍스트에어리어 나오게 하는 법 찾기 -->

		<input type="submit" value="수정하기">
	</form>
</body>
</html>