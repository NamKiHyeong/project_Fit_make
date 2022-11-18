<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이템을 추가해줘</title>
<script type="text/javascript">
	function pageMoveListFnc() {
		location.href = "./list.do"
	}
	
</script>
</head>
<body>
	<jsp:include page="../Header.jsp" />
	<div>
		<form action="./addCtr.do" method="post" enctype="multipart/form-data">
			<div>
				파일:<input type="file" name="file">
			</div>
			<div>
				<h3>제품명 : <input type="text" name="iName"></h3>
				<h3>가격 : <input type="number" name="iSellprice"></h3>
				<h3>재고 : <input type="number" name="iCount"></h3>
				<h3>제품상세정보</h3>
				<textarea required name="oneDetail">
					아무거나 한번 처본다
				</textarea>
				
				<input type="submit" value="작성">
				<input type="button" onclick="pageMoveListFnc();" value="이전페이지로">
			</div>
			
		</form>
	</div>
	
</body>
	
</html>