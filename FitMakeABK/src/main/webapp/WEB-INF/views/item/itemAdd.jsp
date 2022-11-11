<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이템을 추가해줘</title>
<script type="text/javascript">
	function pageMoveListFnc() {
		location.href = '.category.do'
	}
</script>
</head>
<body>
	<jsp:include page="../Header.jsp" />
	<div>
		<div>
		</div>
		<form action="./itemAdd.do" method="post" enctype="multipart/form-data">
			제품명
			가격
			재고
		</form>
	</div>
	
</body>
	
</html>