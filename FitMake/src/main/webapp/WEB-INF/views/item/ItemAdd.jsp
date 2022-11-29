<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>아이템을 추가해줘</title>
<script type="text/javascript" src="/fitmake/resources/js/item.js"></script>

</head>
<body>
	<jsp:include page="../Header.jsp"/>
	<div>
		<form action="./addCtr.do" method="post" enctype="multipart/form-data">
			<input type="hidden" value="${cNo}" name="cNo">
			<div>
				파일:<input type="file" name="file">
			</div>
			<div>
				<p>제품명 : <input type="text" name="iName"></p>
				<p>가격 : <input type="number" name="iSellprice"></p>
				<p>칼로리 : <input type="number" name="iCalory"></p>
				<p>재고 : <input type="number" name="iCount"></p>
				<p>제품상세정보</p>
<!-- 				<input type="text" name="iOneDetail"> -->
				<textarea name="iOneDetail">
					이 제품의 장점은~
				</textarea>
				
				<input type="submit" value="작성">
				<input type="button" onclick="pageMoveListFnc(${cNo});" value="이전페이지로">
			</div>
			
		</form>
	</div>
	
</body>
	
</html>


rTitle
rContent