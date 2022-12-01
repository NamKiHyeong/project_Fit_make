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
		$("#addBoardBtn").on("click", function(){
			$("#boardDetailForm").attr("action", "./add.do");
			$("#boardDetailForm").attr("method", "post");
			$("#boardDetailForm").submit();
			
		});
		
	});
</script>
<style type="text/css">
	#boardRootDiv {
		width : 1200px;
		margin: 0px auto;
		align-content: left;
 		align-items: left; 
	}
	#headTitle {
		font-size: 40px;
	}
	#headTable {
		width: 80%;
		margin-top: 5%;
		margin-left: 3%;
		padding-left: 6.5%;
		text-align: left;
	}
	#headHr {
		width: 75%;
		margin-left: 10%;
		margin-top: 2.4%
	}
	
	#fncDiv{
		text-align: right;
		margin-top: 2%; 
	}
	#searchSection {
		float: left;
		width: 40%;
		text-align: left;
		margin-left: 5%;
	}
	#btnSection{
		float: right;
		width: 30%;
		text-align: right;
	}
</style>
<title>주문관리</title>
</head>
<body>

	<jsp:include page="/WEB-INF/views/Header.jsp" />
	
	<div id="boardRootDiv">
	<jsp:include page="../MyPageLeft.jsp" />
		<div id="titleDiv">
			<table id="headTable">
				<tr>
					<th id="headTitle">문의게시판 작성</th>
				</tr>
			</table>
			<hr id="headHr">
		</div>
	</div>
	
	<form id="boardDetailForm">
		<table>
			<tr>
				<td colspan="4">
					제목	<input type="text" name="bTitle" value="">
				</td>
				<td>
					<input type="text" value="${_userDto_.getNickName()}" readonly="readonly"> 
				</td>
				<tr>
					<td colspan="5">
						<textarea name="bContent">
							
						</textarea>
					</td>
				</tr>
				<tr>
					<td>
						
					</td>
					<td>
						<input type="button" id="addBoardBtn" value="작성">
						<input type="button" value="취소">
					</td>
				</tr>
		</table>
	</form>
	
	
</body>
</html>