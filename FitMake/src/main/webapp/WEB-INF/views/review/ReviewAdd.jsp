<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FitMake</title>

<link rel="stylesheet" href="/fitmake/resources/css/reviewOne.css">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		getMyOrderItemListFnc();
	});

	function pageMoveListFnc() {
		location.href = "./list.do";
	}
	function getMyOrderItemListFnc() {
		var oNo = $('#oNo').val();

		$.ajax({
			type : "POST",
			url : "../review/compose.do",
			dataType : "json",
			data : {
				"oNo" : oNo},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			},
			success : function(data) {

				var str = '';

				$.each(data, function(key, value) {

					str += '<option value="' + value.FM_ITEM_NO + '">'
							+ value.FM_ITEM_NAME + '</option>';

				});

				$('#myOrderItem').html(str);
			}
		});
	}
</script>
<style type="text/css">
#raContainerDiv{
	1200px;
}
</style>
</head>
<body>
	<jsp:include page="../Header.jsp" />
	<div style="height: 50px;"></div>
	<div id="raContainerDiv">
		<form action="./addCtr.do" method="post" enctype="multipart/form-data" style="height: 1000px;">
			<input type="hidden" name="uNo" value="${_userDto_.uNo}">
			<input type="hidden" name="oNo" id="oNo" value="${oNo}">
			<div class="diet_wrap">
				<div class="frame">
					<div class="sortImg sort1">
						파일 <input type="file" name="file">
					</div>

					<div class="sortImg sort2">
						<h3>제품</h3>
						<select name="iNo" id="myOrderItem">
						</select>
						<h3>제목</h3>
						<input class="addInfo" type="text" name="rTitle">
						<h3>내용</h3>
						<textarea rows="20" cols="80" name="rContent"></textarea>
						<div id="reviewAddBtnArea">
							<input class="reviewCtr" type="submit" value="작성">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- footer 시작 -->
	
	<jsp:include page="../Footer.jsp" />
	
	<!-- footer 끝 -->
</body>
</html>