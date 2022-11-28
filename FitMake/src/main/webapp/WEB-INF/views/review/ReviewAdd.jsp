<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>

	<script type="text/javascript">
		function pageMoveListFnc(){
			location.href = "./list.do";
		}
	</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>

	<form action="./addCtr.do" method="post" enctype="multipart/form-data">
		<div>
		<h3>제목</h3> <input type="text" name="rTitle">
		
		<h3>내용</h3> <textarea rows="40px;" cols="40px;" name="rContent"></textarea>
		</div>
		
		<div>파일</div>
		<input type="file" name="file">
		<input type="submit" value="작성">
		<input type="button" value="이전페이지로" onclick="pageMoveListFnc();">
	</form>
</body>
</html>