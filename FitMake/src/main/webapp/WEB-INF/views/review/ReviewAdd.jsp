<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>

<link rel="stylesheet" href="/fitmake/resources/css/reviewOne.css">

	<script type="text/javascript">
		function pageMoveListFnc(){
			location.href = "./list.do";
		}
	</script>
</head>
<body>
	<jsp:include page="../Header.jsp"/>

	<form action="./addCtr.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="iNo" value="${iNo}">
		<input type="hidden" name="uNo" value="${_userDto_.uNo}">
		<div class="diet_wrap">
		<div class="frame">
			<div class="sortImg sort1">
				파일 <input type="file" name="file">
			</div>
			
			<div class="sortImg sort2">
				<h3>제목</h3>
					<input class="info" type="text" name="rTitle">
				<h3>내용</h3>
					<textarea rows="20" cols="80" name="rContent"></textarea>
				
				<input class="reviewCtr" type="submit" value="작성">
			</div>
		</div>
<!-- 		<input type="button" value="이전페이지로" onclick="pageMoveListFnc();"> -->
		</div>
	</form>
	
</body>
</html>