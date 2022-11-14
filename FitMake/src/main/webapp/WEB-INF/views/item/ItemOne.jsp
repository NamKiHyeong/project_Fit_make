<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세정보</title>
</head>
<body>
	$("#oneDetail").val("test");
	@@ one 컨트롤러까지 하고 텍스트에어리어 하기
	<form action='.update.do' method="get">
		<input tyep='hidden' name='iNo'	value='itemDto.iNo'>
		제품명 : <input type='text' name='iName' value='itemDto.iName'>
		가격 : <input type='number' name='iSellprice' value='itemDto.iSellprice'>
		제고 : <input type='number' name='iCount' value='itemDto.iCount'>
		제품상세정보 : $("#oneDetail").val();
	</form>
</body>
</html>