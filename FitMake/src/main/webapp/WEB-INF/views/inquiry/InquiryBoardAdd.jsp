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
			$("#boardAddForm").attr("action", "./add.do");
			$("#boardAddForm").attr("method", "post");
			$("#boardAddForm").submit();
			
		});
		
	});
</script>
<style type="text/css">
	#boardAddRootDiv {
		display: flex;
		width : 1200px;
		margin: 0px auto;
		justify-content: space-between;
	}
	#inquiryAdd{
		width: 1000px;
	}
	#titleDiv{
		position: relative;
		overflow: hidden;
	}
	#inquiryAddTitle{
		font-size: 26px;
		font-weight: 600;
	}
	#boardAddForm{
		width: 1000px;
	}
	#boardAddDiv{
		padding: 10px;
 		display: flex; 
		flex-direction: column;
		justify-content: space-between;
	}
	#boardAddContentArea{
		width: 950px;
	}
	.BoardAddRight{
		text-align: right;
		width: 300px;
	}
	.BoardAddLeft{
		width: 650px;
	}
	#bContent{
		width: 100%;
	    height: 500px;
	    resize: none;
	}
	#boardAddbtnArea{
		text-align: right;
	}
</style>
<title>FitMake</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="boardAddRootDiv">
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="inquiryAdd">
			<jsp:include page="../MyPageNav.jsp" />
			<div id="titleDiv">
				<p id="inquiryAddTitle">문의 등록</p>
			</div>
		
			<hr id="headHr">
			
			<form id="boardAddForm">
				<div id="boardAddDiv">
					<table id="boardAddTable">
						<tr>
							<td colspan="4" class="BoardAddLeft">
								제목	<input id="bTitle" type="text" name="bTitle" value="" placeholder="제목을 입력해 주세요." style="width: 600px;">
							</td>
							<td class="BoardAddRight">
								<span>
									작성자 <input type="text" value="${_userDto_.getNickName()}" readonly="readonly">
								</span> 
							</td>
						</tr>
						<tr>
							<td colspan="5" id="boardAddContentArea">
								<textarea id="bContent" name="bContent" placeholder="내용을 입력해 주세요."></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="BoardAddLeft">
								
							</td>
							<td id="boardAddbtnArea" class="BoardAddRight">
								<input type="button" id="addBoardBtn" value="작성">
								<input type="button" value="취소">
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>