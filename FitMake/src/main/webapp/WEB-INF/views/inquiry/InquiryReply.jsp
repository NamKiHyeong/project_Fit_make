<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/fitmake/resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
			var bNo = $('#bNo').val();
			var i = 1;
			
		$("#AddReplyBtn").on("click", function(){
			var irContent = $('#irContent').val();
			
			$.ajax({
				url : '../reply/add.do',
				type : 'post',
				dataType : 'json',
				data: {
					"bNo" : bNo,
					"irContent" : irContent,
				},
				success : function(data) {
					alert("댓글이 등록되었습니다.");
					location.reload();
				}
			});
		});
		
		$.ajax({
			url : '../reply/list.do',
			type : 'post',
			dataType : 'json',
			data: {
				"bNo" : bNo,
			},
			success : function(replyMapList) {
				var str = "";
				
				$.each(replyMapList, function(key, value){
					
					str += '<div>';
					str += '<input type="text" id="irContent' + i + '" name="irContent"'; 
					str += 'value="' + value.FM_INQUIRY_REPLY_CONTENT + '" readonly="readonly">';
					str += '</div>';
					str += '<div>';
					str += '<input type="text" value="' + value.FM_USER_NICKNAME + '">';
					str += '</div>';
					str += '<div>';
					str += '<input type="text" value="' + value.FM_INQUIRY_REPLY_CRE_DATE + '">';
					str += '</div>';
					
					i++
				});
				
				$("#replyListArea").html(str);
			}
		});
		
		
		
	});
</script>
<style type="text/css">
</style>
<title>댓글</title>
</head>
<body>
	<div>
		<hr>
		<p><span>댓글</span></p>
		<form action="">
			<div>
				<input type="hidden" id="irParentNo" name="irParentNo" value="">
			</div>
			<div>
				<input type="text" id="irContent" name="irContent" value="">
			</div>
			<div>
				<input id="AddReplyBtn" type="button" value="등록하기">
			</div>
		</form>
		<div id="replyListArea">
			
		</div>
	</div>
</body>
</html>