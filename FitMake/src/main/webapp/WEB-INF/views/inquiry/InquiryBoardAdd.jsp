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
		$('#addInquiryBtn').on('click', function(){
			$('#inquiryAddForm').attr('action', './add.do');
			$('#inquiryAddForm').attr('method', 'post');
			$('#inquiryAddForm').submit();
		});
		
		$('#addInquiryCancelBtn').on('click', function(){
			location.href='./list.do';
		});
	});
</script>
<style type="text/css">
	#inquiryAddRootDiv {
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
	#inquiryAddForm{
		width: 1000px;
	}
	#inquiryAddDiv{
		padding: 10px;
 		display: flex; 
		flex-direction: column;
		justify-content: space-between;
	}
	#inquiryAddContentArea{
		width: 950px;
	}
	.inquiryAddRight{
		text-align: right;
		width: 300px;
	}
	.inquiryAddLeft{
		width: 650px;
	}
	#bContent{
		width: 100%;
	    height: 500px;
	    resize: none;
	}
	#inquiryAddbtnArea{
		text-align: right;
	}
	.inquiryBtn {
		margin-left: 10px;
		width: 100px;
		background: #d7266d;
		border: 2px solid #d7266d;
		color: #fff;
		text-align: center;
		cursor: pointer;
	}
</style>
<title>FitMake</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/Header.jsp" />
	<div id="inquiryAddRootDiv">
		<jsp:include page="../MyPageLeft.jsp" />
		<div id="inquiryAdd">
			<jsp:include page="../MyPageNav.jsp" />
			<div id="titleDiv">
				<p id="inquiryAddTitle">문의 등록</p>
			</div>
		
			<hr id="headHr">
			
			<form id="inquiryAddForm">
				<div id="inquiryAddDiv">
					<table id="inquiryAddTable">
						<tr>
							<td colspan="4" class="inquiryAddLeft">
								제목	<input id="bTitle" type="text" name="bTitle" value="" placeholder="제목을 입력해 주세요." style="width: 600px;">
							</td>
							<td class="inquiryAddRight">
								<span>
									작성자 <input type="text" value="${_userDto_.getNickName()}" readonly="readonly">
								</span> 
							</td>
						</tr>
						<tr>
							<td colspan="5" id="inquiryAddContentArea">
								<textarea id="bContent" name="bContent" placeholder="내용을 입력해 주세요."></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="inquiryAddLeft">
								
							</td>
							<td id="inquiryAddbtnArea" class="inquiryAddRight">
								<input type="button" class="inquiryBtn" id="addInquiryBtn" value="작성">
								<input type="button" class="inquiryBtn" id="addInquiryCancelBtn" value="취소" >
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>