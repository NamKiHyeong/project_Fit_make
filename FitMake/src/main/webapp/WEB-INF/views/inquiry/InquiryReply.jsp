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
					
					str += '<div class="viewReplyDetail">';
					str += '<table class="replyTable"><tr><td class="replyContent" rowspan="2">' + value.FM_INQUIRY_REPLY_CONTENT + '</td>'
					str += '<td class="replyWriter">' + value.FM_USER_NICKNAME + '</td></tr>';
					str += '<tr><td class="replyDate">' + new Intl.DateTimeFormat('kr').format(value.FM_INQUIRY_REPLY_CRE_DATE) + '</td></tr></table>';
					str += '</div>';
					
					i++
				});
				
				$("#replyListArea").html(str);
			}
		});
	});
</script>
<style type="text/css">
	#addReplyArea{
		width: auto;
		height: 75px;
		position: relative;
		margin: 1px;
	}
	#irContent{
		width: 80%;
		border-radius: 2px;
		height: 50px;
		resize: none;
		position: absolute;
	}
	#AddReplyBtn{
		width : 100px;
		height: 50px;
		position: absolute;
		left: 80%;
 		transform: translate(80%,5%); 
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
	.viewReplyDetail{
		width: 800px;
		position: relative;
		margin: 5px;
	}
	.replyTable{
		width: 800px;
		border-bottom: 1px solid black;
	}
	.replyDate{
		width: 200px;
		text-align: right;
	}
	.replyWriter{
		width: 200px;
		text-align: right;
	}
	.replyContent{
		width: 600px;
		vertical-align: middle;
	}
</style>
<title>FitMake</title>
</head>
<body>
	<div id="inquiryReplyDiv">
		<hr>
		<p>
			<span>댓글</span>
		</p>
		<div id="addReplyArea">
			<div>
				<input type="hidden" id="irParentNo" name="irParentNo" value="">
			</div>
			<div>
				<textarea id="irContent" name="irContent"></textarea>
				<input id="AddReplyBtn" type="button" value="등록하기">
			</div>
		</div>
		<div id="replyListArea">
		</div>
	</div>
</body>
</html>